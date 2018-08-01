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

class ViewController2: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    let Gender = [" ","Male","Female"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView:UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
            return Gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender = Gender[row]
        genderTextField.text = gender
        UserDefaults.standard.set(genderTextField.text, forKey: "userGender")
    }
    
    func createAlert (title : String, message:String){
        let alert = UIAlertController (title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in }))
        self.present(alert, animated:true, completion:nil)
    }
    
    @IBAction func nameAction(_ sender: AnyObject) {
        if (nameTextField?.text != ""){
            UserDefaults.standard.set(nameTextField?.text, forKey: "userName")
            startButton.isEnabled = true
        }
        
    }
    @IBAction func ageAction(_ sender: AnyObject) {
        if (ageTextField?.text != ""){
            UserDefaults.standard.set(ageTextField?.text, forKey: "userAge")
        }
    }
    
//    @IBAction func startButton(_ sender: Any) {
  //      if nameTextField?.text != ""{
    //        startButton.isEnabled = true
      //  }
    //}
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderTextField.inputView = genderPicker
        
        createToolbar()
        nameTextField?.delegate = self
        ageTextField?.delegate = self
        // Do any additional setup after loading the view.
        startButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createAlert(title: "Reminder", message: "Recommanded age is 16 and above")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    func createToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target:self, action: #selector (ViewController2.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        genderTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
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


