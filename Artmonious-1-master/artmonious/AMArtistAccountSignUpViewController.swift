//
//  AMArtistAccountSignUpViewController.swift
//  artmonious
//
//  Created by Admin on 15/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

class AMArtistAccountSignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AMArtistAccountSubmitViewControllerDelegate, UITextFieldDelegate {
    
    var goArtist: AMArtistAccountSignUpViewController?

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var hLayoutHeight: NSLayoutConstraint!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var containerV: UIView!
    
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtConfirmPw: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delaysContentTouches = false
        self.scrollView.canCancelContentTouches = true
        self.scrollView.exclusiveTouch = true
        self.scrollView.userInteractionEnabled = true
        
        self.hLayoutHeight.constant = 200
        
        imagePicker.delegate = self
        txtFirstname.delegate = self
        txtLastname.delegate = self
        txtEmail.delegate = self
        txtPass.delegate = self
        txtConfirmPw.delegate = self
        txtCountry.delegate = self
        txtCity.delegate = self
        
        profileImage.layer.borderWidth=1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        profileImage.layer.cornerRadius = 13
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        profileImage.clipsToBounds = true

        self.txtFirstname.resignFirstResponder()
        self.txtLastname.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtPass.resignFirstResponder()
        self.txtConfirmPw.resignFirstResponder()
        self.txtCountry.resignFirstResponder()
        self.txtCity.resignFirstResponder()
        self.txtUsername.resignFirstResponder()

        
        let tapContainerV = UITapGestureRecognizer(target: self, action: #selector(AMArtistAccountSignUpViewController.tappedView(_:)))
        self.containerV.addGestureRecognizer(tapContainerV)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name:UIKeyboardWillHideNotification, object: nil)

        
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        txtFirstname.resignFirstResponder()
//        return true
//    }
    
//    func keyboardWillShow(notification:NSNotification){
//        
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
//        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
//        
//        var contentInset:UIEdgeInsets = self.scrollView.contentInset
//        contentInset.bottom = keyboardFrame.size.height
//        self.scrollView.contentInset = contentInset
//    }
//    
//    func keyboardWillHide(notification:NSNotification){
//        
//        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
//        self.scrollView.contentInset = contentInset
//    }
    
    func tappedView(gesture:UITapGestureRecognizer){
        
        self.txtFirstname.resignFirstResponder()
        self.txtLastname.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtPass.resignFirstResponder()
        self.txtConfirmPw.resignFirstResponder()
        self.txtCountry.resignFirstResponder()
        self.txtCity.resignFirstResponder()
        self.txtUsername.resignFirstResponder()
        
    }
    func keyboardWillShow(sender: NSNotification) {
        self.containerV.frame.origin.y = -150
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.containerV.frame.origin.y = 0
    }
    
    @IBAction func uploadProfileImageClicked(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.contentMode = .ScaleToFill
            profileImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func goArtsubmite(sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("AMArtistAccountSubmitViewController") as! AMArtistAccountSubmitViewController
        nextViewController.detailImg = self.profileImage.image
        nextViewController.delegate = self

        self.presentViewController(nextViewController, animated:true, completion:nil)

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissThisViewController(currentVC : AMArtistAccountSubmitViewController)
    {
        currentVC.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

