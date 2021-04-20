//
//  DataService.swift
//  ingred
//
//  Created by moh on 1/24/20.
//  Copyright © 2021 moh. All rights reserved.
//

import Foundation
import Firebase

let DB = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _Users = DB.child("users")
    private var _Favourites = DB.child("favourites")
    
    var Users: DatabaseReference {
        return _Users
    }
    public var Favourites: DatabaseReference {
        return _Favourites
    }
    func CreateDBUser(uid: String, userdata: Dictionary<String, String>) {
        Users.child(uid).updateChildValues(userdata)
    }
    

    func SaveFavRecipe(recipe: Recipe, uid: String, savcomplete: @escaping (_ status: Bool) -> ()) {
        
        let recdata: [String: Any] = ["name" : recipe.name, "ingredients" : recipe.ingredients, "instructions": recipe.instructions, "imagurl": recipe.imageurl, "cooktime": recipe.cooktime, "servings": recipe.servings, "dishtypes": recipe.dishtypes]
        Favourites.child(uid).childByAutoId().updateChildValues(recdata)
        savcomplete(true)
    }
    func getfavrecipes(uid: String, favrecarr: @escaping(_ recarr: [Recipe]) -> ()) {
        
        var recipesarr = [Recipe]()
        Favourites.child(uid).observeSingleEvent(of: .value) { (datasnaps) in
            guard let favsnapshots = datasnaps.children.allObjects as? [DataSnapshot] else {return}
            for favrec in favsnapshots {
                
                let urlstr = favrec.childSnapshot(forPath: "imagurl").value as! String
                let url = URL(string: urlstr)
                let ingred = favrec.childSnapshot(forPath: "ingredients").value as! [String]
                let instructions = favrec.childSnapshot(forPath: "instructions").value as? [String] ?? [""]
                let name = favrec.childSnapshot(forPath: "name").value as! String
                let servings = favrec.childSnapshot(forPath: "servings").value as! Int
                let cooktime = favrec.childSnapshot(forPath: "cooktime").value as! Int
                let dishtypes = favrec.childSnapshot(forPath: "dishtypes").value as! [String]
                if let imdata = NSData(contentsOf: url!) {
                    if let image = UIImage(data: imdata as Data) {
                        let recipe = Recipe(name: name, cooktime: cooktime, servings: servings, ingredients: ingred, method: instructions, imageurl: "", image: image, dishtypes: dishtypes, id: favrec.key)
                        recipesarr.append(recipe)
                    }
                }
                if recipesarr.count == favsnapshots.count {
                    favrecarr(recipesarr)
                }
                
            }
            
        }
    }
    func deleterecipe(uid: String, recid: String) {
        Favourites.child(uid).child(recid).removeValue()
    }
    
    func GetRecipes(uid: String, favrecarr: @escaping(_ recarr: [Recipe]) -> ()) {
        var recipesarr = [Recipe]()
        Favourites.child(uid).observe(.value) { (snapshot) in
            guard let favsnapshots = snapshot.children.allObjects as? [DataSnapshot] else {return}
            for favrec in favsnapshots {
                
                let urlstr = favrec.childSnapshot(forPath: "imagurl").value as! String
                let url = URL(string: urlstr)
                let ingred = favrec.childSnapshot(forPath: "ingredients").value as! [String]
                let instructions = favrec.childSnapshot(forPath: "instructions").value as! [String]
                let name = favrec.childSnapshot(forPath: "name").value as! String
                let servings = favrec.childSnapshot(forPath: "servings").value as! Int
                let cooktime = favrec.childSnapshot(forPath: "cooktime").value as! Int
                let dishtypes = favrec.childSnapshot(forPath: "dishtypes").value as! [String]
                if let imdata = NSData(contentsOf: url!) {
                    if let image = UIImage(data: imdata as Data) {
                        let recipe = Recipe(name: name, cooktime: cooktime, servings: servings, ingredients: ingred, method: instructions, imageurl: "", image: image, dishtypes: dishtypes, id: favrec.key)
                        recipesarr.append(recipe)
                    }
                }
                if recipesarr.count == favsnapshots.count {
                    favrecarr(recipesarr)
                }
                
            }
        }
    }
    func deletefavourirtes() {
        Favourites.removeValue()
    }
    
}
