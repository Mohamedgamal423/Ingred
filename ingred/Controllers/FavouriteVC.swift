//
//  FavouriteVC.swift
//  ingred
//
//  Created by moh on 1/8/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class FavouriteVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var FavouriteTable: UITableView!
    var recipesarr = [Recipe]()
    var seaarr = [Recipe]()
    var searchcon = UISearchController(searchResultsController: nil)
    var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouriteTable.delegate = self
        FavouriteTable.dataSource = self
        let cellnib = UINib(nibName: "RecipeCell", bundle: nil)
        FavouriteTable.register(cellnib, forCellReuseIdentifier: "favcell")
        //navigationItem.backBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search.png"), style: .plain, target: self, action: #selector(presentsearchbar))
        navigationController?.makenavbarinvisible()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if recipesarr.count == 0 {
            showactivity()
        }
        //showactivity()
        DataService.instance.getfavrecipes(uid: (Auth.auth().currentUser?.uid)!) { (recipes) in
            self.recipesarr = recipes
            self.FavouriteTable.reloadData()
            self.activity.stopAnimating()
        }
    }
    @objc func presentsearchbar() {
        
        searchcon.searchResultsUpdater = self
        searchcon.searchBar.delegate = self
        searchcon.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchcon
        searchcon.hidesNavigationBarDuringPresentation = true
        searchcon.definesPresentationContext = true
        present(searchcon, animated: true, completion: nil)
    }
    func showactivity() {
        activity = UIActivityIndicatorView(style: .large)
        activity.center = view.center
        self.view.addSubview(activity)
        activity.startAnimating()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchcon.isActive && searchcon.searchBar.text != "" {
            return seaarr.count
        }
        return recipesarr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favcell = FavouriteTable.dequeueReusableCell(withIdentifier: "favcell") as? RecipeCell else { return UITableViewCell() }
        var recip: Recipe!
        if searchcon.isActive && searchcon.searchBar.text != "" {
            recip = seaarr[indexPath.row]
        }
        else {
            recip = recipesarr[indexPath.row]
        }
        favcell.updateviews(recipe: recip)
        return favcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "revop", sender: recipesarr[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let Recopenvc = segue.destination as? RecipeopenVC {
            Recopenvc.setdata(rec: sender as! Recipe)
        }
    }
    
}
extension FavouriteVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchedtext = searchController.searchBar.text {
           seaarr = recipesarr.filter { (rec) -> Bool in
            rec.name.contains(searchedtext)
            }
            self.FavouriteTable.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
    }
    
}
