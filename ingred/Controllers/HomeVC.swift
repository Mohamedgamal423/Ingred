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
    override func viewDidAppear(_ animated: Bool) {
        Alamofire.getrecipes(forcategory: "dinner") { (success) in
            if success {
                Alamofire.downloadimages { (downloaded) in
                    if downloaded {
                        Alamofire.addimagestorecip()
                        //print(Alamofire.RecipesArr.count)
                        let x = Alamofire.FeatlatestRecipesArr()
                        self.Featuredrecipes = x.0
                        self.Latestrecipes = x.1
                        self.HomeTable.reloadData()
                        
                        
                        
                    }
                }
            }
        }
    }
    func defaultsetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Notifications.png"), style: .plain, target: nil, action: nil)
        navigationController?.makenavbarinvisible()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search.png"), style: .plain, target: nil, action: nil)
        navigationItem.title = "INGRED"
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
        else {
            return Latestrecipes.count
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
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
            
        else {
        guard let homecell = HomeTable.dequeueReusableCell(withIdentifier: "homecell") as? RecipeCell else {return UITableViewCell()}
        homecell.updateviews(recipe: Latestrecipes[indexPath.row])
        return homecell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = HomeTable.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HeaderView
        if section == 0 {
            headerview?.HeaderLabel.text = "FEATURED RECIPES"
        }
        else {
            headerview?.HeaderLabel.text = "LATEST"
        }
        return headerview
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openrec", sender: Latestrecipes[indexPath.row])
        
//        guard let recopenvc = storyboard?.instantiateViewController(identifier: "recopen") as? RecipeopenVC else { return }
//        recopenvc.setdata(rec: Latestrecipes[indexPath.row])
//        present(recopenvc, animated: true, completion: nil)
        
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
        return CGSize(width: 250, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openrec", sender: Featuredrecipes[indexPath.row])
    }
    
    
    
    
}
