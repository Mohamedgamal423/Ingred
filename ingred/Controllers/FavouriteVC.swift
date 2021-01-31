//
//  FavouriteVC.swift
//  ingred
//
//  Created by moh on 1/8/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class FavouriteVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var FavouriteTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouriteTable.delegate = self
        FavouriteTable.dataSource = self
        let cellnib = UINib(nibName: "RecipeCell", bundle: nil)
        FavouriteTable.register(cellnib, forCellReuseIdentifier: "favcell")
        Alamofire.getrecipes(forcategory: nil) { (completed) in
            Alamofire.downloadimages { (down) in
                if down {
                    
                }
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search.png"), style: .plain, target: self, action: #selector(opensearchbar))
        navigationController?.makenavbarinvisible()
        
    }
    @objc func opensearchbar() {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favcell = FavouriteTable.dequeueReusableCell(withIdentifier: "favcell") else { return UITableViewCell() }
        return favcell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    

   

}
extension FavouriteVC: UISearchBarDelegate {
    
}
