//
//  AMHomeViewController.swift
//  artmonious
//
//  Created by Admin on 16/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit
import Koloda

var numberOfCards: UInt = 5

class AMHomeViewController: UIViewController, ArtImageInfoViewControllerDelegate {
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    @IBOutlet weak var item1: UITabBarItem!
//    @IBOutlet weak var imageNumber: UILabel!
    
    
    private var dataSource: Array<UIImage> = {
        var array: Array<UIImage> = []
        for index in 0..<numberOfCards {
            array.append(UIImage(named: "Card_like_\(index + 1)")!)
        }
        
        return array
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
    }
    
    
    @IBAction func btnFollowClicked() {
        
        kolodaView?.swipe(SwipeResultDirection.Right)
        self.tabBarController?.selectedIndex = 1
        
    }

    @IBAction func btnUnfollowClicked() {
        kolodaView?.swipe(SwipeResultDirection.Left)

    }
    
    
    //MARK : ImageDetailViewControllerDelegate
    func dismissThisViewController(currentVC : ArtImageInfoViewController)
    {
        currentVC.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}



//MARK: KolodaViewDelegate
extension AMHomeViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        dataSource.insert(UIImage(named: "Card_like_6")!, atIndex: kolodaView.currentCardIndex - 1)
        let position = kolodaView.currentCardIndex
        kolodaView.insertCardAtIndexRange(position...position, animated: true)
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("ArtImageInfoViewController") as! ArtImageInfoViewController
        nextViewController.delegate = self
        nextViewController.imgInfo = UIImage(named: "Card_like_\(index + 1)")!
        
        self.presentViewController(nextViewController, animated:true, completion:nil)
        
    }
    func koloda(koloda: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection){
        
        if (direction == SwipeResultDirection.Right){
            
            self.tabBarController?.selectedIndex = 1

        }
        else{
            
        }
    }

}

//MARK: KolodaViewDataSource
extension AMHomeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return UInt(dataSource.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
   
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}
