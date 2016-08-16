//
//  ViewController.swift
//  PercentageApp
//
//  Created by ram on 5/7/16.
//  Copyright © 2016 ram. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var numberInTextField: UITextField!
    
    @IBOutlet weak var outputText: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var sliderValue: UILabel!

    @IBAction func textFieldEditingChanged(sender: AnyObject) {
        if(numberInTextField.text == "") {
            outputText.text = ""
        }
    }
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        let valueShownInTextField: String = String(format:"%0.0f",slider.value) + " %"
        sliderValue.text = valueShownInTextField
        self.computeAnswer((numberInTextField.text! as NSString).floatValue, percentage: (sliderValue.text! as NSString).floatValue)
    }
    
    func computeAnswer(input: Float, percentage: Float) {
        //Return calculated answer as float
        if(input != 0) {
            outputText.text = String(format: "%.2f", ((percentage)/100) * input)
        }
        else {
            outputText.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        //Clear the output text when the textfield box is cleared
        outputText.text = ""
        return true
    }
        
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //Answer calculated as and when text is entered, reactive changes
        let newString = (textField.text! as NSString)
            .stringByReplacingCharactersInRange(range, withString: string)
        self.computeAnswer((newString as NSString).floatValue, percentage: (sliderValue.text! as NSString).floatValue)
        return true
    }
    
    func keyboardWillShow(sender: NSNotification) {
        //if (UIApplication.sharedApplication().statusBarOrientation.isLandscape) {
        //Moving the screen up when hardware keyboard shows up
            //self.view.frame.origin.y = -(self.view.frame.size.height - outputText.frame.size.height)/50
    }
    
    func keyboardWillHide(sender: NSNotification) {
        //if (UIApplication.sharedApplication().statusBarOrientation.isLandscape) {
        //Moving the screen up when hardware keyboard shows up
           // self.view.frame = CGRectOffset(self.view.frame, 0, (self.view.frame.size.height - outputText.frame.size.height)/50) //Eliminating black portion of screen when keyboard hides
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberInTextField.delegate = self
        //To resign first responder while clicking elsewhere on screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
}

