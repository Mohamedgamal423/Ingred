//
//  RecipeopenVC.swift
//  ingred
//
//  Created by moh on 1/18/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit
import Firebase

class RecipeopenVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var RecopenTable: UITableView!
    @IBOutlet weak var Recname: UILabel!
    @IBOutlet weak var Rectime: UILabel!
    @IBOutlet weak var Recservings: UILabel!
    @IBOutlet weak var Recimg: UIImageView!
    
    var recipe: Recipe!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RecopenTable.dataSource = self
        RecopenTable.delegate = self
        
        let headerview = UINib(nibName: "HeaderView", bundle: nil)
        RecopenTable.register(headerview, forHeaderFooterViewReuseIdentifier: "headerview")
        self.navigationItem.leftBarButtonItem = nil
        //navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
        navigationController?.makenavbarinvisible()
        Recname.text = recipe?.name
        Rectime.text = "\(recipe.cooktime) minutes"
        Recservings.text = "\(recipe.servings) people"
        Recimg.image = recipe?.image
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Heart.png"), style: .plain, target: self, action: #selector(uploadrecipes))
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = nil
        
    }
    @objc func uploadrecipes() {
        
        let uid = Auth.auth().currentUser?.uid
        
        if recipe.recid != nil {
            DataService.instance.deleterecipe(uid: uid!, recid: recipe.recid)
        }
        else {
            DataService.instance.SaveFavRecipe(recipe: recipe, uid: (Auth.auth().currentUser?.uid)!) { (complete) in
                if complete {
                    print("successfully uploaded recipe")
                }
                else {
                    print("error to uploading recipe")
                }
            }
        }
        
    }
    func setdata(rec: Recipe) {
        recipe = rec

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recipe.ingredients.count
        }
        else {
            return recipe.instructions.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingred") as? IngredCell else {return UITableViewCell()}
            cell.updateview(ingred: recipe.ingredients[indexPath.row])
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "instruct") as? InstructCell else {return UITableViewCell()}
            cell.Stepnumb.text = "\(indexPath.row + 1)"
            cell.updateview(instruct: recipe.instructions[indexPath.row])
            return cell
        }
         
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerview") as? HeaderView else { return UITableViewHeaderFooterView() }
        headerview.HeaderLabel.textAlignment = .center
        headerview.HeaderLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        //headerview.contentView.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        if section == 0 {
            headerview.HeaderLabel.text = "INGREDIENTS"
            
        }
        else {
            headerview.HeaderLabel.text = "INSTRUCTIONS"
        }
        return headerview
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 30
        }
        else {
            return 65
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
    

    

}
