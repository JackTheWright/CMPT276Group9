//
//  ViewController.swift
//  notifications page
//
//  Created by sga94 on 6/29/18.
//  Copyright © 2018 sga94. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var firstMealT: UITextField!
    @IBOutlet weak var secondMealT: UITextField!
    @IBOutlet weak var thirdMealT: UITextField!
    @IBOutlet weak var s1T: UITextField!
    @IBOutlet weak var s2T: UITextField!
    @IBOutlet weak var s3T: UITextField!
    @IBOutlet weak var s4T: UITextField!
    private var timePickerM1: UIDatePicker?
    private var timePickerM2: UIDatePicker?
    private var timePickerM3: UIDatePicker?
    private var timePickerS1: UIDatePicker?
    private var timePickerS2: UIDatePicker?
    private var timePickerS3: UIDatePicker?
    private var timePickerS4: UIDatePicker?
    
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow,error in
        })
        
        timePickerM1 = UIDatePicker()
        timePickerM1?.datePickerMode = .time
        timePickerM1?.addTarget(self, action:
            #selector(ViewController.timeChangedM1(timePicker:)),
                                for: .valueChanged)
        
        firstMealT.inputView = timePickerM1
        
        timePickerM2 = UIDatePicker()
        timePickerM2?.datePickerMode = .time
        timePickerM2?.addTarget(self, action:
            #selector(ViewController.timeChangedM2(timePicker:)),
                                for: .valueChanged)
        
        secondMealT.inputView = timePickerM2
        
        timePickerM3 = UIDatePicker()
        timePickerM3?.datePickerMode = .time
        timePickerM3?.addTarget(self,
                                action: #selector(ViewController.timeChangedM3(timePicker:)), for: .valueChanged)
        
        thirdMealT.inputView = timePickerM3
        
        timePickerS1 = UIDatePicker()
        timePickerS1?.datePickerMode = .time
        timePickerS1?.addTarget(self, action: #selector(ViewController.timeChangedS1(timePicker:)), for: .valueChanged)
        
        s1T.inputView = timePickerS1
        
        timePickerS2 = UIDatePicker()
        timePickerS2?.datePickerMode = .time
        timePickerS2?.addTarget(self, action: #selector(ViewController.timeChangedS2(timePicker:)), for: .valueChanged)
        
        s2T.inputView = timePickerS2
        
        timePickerS3 = UIDatePicker()
        timePickerS3?.datePickerMode = .time
        timePickerS3?.addTarget(self, action: #selector(ViewController.timeChangedS3(timePicker:)), for: .valueChanged)
        
        s3T.inputView = timePickerS3
        
        timePickerS4 = UIDatePicker()
        timePickerS4?.datePickerMode = .time
        timePickerS4?.addTarget(self, action: #selector(ViewController.timeChangedS4(timePicker:)), for: .valueChanged)
        
        s4T.inputView = timePickerS4
    }
    @objc func timeChangedM1(timePicker: UIDatePicker){
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let time:String? = timeFormat.string(from: (timePickerM1?.date)!)
        firstMealT.text = time
        view.endEditing(true)
    }
    
    @objc func timeChangedM2(timePicker: UIDatePicker){
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let time:String? = timeFormat.string(from: (timePickerM2?.date)!)
        secondMealT.text = time
        view.endEditing(true)
        
    }
    
    @objc func timeChangedM3(timePicker: UIDatePicker){
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let time:String? = timeFormat.string(from: (timePickerM3?.date)!)
        thirdMealT.text = time
        view.endEditing(true)
        
    }
    
    @objc func timeChangedS1(timePicker: UIDatePicker){
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let time:String? = timeFormat.string(from: (timePickerS1?.date)!)
        s1T.text = time
        view.endEditing(true)
        
    }
    
    @objc func timeChangedS2(timePicker: UIDatePicker){
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let time:String? = timeFormat.string(from: (timePickerS2?.date)!)
        s2T.text = time
        view.endEditing(true)
        
    }
    
    @objc func timeChangedS3(timePicker: UIDatePicker){
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let time:String? = timeFormat.string(from: (timePickerS3?.date)!)
        s3T.text = time
        view.endEditing(true)
        
    }
    
    @objc func timeChangedS4(timePicker: UIDatePicker){
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let time:String? = timeFormat.string(from: (timePickerS4?.date)!)
        s4T.text = time
        view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

