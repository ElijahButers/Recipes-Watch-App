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

class RecipeIngredientsController: UITableViewController {

  @IBOutlet weak var bannerView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!

  var selectedIngredientPaths = [NSIndexPath]()
  var recipe: Recipe?
  var originalHeaderHeight: CGFloat = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    originalHeaderHeight = headerHeightConstraint.constant

    titleLabel.text = recipe?.name
    if let url = recipe?.imageURL {
      bannerView.sd_setImageWithURL(url)
    }
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  // MARK: UITableViewDataSource

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipe?.ingredients.count ?? 0
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RecipeIngredientsCell", forIndexPath: indexPath) as UITableViewCell

    if let item = recipe?.ingredients[indexPath.row] {
      let text = "\(item.quantity) \(item.name)"

      var attributes: [String: AnyObject] = [NSFontAttributeName: UIFont.systemFontOfSize(17)];

      // lighten and strikethrough the ingredient if we have added it
      if selectedIngredientPaths.contains(indexPath) {
        attributes[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
        attributes[NSStrikethroughStyleAttributeName] = NSUnderlineStyle.StyleSingle.rawValue
      } else {
        attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
      }

      cell.textLabel?.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    return cell
  }

  // MARK: UITableViewDelegate

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let index = selectedIngredientPaths.indexOf(indexPath) {
      selectedIngredientPaths.removeAtIndex(index)
    } else {
      selectedIngredientPaths.append(indexPath)
    }
    tableView.reloadData()
  }

  // MARK: UIScrollViewDelegate

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    headerHeightConstraint.constant = originalHeaderHeight - scrollView.contentOffset.y
  }

}
