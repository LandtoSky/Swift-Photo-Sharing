//
//  ArtImageInfoViewController.swift
//  artmonious
//
//  Created by Victor on 08/10/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit


protocol ArtImageInfoViewControllerDelegate {
    func dismissThisViewController(currentVC : ArtImageInfoViewController)
}


class ArtImageInfoViewController: UIViewController,ImageDetailedViewControllerDelegate, ZHDropDownMenuDelegate {


    var delegate : ArtImageInfoViewControllerDelegate? = nil
    
    var  imgInfo : UIImage!
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var txtPriceLabel: UILabel!
    @IBOutlet weak var menu: ZHDropDownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageV.image = imgInfo
        
        menu.options = ["15 X 15    $500","20 X 20   $1000","25 X 25   $2000"]
        menu.editable = false
        menu.layer.cornerRadius = 10.0
        menu.delegate = self
        
    }
    
    @IBAction func btnZoomClicked() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("ImageDetailedViewController") as! ImageDetailedViewController
        nextViewController.delegate = self
        nextViewController.detailImg = self.imageV.image
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    func dismissThisViewController(currentVC : ImageDetailedViewController)
    {
        currentVC.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addToGalleryClicked() {
        
        if (self.delegate != nil) {
            self.delegate?.dismissThisViewController(self)
        }
        else{
            print("Tapped dsadfsdasdfa")
        }
    }
    
    @IBAction func btnCloseClicked() {
        
        if (self.delegate != nil) {
            self.delegate?.dismissThisViewController(self)
        }
        else{
            print("Tapped dsadfsdasdfa")
        }
    }
    func dropDownMenu(menu: ZHDropDownMenu!, didChoose index: Int) {
        print("\(menu) choosed at index \(index)")
        switch index {
        case 0:
            self.menu.showOrHide()
            self.txtPriceLabel.text = "US $500"
        case 1:
            self.menu.showOrHide()
            self.txtPriceLabel.text = "US $1000"
        case 2:
            self.menu.showOrHide()
            self.txtPriceLabel.text = "US $2000"
        default:
            break
        }
    }
    
    func dropDownMenu(menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
}
