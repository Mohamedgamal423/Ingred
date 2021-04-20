//
//  CategoryopenVC.swift
//  ingred
//
//  Created by moh on 1/18/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class CategoryopenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var CatopenTable: UITableView!
    @IBOutlet weak var catimg: UIImageView!
    @IBOutlet weak var catname: UILabel!
    
    var recipesArr = [Recipe]()
    var selected: Category!
    var searchcon = UISearchController(searchResultsController: nil)
    var seaarr = [Recipe]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        CatopenTable.delegate = self
        CatopenTable.dataSource = self
        let cellnib = UINib(nibName: "RecipeCell", bundle: nil)
        CatopenTable.register(cellnib, forCellReuseIdentifier: "cell")
        self.navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search.png"), style: .plain, target: self, action: #selector(presentsearchbar))
        navigationController?.makenavbarinvisible()
        catname.text = selected.name
        catimg.image = UIImage(named: selected.imagename)
    }
    
    func Setdata(recipesarr: [Recipe], cat: Category) {
        recipesArr = recipesarr
        selected = cat
//        catname.text = cat.name
//        catimg.image = UIImage(named: cat.imagename)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchcon.isActive && searchcon.searchBar.text != "" {
            return seaarr.count
        }
        return recipesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catcell = CatopenTable.dequeueReusableCell(withIdentifier: "cell") as? RecipeCell else {return UITableViewCell()}
        var recipe: Recipe!
        if searchcon.isActive && searchcon.searchBar.text != "" {
            recipe = seaarr[indexPath.row]
        }
        else {
            recipe = recipesArr[indexPath.row]
        }
        catcell.updateviews(recipe: recipe)
        return catcell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "recopen", sender: recipesArr[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recopenvc = segue.destination as? RecipeopenVC {
            recopenvc.setdata(rec: sender as! Recipe)
        }
    }
    

}

extension CategoryopenVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchedtext = searchController.searchBar.text {
           seaarr = recipesArr.filter { (rec) -> Bool in
            rec.name.contains(searchedtext)
            }
            self.CatopenTable.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
    }
    
}
