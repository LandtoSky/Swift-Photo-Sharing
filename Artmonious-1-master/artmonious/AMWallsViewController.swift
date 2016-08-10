//
//  AMWallsViewController.swift
//  artmonious
//
//  Created by Admin on 17/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class AMWallsViewController: UIViewController, ImageDetailedViewControllerDelegate, ZHDropDownMenuDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var item1: UITabBarItem!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var menu: ZHDropDownMenu!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var containerV: UIView!
    
    let imagePicker = UIImagePickerController()

    var tableData: [String] = ["Take a Photo", "Choose Photo"]
    var location = CGPoint(x: 0, y: 0)
    
    var imageList:[String] = ["image1.jpg", "image2.jpg", "image3.jpg", "image4.jpg", "image5.jpg"]
    let maxImages = 4

    var imageIndex: NSInteger = 1
    
    var recognizer : UITapGestureRecognizer! = nil

//    private var dataSource: Array<UIImage> = {
//        var array: Array<UIImage> = []
//        for index in 0..<numberOfCards {
//            array.append(UIImage(named: "Card_like_\(index + 1)")!)
//        }
//        
//        return array
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(AMWallsViewController.swiped(_:))) // put : at the end of method name
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(AMWallsViewController.swiped(_:))) // put : at the end of method name
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        bgImg.userInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(AMWallsViewController.placeTapped(_:)))
        self.bgImg.addGestureRecognizer(tapRecognizer)
        
        
        
        let nib = UINib(nibName: "TblCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        tableView.hidden = true
        
        tableView1.registerNib(nib, forCellReuseIdentifier: "cell")
        tableView1.hidden = true
        
        tableView2.registerNib(nib, forCellReuseIdentifier: "cell")
        tableView2.hidden = true
        
        self.imageV.image = UIImage(named:"image1.jpg")
        menu.options = ["Kitchen","Bedroom","Office"]
        menu.editable = false
        menu.layer.cornerRadius = 10.0
        menu.delegate = self
        
        imagePicker.delegate = self
        
        
        
    }


    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch : UITouch! = touches.first
            
        location = touch.locationInView(self.view)
        
//        imageV.center = location
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch : UITouch! = touches.first
        
        location = touch.locationInView(self.view)
        
        imageV.center = location
    }
    
    
    func dropDownMenu(menu: ZHDropDownMenu!, didChoose index: Int) {
        
        print("\(menu) choosed at index \(index)")
        
        switch index {
        case 0:
            
            tableView1.hidden = true
            tableView2.hidden = true
            tableView.hidden = false
        case 1:
            tableView.hidden = true
            tableView2.hidden = true
            tableView1.hidden = false
        case 2:
            tableView.hidden = true
            tableView1.hidden = true
            tableView2.hidden = false
        default:
            break
        }
        
    }
    
    func dropDownMenu(menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }

    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right :
                print("User swiped right")
                imageIndex -= 1
                if imageIndex < 0 {
                    imageIndex = maxImages
                }
                
                imageV.image = UIImage(named: imageList[imageIndex])
                
            case UISwipeGestureRecognizerDirection.Left:
                print("User swiped Left")
                imageIndex += 1
                if imageIndex > maxImages {
                    
                    imageIndex = 0
                }
                
                imageV.image = UIImage(named: imageList[imageIndex])
            default:
                break
                
                
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    
    // 3
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell 	{
        
        var cell: TblCell?

        if tableView == self.tableView{
            cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as? TblCell
            cell!.txtLabel.text = tableData[indexPath.row]
            cell!.img.image = UIImage(named: tableData[indexPath.row])
            return cell!

        }
        if tableView == self.tableView1{
            cell = self.tableView1.dequeueReusableCellWithIdentifier("cell") as? TblCell
            cell!.txtLabel.text = tableData[indexPath.row]
            cell!.img.image = UIImage(named: tableData[indexPath.row])
            return cell!

        }
        if tableView == self.tableView2{
            cell = self.tableView2.dequeueReusableCellWithIdentifier("cell") as? TblCell
            cell!.txtLabel.text = tableData[indexPath.row]
            cell!.img.image = UIImage(named: tableData[indexPath.row])
            return cell!

        }
        
        return cell!

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        
        if tableView == self.tableView{
            
            switch indexPath.row {
            case 0:
                
                self.menu.showOrHide()
                self.tableView.hidden = true
                self.tableView1.hidden = true
                self.tableView2.hidden = true
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)
                
            case 1:
                self.menu.showOrHide()
                self.tableView.hidden = true
                self.tableView1.hidden = true
                self.tableView2.hidden = true
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)

            default:
                break
            }
        }
        if tableView == self.tableView1 {
            
            switch indexPath.row {
            case 0:
//                imagePicker.sourceType = .Camera
                
                self.menu.showOrHide()
                self.tableView.hidden = true
                self.tableView1.hidden = true
                self.tableView2.hidden = true
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)
                break
            case 1:
                self.menu.showOrHide()
                self.tableView.hidden = true
                self.tableView1.hidden = true
                self.tableView2.hidden = true
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)
            default:
                break
            }
        }
        if tableView == self.tableView2{
            
            switch indexPath.row {
            case 0:
                
                self.menu.showOrHide()
                self.tableView.hidden = true
                self.tableView1.hidden = true
                self.tableView2.hidden = true
                
//                imagePicker.sourceType = .Camera
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)
                break
            case 1:
                self.menu.showOrHide()
                self.tableView.hidden = true
                self.tableView1.hidden = true
                self.tableView2.hidden = true
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)
            default:
                break
            }
        }
        
    }
    
    // 5
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bgImg.contentMode = .ScaleToFill
            bgImg.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    func placeTapped(gestureRcognizer: UITapGestureRecognizer){
        
        if self.menu.isShown == true{
            self.menu.showOrHide()
        }
        self.tableView.hidden = true
        self.tableView1.hidden = true
        self.tableView2.hidden = true
        
    }
    
    
    private var contentTextField:UITextField!

    //MARK IMAGEDETAILVIEWDELEGATE METHOD
    func dismissThisViewController(currentVC : ImageDetailedViewController)
    {
        currentVC.dismissViewControllerAnimated(true, completion: nil)
    }
}