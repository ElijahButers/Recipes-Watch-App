//
//  RecipeDetailController.swift
//  Recipes
//
//  Created by User on 4/26/16.
//  Copyright © 2016 Ray Wenderlich. All rights reserved.
//

import WatchKit
import Foundation


class RecipeDetailController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if let recipe = context as? Recipe {
            let rowTypes: [String] = ["RecipeHeader"] + recipe.steps.map({ _ in "RecipeStep" })
            table.setRowTypes(rowTypes)
            
            for i in 0..<table.numberOfRows {
                let row = table.rowControllerAtIndex(i)
                if let header = row as? RecipeHeaderController {
                    header.titleLabel.setText(recipe.name)
                } else if let step = row as? RecipeStepController {
                    step.stepLabel.setText("\(i). " + recipe.steps[i - 1])
                }
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
