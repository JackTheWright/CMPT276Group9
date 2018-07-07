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

class ViewController2: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
/*    @IBOutlet weak var dropDown: UIPickerView!
    
    let Gender = ["Male","Female"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView:UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return Gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.count
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            self.dropDown.isHidden = false
    }*/
    
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
    
    func startTrackingAction() {
        let personalData = Personaldata(id: 0, name: name, gender: gender, age: age, weight: weight)
        personalDatas.append(personalData)
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
    

    
    private var personalDatas = [Personaldata]()
    private var selectedPerson: Int?

    
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


