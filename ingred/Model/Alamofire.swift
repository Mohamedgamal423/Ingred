//
//  Alamofire.swift
//  ingred
//
//  Created by moh on 1/16/20.
//  Copyright © 2021 moh. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class Alamofire {
    
    private static var ingredientsArr = [String]()
    private static var instructionsArr = [String]()
    static var RecipesArr = [Recipe]()
    private static var imagesurlArr = [String]()
    private static var imagesArr = [UIImage]()
    private static var featuredrecipes = [Recipe]()
    private static var latestrecipes = [Recipe]()
    
    static func getrecipes(forcategory category: String?, handler: @escaping (_ status: Bool) -> ()) {
        
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
                imagesurlArr.append(imgurl)
                let instructionsarr = item["analyzedInstructions"] as? [Dictionary<String, AnyObject>]
                for instruct in instructionsarr! {
                   let steps = instruct["steps"] as? [Dictionary<String, AnyObject>]
                    for step in steps! {
                       let instruction = step["step"] as! String
                        instructionsArr.append(instruction)
                    }
                }
                let recipe = Recipe(name: recname, cooktime: cooktime, servings: servings, ingredients: ingredientsArr, method: instructionsArr)
                RecipesArr.append(recipe)
            }
            handler(true)
            
        }
    
    }
    static func FeatlatestRecipesArr() -> ([Recipe], [Recipe]) {
        featuredrecipes = []
        latestrecipes = []
        for (index, _) in RecipesArr.enumerated() {
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
    static func addimagestorecip() {
        for (index, recip) in RecipesArr.enumerated() {
            recip.image = imagesArr[index]
        }
    }
    static func downloadimages(handler: @escaping (_ status: Bool) -> ()) {
        imagesArr = []
        for url in imagesurlArr {
            AF.request(url).responseImage { (response) in
                guard let image = response.value else { return }
                imagesArr.append(image)
                if imagesArr.count == imagesurlArr.count {
                    handler(true)
                }
                
            }
        }
    }
    static func geturl(category: String?) -> String {
        if category == nil {
            return "https://api.spoonacular.com/recipes/random?apiKey=5d3bc1355bd74a69a4019408c457d2c1&instructionsRequired=true&fillIngredients=true&number=10&addRecipeInformation=true"
        }
        else {
            
            return "https://api.spoonacular.com/recipes/complexSearch?apiKey=5d3bc1355bd74a69a4019408c457d2c1&query=\(category!)&instructionsRequired=true&fillIngredients=true&number=10&addRecipeInformation=true"
        }
        
    }
}
