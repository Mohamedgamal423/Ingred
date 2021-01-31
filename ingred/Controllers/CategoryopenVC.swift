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
    
    var recipesArr = [Recipe]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CatopenTable.delegate = self
        CatopenTable.dataSource = self
        let cellnib = UINib(nibName: "RecipeCell", bundle: nil)
        CatopenTable.register(cellnib, forCellReuseIdentifier: "cell")
        self.navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search.png"), style: .plain, target: nil, action: nil)
        navigationController?.makenavbarinvisible()
    }
    func Setdata(recipesarr: [Recipe]) {
        recipesArr = recipesarr
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catcell = CatopenTable.dequeueReusableCell(withIdentifier: "cell") as? RecipeCell else {return UITableViewCell()}
        catcell.updateviews(recipe: recipesArr[indexPath.row])
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
