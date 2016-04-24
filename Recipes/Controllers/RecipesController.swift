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

import UIKit

class RecipesController: UITableViewController {

    @IBOutlet var table: WKInterfaceTable!
  var recipeStore = RecipeStore()

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let identifier = segue.identifier

    if identifier == "RecipeDetailSegue" {
      // pass through the selected recipe
      if let path = tableView.indexPathForSelectedRow {
        let recipe = recipeStore.recipes[path.row]
        let destination = segue.destinationViewController as! RecipeDetailController
        destination.recipe = recipe
      }
    }
  }

  // MARK: UITableViewDataSource

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipeStore.recipes.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeCell
    let recipe = recipeStore.recipes[indexPath.row]
    cell.recipeLabel.text = recipe.name
    if let url = recipe.imageURL {
      cell.thumbnailView.sd_setImageWithURL(url)
    }
    return cell
  }

}
