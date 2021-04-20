//
//  CategoryVC.swift
//  ingred
//
//  Created by moh on 1/8/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Categorytable: UITableView!
    var activity: UIActivityIndicatorView!
    
    private let categories = [Category(name: "Appetizer", imagename: "app"),
                              Category(name: "Breakfast", imagename: "break"),
                              Category(name: "Dessert", imagename: "dess"),
                              Category(name: "Beverages", imagename: "bev"),
                              Category(name: "Main Dish", imagename: "m1"),
                              Category(name: "Pasta", imagename: "p2"),
                              Category(name: "Salad", imagename: "s1"),
                              Category(name: "Soup", imagename: "so3")]
    var selectedCat: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Categorytable.delegate = self
        Categorytable.dataSource = self
        self.navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search.png"), style: .plain, target: nil, action: nil)
        showactivity()
        navigationController?.makenavbarinvisible()
    }
    func showactivity() {
        activity = UIActivityIndicatorView(style: .large)
        activity.center = view.center
        self.view.addSubview(activity)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Categorytable.dequeueReusableCell(withIdentifier: "catcell") as? CategoriesCell else { return UITableViewCell() }
        cell.updateviews(category: categories[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activity.startAnimating()
        selectedCat = categories[indexPath.row]
        Alamofirec.getrecipes(forcategory: selectedCat.name) { (recipes) in
            self.performSegue(withIdentifier: "catopenseg", sender: recipes)
            self.activity.stopAnimating()
        }
//        FetchApi.instance.getrecipes(forcategory: selectedCat.name) { (comp) in
//            if comp {
//                FetchApi.instance.downloadimages { (don) in
//                    if don {
//                        FetchApi.instance.addimagestorecip()
//                        self.performSegue(withIdentifier: "catopenseg", sender: FetchApi.instance.RecipesArr)
//                    }
//                }
//            }
//        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let catopenvc = segue.destination as? CategoryopenVC {
            catopenvc.Setdata(recipesarr: sender as! [Recipe], cat: selectedCat)
        }
        
    }
    


}
