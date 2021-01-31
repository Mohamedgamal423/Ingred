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
    var Favourites: DatabaseReference {
        return _Favourites
    }
    func CreateDBUser(uid: String, userdata: Dictionary<String, String>) {
        Users.child(uid).updateChildValues(userdata)
    }
//    func SaveRecipe(Favrecipes: Dictionary<String, AnyObject>, savcomplete: @escaping (_ status: Bool) -> ()) {
//        Favourites.childByAutoId().updateChildValues(Favrecipes)
//        savcomplete(true)
//    }
    func SaveFavRecipe(recipe: Recipe, uid: String, savcomplete: @escaping (_ status: Bool) -> ()) {
        //let recdata: [String: Any] = ["name" : recipe.name, "ingredients" : recipe.ingredients, "instructions": recipe.instructions, "image": (recipe.image?.jpegData(compressionQuality: 0.75))!]
        Favourites.child(uid).updateChildValues(["name" : recipe.name, "ingredients" : recipe.ingredients, "instructions": recipe.instructions])
        savcomplete(true)
    }
    
}
