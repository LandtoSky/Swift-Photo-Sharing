//
//  TabbarViewController.swift
//  artmonious
//
//  Created by Admin on 17/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = self.tabBar as UITabBar
        
        for item in tabBar.items! {
            if let image = item.image {
                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        self.tabBar.tintColor = UIColor(red: 114/255.0, green: 187/255.0, blue: 230/255.0, alpha: 1.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
    }
    
    //Delegate methods
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }
}