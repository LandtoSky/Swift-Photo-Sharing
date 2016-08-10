//
//  AMArtistAccountSubmitViewController.swift
//  artmonious
//
//  Created by Admin on 13/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

protocol AMArtistAccountSubmitViewControllerDelegate {
    func dismissThisViewController(currentVC : AMArtistAccountSubmitViewController)
}

class AMArtistAccountSubmitViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ZHDropDownMenuDelegate {

    
    var delegate : AMArtistAccountSubmitViewControllerDelegate? = nil

    var  detailImg : UIImage!

    @IBOutlet weak var profileImage: UIImageView!
    
    let reuseIdentifier = "cell"
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    @IBAction func btnEditProfile() {
        
        if (self.delegate != nil) {
            self.delegate?.dismissThisViewController(self)
        }

    }
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ArtworkTagCell
       
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.image = self.detailImg
        self.profileImage.contentMode = .ScaleToFill
        profileImage.layer.borderWidth=1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        profileImage.layer.cornerRadius = 13
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        profileImage.clipsToBounds = true

    }
    
    func dropDownMenu(menu: ZHDropDownMenu!, didChoose index: Int) {
        print("\(menu) choosed at index \(index)")
    }
    
    func dropDownMenu(menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
