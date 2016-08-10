//
//  AMSignUpViewController.swift
//  artmonious
//
//  Created by Admin on 11/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

class AMSignUpViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var TAGS = ["porpart", "street art", "landscapes", "portraits", "california morden",  "abstract", "photography", "1960s lifestyle"]

    @IBOutlet weak var hLayoutInnerView: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var addArt: UITextField!
    @IBOutlet weak var flowLayout: FlowLayout!
    var sizingCell: TagCell?
    @IBOutlet weak var containerV: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var tags = [Tag]()
    var recognizer : UITapGestureRecognizer! = nil
    var tagArry : [Int] = []
    
    
    
    @IBOutlet weak var btnDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delaysContentTouches = false
        self.scrollView.canCancelContentTouches = true
        self.scrollView.exclusiveTouch = true
        self.scrollView.userInteractionEnabled = true
        self.Label.layer.borderColor = UIColor.blackColor().CGColor
        let cellNib = UINib(nibName: "TagCell", bundle: nil)
        self.collectionView.registerNib(cellNib, forCellWithReuseIdentifier: "TagCell")
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.sizingCell = (cellNib.instantiateWithOwner(nil, options: nil) as NSArray).firstObject as! TagCell?
        self.flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        for name in TAGS {
            let tag = Tag()
            tag.name = name
            self.tags.append(tag)
        }

        self.hLayoutInnerView.constant = 200
        self.txtFirstName.delegate = self
        self.txtLastName.delegate = self
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        self.txtConfirmPassword.delegate = self
        self.txtUserName.delegate = self
        self.addArt.delegate = self
        self.collectionView.userInteractionEnabled = true
        self.containerV.addSubview(self.collectionView)
        self.btnDelete.addTarget(self, action: #selector(AMSignUpViewController.btnDeleteClicked(_:)), forControlEvents: .TouchUpInside)
        self.btnDelete.hidden = true
        
//        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(AMSignUpViewController.handleTap(_:)))
//        self.containerV.addGestureRecognizer(tapgesture)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name:UIKeyboardWillHideNotification, object: nil)

    }
    
    func btnDeleteClicked(sender: UIButton)
    {
        self.btnDelete.hidden = true

        var padding = Int()
        padding = 0;
        for index in 0..<tagArry.count
        {
            self.tags = []
            self.TAGS.removeAtIndex(tagArry[index] - padding)
            padding += 1;
            for name in TAGS {
                let tag = Tag()
                tag.name = name
                self.tags.append(tag)
            }
        }
        self.tagArry = []
        print(TAGS)
        self.collectionView.reloadData()

    }
    
    @IBAction func addArtClicked() {
        
        print(self.tags)
        print(self.addArt.text)
        if self.addArt.text == ""
        {
            return
        }
        else
        {
            self.tags = []
            self.TAGS.append(self.addArt.text!)
            print(self.TAGS)
            for name in TAGS {
                let tag = Tag()
                tag.name = name
                self.tags.append(tag)
            }
//            tags.last?.selected = true
            self.collectionView.reloadData()
        }
        self.addArt.text = ""
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {

        self.txtFirstName.resignFirstResponder()
        self.txtLastName.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
        self.txtConfirmPassword.resignFirstResponder()
        self.txtUserName.resignFirstResponder()
        self.addArt.resignFirstResponder()

    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.containerV.frame.origin.y = -3*self.addArt.frame.height
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.containerV.frame.origin.y = 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TagCell", forIndexPath: indexPath) as! TagCell
        self.configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        self.configureCell(self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
//        tags.last?.selected = false
        tags[indexPath.row].selected = !tags[indexPath.row].selected
        print(tags[indexPath.row].selected)
        print(indexPath.row)
        if tags[indexPath.row].selected == true && !tagArry.contains(indexPath.row){
            self.tagArry.append(indexPath.row)
        }
        
        if tagArry.count != 0 {
            self.btnDelete.hidden = false
        }else{
            self.btnDelete.hidden = true
        }
        self.collectionView.reloadData()
        print(tagArry)
        
        self.txtFirstName.resignFirstResponder()
        self.txtLastName.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
        self.txtConfirmPassword.resignFirstResponder()
        self.txtUserName.resignFirstResponder()
        self.addArt.resignFirstResponder()


    }

    
    func configureCell(cell: TagCell, forIndexPath indexPath: NSIndexPath) {
        let tag = tags[indexPath.row]
        cell.tagName.text = tag.name
        cell.tagName.layer.borderColor = tag.selected ? UIColor.grayColor().CGColor : UIColor.grayColor().CGColor
        cell.tagName.textColor = tag.selected ? UIColor.whiteColor() : UIColor.whiteColor()
        cell.backgroundColor = tag.selected ? UIColor(red: 67/255.0, green: 176/255.0, blue: 227/255.0, alpha: 1) : UIColor(red: 116/255.0, green: 112/255.0, blue: 112/255.0, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}