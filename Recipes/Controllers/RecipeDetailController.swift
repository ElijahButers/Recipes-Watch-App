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
@IBOutlet var table: WKInterfaceTable!
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

enum RecipeDetailSelection: Int {
  case Ingredients = 0, Steps
}

class RecipeDetailController: UIViewController {

  var recipe: Recipe?
  var initialController: RecipeDetailSelection = .Ingredients
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!

  lazy var ingredientsController: RecipeIngredientsController! = {
    let controller = self.storyboard?.instantiateViewControllerWithIdentifier("RecipeIngredientsController") as? RecipeIngredientsController
    controller?.recipe = self.recipe
    controller?.tableView.contentInset = self.tableInsets
    return controller
  }()

  lazy var stepsController: RecipeDirectionsController! = {
    let controller = self.storyboard?.instantiateViewControllerWithIdentifier("RecipeDirectionsController") as? RecipeDirectionsController
    controller?.recipe = self.recipe
    controller?.tableView.contentInset = self.tableInsets
    return controller
  }()

  // don't rely on automaticallyAdjustsScrollViewInsets since we're swapping child controllers
  var tableInsets: UIEdgeInsets {
    var insets = UIEdgeInsetsZero
    if let nav = navigationController {
      insets.top = CGRectGetHeight(nav.navigationBar.bounds)
      insets.top += 20 // status bar
    }
    if let tab = tabBarController {
      insets.bottom = CGRectGetHeight(tab.tabBar.bounds)
    }
    return insets
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    segmentedControl.selectedSegmentIndex = initialController.rawValue
    updateSelectedController(initialController)
  }

  @IBAction func onSegmentChange(sender: UISegmentedControl) {
    if let index = RecipeDetailSelection(rawValue: sender.selectedSegmentIndex) {
      updateSelectedController(index)
    } else {
      print("Unsupported recipe detail selection \(sender.selectedSegmentIndex)")
      abort()
    }
  }

  func updateSelectedController(selected: RecipeDetailSelection) {
    switch selected {
    case .Ingredients:
      addSubViewController(ingredientsController)
      stepsController.removeFromSuperViewController()
      break
    case .Steps:
      addSubViewController(stepsController)
      ingredientsController.removeFromSuperViewController()
      break
    }
  }

}
