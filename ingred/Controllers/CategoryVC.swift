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
    private let categories = [Category(name: "Appetizer", imagename: "rt.jpg"),
                              Category(name: "Breakfast and Brunch", imagename: "rt.jpg"),
                              Category(name: "Dessert", imagename: "rt.jpg"),
                              Category(name: "Beverages", imagename: "rt.jpg"),
                              Category(name: "Main Dish", imagename: "rt.jpg"),
                              Category(name: "Pasta", imagename: "rt.jpg"),
                              Category(name: "Salad", imagename: "rt.jpg"),
                              Category(name: "Soup", imagename: "rt.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
        Categorytable.delegate = self
        Categorytable.dataSource = self
        self.navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search.png"), style: .plain, target: nil, action: nil)
        
        navigationController?.makenavbarinvisible()
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
        Alamofire.getrecipes(forcategory: categories[indexPath.row].name) { (getted) in
            if getted {
                Alamofire.downloadimages { (downloaded) in
                    if downloaded {
                        Alamofire.addimagestorecip()
                        self.performSegue(withIdentifier: "catopenseg", sender: Alamofire.RecipesArr)
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let catopenvc = segue.destination as? CategoryopenVC {
            catopenvc.Setdata(recipesarr: sender as! [Recipe])
            
        }
        
    }
    


}
