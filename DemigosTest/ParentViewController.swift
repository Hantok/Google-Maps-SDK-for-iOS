//
//  ParentViewController.swift
//  DemigosTest
//
//  Created by Roman Slysh on 12/1/15.
//  Copyright © 2015 Roman Slysh. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //remove text from backBarButtonItem
    if let topItem = self.navigationController?.navigationBar.topItem {
      topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}