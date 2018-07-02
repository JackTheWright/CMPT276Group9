//
//  ViewController2.swift
//  TrackITClient
//
//  Created by Alan Dong on 2018-06-27.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

var name = ""
var gender = ""
var age = ""
var weight = ""

class ViewController2: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!

    @IBAction func nameAction(_ sender: AnyObject) {
        if (nameTextField.text != "")
        {
            name = nameTextField.text!
        }
    }
    
    @IBAction func genderAction(_ sender: AnyObject) {
        if (genderTextField.text != "")
        {
            gender = genderTextField.text!
        }
    }
    
    @IBAction func ageAction(_ sender: AnyObject) {
        if (ageTextField.text != "")
        {
            age = ageTextField.text!
        }
    }
    
    @IBAction func weightAction(_ sender: AnyObject) {
        if (weightTextField.text != "")
        {
            weight = weightTextField.text!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField?.delegate = self
        genderTextField?.delegate = self
        ageTextField?.delegate = self
        weightTextField?.delegate = self

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


