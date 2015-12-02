//
//  FirstViewController.swift
//  DemigosTest
//
//  Created by Roman Slysh on 11/30/15.
//  Copyright © 2015 Roman Slysh. All rights reserved.
//

import UIKit

class FirstViewController: ParentViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let mainController = UIApplication.sharedApplication().keyWindow!.rootViewController as! UITabBarController
    let label: UILabel = UILabel()
    label.text = "ИСЧО"
    label.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
    label.textAlignment = .Center
    mainController.moreNavigationController.navigationBar.topItem!.titleView = label
    
    for var i = 0; i < mainController.tabBar.items?.count; i++ {
      if mainController.tabBar.items![i].title == nil {
        let moreTabBarItem = mainController.tabBar.subviews[++i]
        for var j = 0; j < moreTabBarItem.subviews.count; j++ {
          if moreTabBarItem.subviews[j] is UILabel {
            let label = moreTabBarItem.subviews[j] as! UILabel
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.1
            moreTabBarItem.subviews[j].setValue("ИСЧО", forKey: "text")
            break
          }
        }
        break
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

