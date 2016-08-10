//
//  IntroScreenContainerScrollView.swift
//  artmonious
//
//  Created by Admin on 18/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

class IntroScreenContainerScrollView: UIScrollView {
    override func touchesShouldCancelInContentView(view: UIView) -> Bool {
       return true
    }
}