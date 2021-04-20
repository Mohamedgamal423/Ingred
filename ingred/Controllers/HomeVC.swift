//
//  HomeVC.swift
//  ingred
//
//  Created by moh on 1/8/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var HomeTable: UITableView!
    
    var Featuredrecipes = [Recipe]()
    var Latestrecipes = [Recipe]()
    var seaarr = [Recipe]()
    var searchcon = UISearchController(searchResultsController: nil)
    var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultsetup()
        HomeTable.delegate = self
        HomeTable.dataSource = self
        let cellnib = UINib(nibName: "RecipeCell", bundle: nil)
        HomeTable.register(cellnib, forCellReuseIdentifier: "homecell")
        let featuredcellnib = UINib(nibName: "FeaturedCell", bundle: nil)
        HomeTable.register(featuredcellnib, forCellReuseIdentifier: "featuredcell")
        let headerview = UINib(nibName: "HeaderView", bundle: nil)
        HomeTable.register(headerview, forHeaderFooterViewReuseIdentifier: "header")
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showactivity()
        Alamofirec.getrecipes(forcategory: "dinner") { (recipes) in
            let x = Alamofirec.FeatlatestRecipesArr(Recipes: recipes)
            self.Featuredrecipes = x.0
            self.Latestrecipes = x.1
            self.HomeTable.reloadData()
            self.activity.stopAnimating()
        }
    }
    func showactivity() {
        activity = UIActivityIndicatorView(style: .large)
        activity.center = view.center
        self.view.addSubview(activity)
        activity.startAnimating()
    }
    func defaultsetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Notifications.png"), style: .plain, target: nil, action: nil)
        navigationController?.makenavbarinvisible()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search.png"), style: .plain, target: self, action: #selector(presentsearchbar))
        navigationItem.title = "INGRED"
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
}
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if searchcon.isActive && searchcon.searchBar.text != "" {
            return seaarr.count
        }
        
        return Latestrecipes.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 190
        }
        else {
            return 260
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let featuredcell = HomeTable.dequeueReusableCell(withIdentifier: "featuredcell") as? FeaturedCell else {return UITableViewCell()}
            let featuredcollcell = UINib(nibName: "FeaturedCollectionCell", bundle: nil)
            featuredcell.CollectionView.delegate = self
            featuredcell.CollectionView.dataSource = self
            featuredcell.CollectionView.register(featuredcollcell, forCellWithReuseIdentifier: "featuredcollcell")
            featuredcell.CollectionView.reloadData()
            return featuredcell
        }
            
        guard let homecell = HomeTable.dequeueReusableCell(withIdentifier: "homecell") as? RecipeCell else {return UITableViewCell()}
        var recip: Recipe!
        if searchcon.isActive && searchcon.searchBar.text != "" {
            recip = seaarr[indexPath.row]
        }
        else {
            recip = Latestrecipes[indexPath.row]
        }
        homecell.updateviews(recipe: recip)
        return homecell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = HomeTable.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HeaderView
        if section == 1 {
            headerview?.HeaderLabel.text = "LATEST"
            return headerview
        }
        else {
            return nil
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNonzeroMagnitude
        }
        return 35
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openrec", sender: Latestrecipes[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let Recopenvc = segue.destination as? RecipeopenVC {
            Recopenvc.setdata(rec: sender as! Recipe)
        }
    }
    
    
}
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Featuredrecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let featuredcollcell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredcollcell", for: indexPath) as? FeaturedCollectionCell else {return UICollectionViewCell()}
        featuredcollcell.updateviews(recipe: Featuredrecipes[indexPath.row])
        return featuredcollcell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openrec", sender: Featuredrecipes[indexPath.row])
    }
    
}
extension HomeVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchedtext = searchController.searchBar.text {
           seaarr = Latestrecipes.filter { (rec) -> Bool in
            rec.name.contains(searchedtext)
            }
            self.HomeTable.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
    }
    
    
}
