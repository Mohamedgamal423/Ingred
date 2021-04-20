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

class Alamofirec {
    
    private static var ingredientsArr = [String]()
    private static var instructionsArr = [String]()
    static var RecipesArr = [Recipe]()
    private static var imagesurlArr = [String]()
    private static var imagesArr = [UIImage]()
    private static var featuredrecipes = [Recipe]()
    private static var latestrecipes = [Recipe]()
    
    
    static func getrecipes(forcategory category: String?, handler: @escaping (_ recipes: [Recipe]) -> ()) {
        
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
                let url = URL(string: imgurl)
                let dishtypes = item["dishTypes"] as! [String]
                //imagesurlArr.append(imgurl)
                let instructionsarr = item["analyzedInstructions"] as? [Dictionary<String, AnyObject>]
                for instruct in instructionsarr! {
                   let steps = instruct["steps"] as? [Dictionary<String, AnyObject>]
                    for step in steps! {
                       let instruction = step["step"] as! String
                        instructionsArr.append(instruction)
                    }
                }
                DispatchQueue.main.async {
                    guard let imdata = NSData(contentsOf: url!) else {return}
                    if let image = UIImage(data: imdata as Data) {
    
                        let recipe = Recipe(name: recname, cooktime: cooktime, servings: servings, ingredients: ingredientsArr, method: instructionsArr, imageurl: imgurl, image: image, dishtypes: dishtypes, id: nil)
                        RecipesArr.append(recipe)
                        if RecipesArr.count == 10 {
                            handler(RecipesArr)
                        }
                    }
                }
                
            }
        }
    
    }
    static func FeatlatestRecipesArr(Recipes: [Recipe]) -> ([Recipe], [Recipe]) {
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
            return "https://api.spoonacular.com/recipes/random?apiKey=\(Api_keyArr[2])&instructionsRequired=true&fillIngredients=true&number=10&addRecipeInformation=true"
        }
        else {
            
            return "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(Api_keyArr[2])&query=\(category!)&instructionsRequired=true&fillIngredients=true&number=10&addRecipeInformation=true"
        }
        
    }
   
    
    
}
