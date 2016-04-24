/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation

private let kRecipesFileName = "Recipes"
private let kRecipesFileExtension = "json"

public class RecipeStore {

  public lazy var recipes: [Recipe] = {
    var recipes = [Recipe]()
    if let data = NSData(contentsOfURL: self.savedRecipesURL) {
      recipes = self.recipesFromData(data)
    }
    return recipes
    }()

  // MARK: Private
  
  private func recipesFromData(data: NSData) -> [Recipe] {
    var newRecipes = [Recipe]()
    let json = JSON(data: data)
    
    // turn all of the recipe data into Recipe objects
    for (_, recipeJSON) in json {
      // all keys are required
      let imageURL = recipeJSON["imageURL"].stringValue
      let originalURL = recipeJSON["originalURL"].stringValue
      let name = recipeJSON["name"].stringValue
      
      // get all of the recipe's ingredients
      var ingredients = [Ingredient]()
      for (_, ingredientJSON) in recipeJSON["ingredients"] {
        // all keys are required
        let quantity = ingredientJSON["quantity"].stringValue
        let name = ingredientJSON["name"].stringValue
        let type = IngredientType(rawValue: ingredientJSON["type"].stringValue)
        
        if type == nil {
          let t = ingredientJSON["type"]
          print("Invalid type \(t)")
        }
        
        ingredients.append(Ingredient(quantity: quantity, name: name, type: type!))
      }
      
      // get all of the recipe's steps
      var steps = [String]()
      for (_, stepJSON) in recipeJSON["steps"] {
        steps.append(stepJSON.stringValue)
      }
      
      // get all of the recipe's timers
      // these should be 1:1 to steps
      var timers = [Int]()
      for (_, timerJSON) in recipeJSON["timers"] {
        timers.append(timerJSON.intValue)
      }
      
      assert(steps.count == timers.count, "Steps and timers are not 1:1 for recipe \(name). Have \(steps.count) steps and \(timers.count) timers.")
      
      newRecipes.append(Recipe(
        name: name,
        ingredients: ingredients,
        steps: steps,
        timers: timers,
        imageURL: NSURL(string: imageURL),
        originalURL: NSURL(string: originalURL))
      )
    }
    
    // sort alphabetically
    return newRecipes.sort({ $0.name < $1.name })
  }

  private let savedRecipesURL: NSURL = {
    var docURL = NSURL()
    if let bundledRecipes = NSBundle(forClass: RecipeStore.self).URLForResource(kRecipesFileName, withExtension: kRecipesFileExtension) {
      docURL = bundledRecipes
    }
    return docURL
    }()

}