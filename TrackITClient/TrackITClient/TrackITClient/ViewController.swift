//
// File         : ViewController.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-03
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
//

import UIKit
var restriction = ""
class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var restrictionTextField: UITextField!
    let Restrict = [" ", "Sugar", "Salt"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView:UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
            return Restrict[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return Restrict.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        restriction = Restrict[row]
        restrictionTextField.text = restriction
    }
    
    
    /*    @IBAction func nameAction(_ sender: AnyObject) {
     if (nameTextField.text != "")
     {
     name = nameTextField.text!
     }
     }
     
     @IBAction func ageAction(_ sender: AnyObject) {
     if (ageTextField.text != "")
     {
     age = ageTextField.text!
     }
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let restrictionPicker = UIPickerView()
        restrictionPicker.delegate = self
        restrictionTextField.inputView = restrictionPicker
        
        createToolbar()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //     textField.resignFirstResponder()
    //   return true
    //}
    
    func createToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target:self, action: #selector (ViewController2.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        restrictionTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

