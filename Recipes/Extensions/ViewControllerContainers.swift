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

extension UIViewController {

  func addSubViewController(controller: UIViewController) {
    addChildViewController(controller)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(controller.view)

    view.addConstraint(NSLayoutConstraint(item: controller.view,
      attribute: .Trailing, relatedBy: .Equal, toItem: view,
      attribute: .Trailing, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: controller.view,
      attribute: .Leading, relatedBy: .Equal, toItem: view,
      attribute: .Leading, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: controller.view,
      attribute: .Top, relatedBy: .Equal, toItem: view,
      attribute: .Top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: controller.view,
      attribute: .Bottom, relatedBy: .Equal, toItem: view,
      attribute: .Bottom, multiplier: 1, constant: 0))

    controller.didMoveToParentViewController(self)
  }

  func removeFromSuperViewController() {
    willMoveToParentViewController(nil)
    view.removeFromSuperview()
    removeFromParentViewController()
  }

}
