//
//  IntroContainerViewControlelr.swift
//  artmonious
//
//  Created by Admin on 18/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

class IntroContainerViewController: UIViewController, UIScrollViewDelegate {
    
    var page1: UIView!
    var page2: UIView!
    var page3: UIView!
    var page4: UIView!
    var page5: UIView!
    var pageCount = 0

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, self.scrollView.frame.size.height)
        self.scrollView.frame = self.view.frame
        let mainStoryboard = self.storyboard
        
        self.scrollView.delaysContentTouches = false
        self.scrollView.canCancelContentTouches = true
        self.scrollView.exclusiveTouch = true
        self.scrollView.userInteractionEnabled = true
        
        let page1ViewController = mainStoryboard?.instantiateViewControllerWithIdentifier("page1")
        self.page1 = page1ViewController?.view
        self.page1.frame = CGRectMake(0.0, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        self.addChildViewController(page1ViewController!)
        page1ViewController?.didMoveToParentViewController(self)
        
        let page2ViewController = mainStoryboard?.instantiateViewControllerWithIdentifier("page2")
        self.page2 = page2ViewController?.view
        self.page2.frame = CGRectMake(self.scrollView.frame.size.width, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        self.addChildViewController(page2ViewController!)
        page2ViewController?.didMoveToParentViewController(self)
        
        let page3ViewController = mainStoryboard?.instantiateViewControllerWithIdentifier("page3")
        self.page3 = page3ViewController?.view
        self.page3.frame = CGRectMake(self.scrollView.frame.size.width * 2, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        self.addChildViewController(page3ViewController!)
        page3ViewController?.didMoveToParentViewController(self)
        
        let page4ViewController = mainStoryboard?.instantiateViewControllerWithIdentifier("page4")
        self.page4 = page4ViewController?.view
        self.page4.frame = CGRectMake(self.scrollView.frame.size.width * 3, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        self.addChildViewController(page4ViewController!)
        page4ViewController?.didMoveToParentViewController(self)
        
        let page5ViewController = mainStoryboard?.instantiateViewControllerWithIdentifier("page6")
        self.page5 = page5ViewController?.view
        self.page5.frame = CGRectMake(self.scrollView.frame.size.width * 4, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        self.addChildViewController(page5ViewController!)
        page5ViewController?.didMoveToParentViewController(self)


        self.scrollView.addSubview(page1)
        self.scrollView.addSubview(page2)
        self.scrollView.addSubview(page3)
        self.scrollView.addSubview(page4)
        self.scrollView.addSubview(page5)

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset
        self.pageControl.currentPage = Int(offset.x) / Int(self.scrollView.frame.size.width)
    }
    
    @IBAction func btnSkipClicked(sender: AnyObject) {
        
        self.pageControl.currentPage += 1
        UIView.animateWithDuration(0.3, animations: {
            let whichPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * CGFloat(whichPage), 0)
        })
        
        if (self.pageControl.currentPage == 4 && pageCount == 4){
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("AMLoginViewController") as! AMLoginViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            
        }
        pageCount = self.pageControl.currentPage
        print(pageControl.currentPage)

    }
    
    @IBAction func changePage(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: {
            let whichPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * CGFloat(whichPage), 0)
        })
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
