//
// File         : ViewController2.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Alan Dong
// Created On   : 2018-06-27
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
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


