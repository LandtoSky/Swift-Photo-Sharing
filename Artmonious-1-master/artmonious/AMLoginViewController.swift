//
//  ViewController.swift
//  artmonious
//
//  Created by Admin on 10/09/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import UIKit

class AMLoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.delegate = self
        self.passWord.delegate = self
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        userName.resignFirstResponder()
//        passWord.resignFirstResponder()
//        self.view.endEditing(true)
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.userName.resignFirstResponder()
        self.passWord.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    @IBAction func loginClicked() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TabbarViewController") as! TabbarViewController
        self.definesPresentationContext = true
        self.presentViewController(nextViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

