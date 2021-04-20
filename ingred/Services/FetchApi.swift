//
//  FetchApi.swift
//  ingred
//
//  Created by moh on 4/10/21.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FetchApi {
    
//   public private(set) var ingredientsArr = [String]()
//   public private(set) var instructionsArr = [String]()
   public private(set) var RecipesArr = [Recipe2]()
   public private(set) var imagesurlArr = [String]()
   public private(set) var imagesArr = [UIImage]()
   public private(set) var featuredrecipes = [Recipe2]()
   public private(set) var latestrecipes = [Recipe2]()
    
    static let instance = FetchApi()
    
    func FeatlatestRecipesArr(Recipes: [Recipe2]) -> ([Recipe2], [Recipe2]) {
        featuredrecipes = []
        latestrecipes = []
        for (index, _) in Recipes.enumerated() {
            if index < 4 {
                featuredrecipes.append(RecipesArr[index])
                //RecipesArr.remove(at: index)
            }
            else {
                latestrecipes.append(RecipesArr[index])
                //RecipesArr.remove(at: index)
            }
        }
        return (featuredrecipes, latestrecipes)
    }
    func addimagestorecip() {
        for (index, recip) in RecipesArr.enumerated() {
            recip.image = imagesArr[index]
        }
    }
    func downloadimages(handler: @escaping (_ status: Bool) -> ()) {
        imagesArr = []
        for url in imagesurlArr {
            AF.request(url).responseImage { (response) in
                guard let image = response.value else { return }
                self.imagesArr.append(image)
                if self.imagesArr.count == self.imagesurlArr.count {
                    handler(true)
                }
                
            }
        }
    }
    func geturl(category: String?) -> String {
        if category == nil {
            return "https://api.spoonacular.com/recipes/random?apiKey=\(Api_keyArr[1])&instructionsRequired=true&fillIngredients=true&number=10&addRecipeInformation=true"
        }
        else {
            
            return "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(Api_keyArr[1])&query=\(category!)&instructionsRequired=true&fillIngredients=true&number=10&addRecipeInformation=true"
        }
        
    }
    func getrecipes(forcategory category: String?, handler: @escaping (_ status: Bool) -> ()) {
        
        var ingredientsArr = [String]()
        var instructionsArr = [String]()
        
        RecipesArr = []
        imagesurlArr = []
        
        AF.request(geturl(category: category)).responseJSON { (reponse) in
            guard let json = reponse.value as? Dictionary<String, AnyObject> else { return }
            var resultsArr = [Dictionary<String, AnyObject>]()
            if category == nil {
                resultsArr = json["recipes"] as! [Dictionary<String, AnyObject>]
            }
            else {
                resultsArr = (json["results"] as! [Dictionary<String, AnyObject>])
            }
            for item in resultsArr {
                
                ingredientsArr = []
                instructionsArr = []
                
                let ingredArr = item["extendedIngredients"] as? [Dictionary<String, AnyObject>]
                for ingreditem in ingredArr! {
                    let ingredient = ingreditem["original"] as! String
                    ingredientsArr.append(ingredient)
                }
                let recname = item["title"] as! String
                let servings = item["readyInMinutes"] as! Int
                let cooktime = item["servings"] as! Int
                let imgurl = item["image"] as! String
                self.imagesurlArr.append(imgurl)
                let instructionsarr = item["analyzedInstructions"] as? [Dictionary<String, AnyObject>]
                for instruct in instructionsarr! {
                   let steps = instruct["steps"] as? [Dictionary<String, AnyObject>]
                    for step in steps! {
                       let instruction = step["step"] as! String
                        instructionsArr.append(instruction)
                    }
                }
                let recipe = Recipe2(name: recname, cooktime: cooktime, servings: servings, ingredients: ingredientsArr, method: instructionsArr, imur: imgurl)
                self.RecipesArr.append(recipe)
            }
            handler(true)
            
        }
    
    }
}
