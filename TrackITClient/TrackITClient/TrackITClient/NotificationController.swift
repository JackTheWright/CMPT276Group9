//
//  ViewController.swift
//  notifications page
//
//  Created by sga94 on 6/29/18.
//  Copyright © 2018 sga94. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationController: UIViewController {
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
    
    @IBAction func doneBtn(_ sender: Any) {
        if firstMealT.text != ""
        {
        let breakfastContent = UNMutableNotificationContent()
        breakfastContent.title = "MEAL REMINDER"
        breakfastContent.subtitle = "First meal of the day"
        breakfastContent.body = "Time to have your breakfast"
            var t: String = firstMealT.text!
            var h: String = String()
            h.append(t.removeFirst())
            h.append(t.removeFirst())
            var m: String = String()
            t.removeFirst()
            m.append(t.removeFirst())
            m.append(t.removeFirst())
            let hour: Int? = Int(h)
            let mins: Int? = Int(m)
            var time = DateComponents()
            time.hour = hour
            time.minute = mins
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            let request = UNNotificationRequest(identifier: "breakfast", content: breakfastContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        if secondMealT.text != ""
        {
            let lunchContent = UNMutableNotificationContent()
            lunchContent.title = "MEAL REMINDER"
            lunchContent.subtitle = "Second meal of the day"
            lunchContent.body = "Time to have your lunch"
            var t: String = secondMealT.text!
            var h: String = String()
            h.append(t.removeFirst())
            h.append(t.removeFirst())
            var m: String = String()
            t.removeFirst()
            m.append(t.removeFirst())
            m.append(t.removeFirst())
            let hour: Int? = Int(h)
            let mins: Int? = Int(m)
            var time = DateComponents()
            time.hour = hour
            time.minute = mins
            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            let request = UNNotificationRequest(identifier: "lunch", content: lunchContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        if thirdMealT.text != ""
        {
            let dinnerContent = UNMutableNotificationContent()
            dinnerContent.title = "MEAL REMINDER"
            dinnerContent.subtitle = "Third meal of the day"
            dinnerContent.body = "Time to have your dinner"
            var t: String = thirdMealT.text!
            var h: String = String()
            h.append(t.removeFirst())
            h.append(t.removeFirst())
            var m: String = String()
            t.removeFirst()
            m.append(t.removeFirst())
            m.append(t.removeFirst())
            let hour: Int? = Int(h)
            let mins: Int? = Int(m)
            var time = DateComponents()
            time.hour = hour
            time.minute = mins
            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            let request = UNNotificationRequest(identifier: "dinner", content: dinnerContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        if s1T.text != ""
        {
            let s1Content = UNMutableNotificationContent()
            s1Content.title = "SNACK REMINDER"
            s1Content.subtitle = "First snack of the day"
            s1Content.body = "Time to have your snack"
            var t: String = s1T.text!
            var h: String = String()
            h.append(t.removeFirst())
            h.append(t.removeFirst())
            var m: String = String()
            t.removeFirst()
            m.append(t.removeFirst())
            m.append(t.removeFirst())
            let hour: Int? = Int(h)
            let mins: Int? = Int(m)
            var time = DateComponents()
            time.hour = hour
            time.minute = mins
            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            let request = UNNotificationRequest(identifier: "snack1", content: s1Content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        if s2T.text != ""
        {
            let s2Content = UNMutableNotificationContent()
            s2Content.title = "SNACK REMINDER"
            s2Content.subtitle = "Second snack of the day"
            s2Content.body = "Time to have your snack"
            var t: String = s2T.text!
            var h: String = String()
            h.append(t.removeFirst())
            h.append(t.removeFirst())
            var m: String = String()
            t.removeFirst()
            m.append(t.removeFirst())
            m.append(t.removeFirst())
            let hour: Int? = Int(h)
            let mins: Int? = Int(m)
            var time = DateComponents()
            time.hour = hour
            time.minute = mins
            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            let request = UNNotificationRequest(identifier: "snack2", content: s2Content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        if s3T.text != ""
        {
            let s3Content = UNMutableNotificationContent()
            s3Content.title = "SNACK REMINDER"
            s3Content.subtitle = "Third snack of the day"
            s3Content.body = "Time to have your snack"
            var t: String = s3T.text!
            var h: String = String()
            h.append(t.removeFirst())
            h.append(t.removeFirst())
            var m: String = String()
            t.removeFirst()
            m.append(t.removeFirst())
            m.append(t.removeFirst())
            let hour: Int? = Int(h)
            let mins: Int? = Int(m)
            var time = DateComponents()
            time.hour = hour
            time.minute = mins
            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            let request = UNNotificationRequest(identifier: "snack3", content: s3Content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        if s4T.text != ""
        {
            let s4Content = UNMutableNotificationContent()
            s4Content.title = "SNACK REMINDER"
            s4Content.subtitle = "Fourth snack of the day"
            s4Content.body = "Time to have your snack"
            var t: String = s4T.text!
            var h: String = String()
            h.append(t.removeFirst())
            h.append(t.removeFirst())
            var m: String = String()
            t.removeFirst()
            m.append(t.removeFirst())
            m.append(t.removeFirst())
            let hour: Int? = Int(h)
            let mins: Int? = Int(m)
            var time = DateComponents()
            time.hour = hour
            time.minute = mins
            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            let request = UNNotificationRequest(identifier: "sanck4", content: s4Content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow,error in
        })
        
        timePickerM1 = UIDatePicker()
        timePickerM1?.datePickerMode = .time
        timePickerM1?.addTarget(self, action:
            #selector(NotificationController.timeChangedM1(timePicker:)),
                                for: .valueChanged)
        
        firstMealT.inputView = timePickerM1
        
        timePickerM2 = UIDatePicker()
        timePickerM2?.datePickerMode = .time
        timePickerM2?.addTarget(self, action:
            #selector(NotificationController.timeChangedM2(timePicker:)),
                                for: .valueChanged)
        
        secondMealT.inputView = timePickerM2
        
        timePickerM3 = UIDatePicker()
        timePickerM3?.datePickerMode = .time
        timePickerM3?.addTarget(self,
                                action: #selector(NotificationController.timeChangedM3(timePicker:)), for: .valueChanged)
        
        thirdMealT.inputView = timePickerM3
        
        timePickerS1 = UIDatePicker()
        timePickerS1?.datePickerMode = .time
        timePickerS1?.addTarget(self, action: #selector(NotificationController.timeChangedS1(timePicker:)), for: .valueChanged)
        
        s1T.inputView = timePickerS1
        
        timePickerS2 = UIDatePicker()
        timePickerS2?.datePickerMode = .time
        timePickerS2?.addTarget(self, action: #selector(NotificationController.timeChangedS2(timePicker:)), for: .valueChanged)
        
        s2T.inputView = timePickerS2
        
        timePickerS3 = UIDatePicker()
        timePickerS3?.datePickerMode = .time
        timePickerS3?.addTarget(self, action: #selector(NotificationController.timeChangedS3(timePicker:)), for: .valueChanged)
        
        s3T.inputView = timePickerS3
        
        timePickerS4 = UIDatePicker()
        timePickerS4?.datePickerMode = .time
        timePickerS4?.addTarget(self, action: #selector(NotificationController.timeChangedS4(timePicker:)), for: .valueChanged)
        
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

