//
//  AMSettingsViewController.swift
//  artmonious
//
//  Created by Admin on 17/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

class AMSettingsViewController: UIViewController {
    @IBOutlet weak var item1: UITabBarItem!
    @IBOutlet weak var hlayoutscrollV: NSLayoutConstraint!
    
    @IBOutlet weak var scrollV: UIScrollView!
    @IBOutlet weak var hLayoutV: NSLayoutConstraint!
    @IBOutlet weak var ContainerV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hlayoutscrollV.constant = 200
        self.hLayoutV.constant = 200
    
//                item1.imageInsets = UIEdgeInsetsMake(35, 15, 15, 15)
    }
    
    
}