//
//  AMSignUpSelectViewController.swift
//  artmonious
//
//  Created by Admin on 15/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

class AMSignUpSelectViewController: UIViewController, YSSegmentedControlDelegate {
    
    @IBOutlet weak var innnerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("AMSignUpViewController") as! AMSignUpViewController
        self.addChildViewController(nextViewController)
        nextViewController.didMoveToParentViewController(self)
        
        self.innnerView.addSubview(nextViewController.view)
        
        view.backgroundColor = UIColor (white: 240.0/255.0, alpha: 1)
//        navigationItem.title = "Demo"
        
        let segmented = YSSegmentedControl(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.frame.size.width,
                height: 59),
            titles: [
                "Customer",
                "Artist"
            ],
            action: {
                control, index in
                print ("segmented did pressed \(index)")
        })
        segmented.delegate = self
        view.addSubview(segmented)

    }
    
    func segmentedControlWillPressItemAtIndex(segmentedControl: YSSegmentedControl, index: Int) {
        print ("[Delegate] segmented will press \(index)")
    }
    
    func segmentedControlDidPressedItemAtIndex(segmentedControl: YSSegmentedControl, index: Int) {
        print ("[Delegate] segmented did pressed \(index)")
        
        if(index == 0){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("AMSignUpViewController") as! AMSignUpViewController
            self.addChildViewController(nextViewController)
            nextViewController.didMoveToParentViewController(self)
            self.innnerView.addSubview(nextViewController.view)
        }else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("AMArtistAccountSignUpViewController") as! AMArtistAccountSignUpViewController
            self.addChildViewController(nextViewController)
            nextViewController.didMoveToParentViewController(self)
            self.innnerView.addSubview(nextViewController.view);
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}