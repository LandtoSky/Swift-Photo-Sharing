//
//  File.swift
//  artmonious
//
//  Created by Admin on 01/10/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

protocol ImageDetailedViewControllerDelegate {
    func dismissThisViewController(currentVC : ImageDetailedViewController)
}

class ImageDetailedViewController: UIViewController, UIScrollViewDelegate {
    
    var delegate : ImageDetailedViewControllerDelegate? = nil
    
    
    var  detailImg : UIImage!
    var tmpimageV : UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delaysContentTouches = false
        self.scrollView.canCancelContentTouches = true
        self.scrollView.exclusiveTouch = true
        self.scrollView.userInteractionEnabled = true
        scrollView.contentSize.height = 900
        containerView.frame.size.height = 900
        
        
//        self.view.frame.size.height
        
        
        
        tmpimageV = UIImageView(image: detailImg)
        let vWidth = self.detailView.frame.width
        let vHeight = self.detailView.frame.height
        
        
        tmpimageV.frame = CGRectMake(0, 200, self.view.frame.size.width, detailImg.size.height * self.view.frame.size.width / detailImg.size.width)
        
        let scrollImg: UIScrollView = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRectMake(0, 0, vWidth, vHeight)
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = true
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0

        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageDetailedViewController.tappedMe))
        tmpimageV.addGestureRecognizer(tap)
        tmpimageV.userInteractionEnabled = true
        
        scrollImg.addSubview(tmpimageV!)
        self.detailView.addSubview(scrollImg)
//        self.containerView.addSubview(btnBack)
        
    }
    
    func tappedMe()
    {
        print("Tapped on Image")
        if (self.delegate != nil) {
            self.delegate?.dismissThisViewController(self)
        }
        else{
            print("Tapped dsadfsdasdfa")
        }
        
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.tmpimageV
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}