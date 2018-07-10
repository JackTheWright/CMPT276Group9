//
// File         : NotificationViewController.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Siddharth Gupta
// Created On   : 2018-06-29
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//
// Edited By    : Siddharth Gupta
// Edited On    : 2018-07-06

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    @IBOutlet weak var mealsToolbar: UIToolbar!
    @IBOutlet weak var mealTimePicker: UIDatePicker!
    @IBOutlet weak var breakfastTime: UILabel!
    @IBOutlet weak var dinnerTime: UILabel!
    @IBOutlet weak var lunchTime: UILabel!
    @IBOutlet weak var snaclToolbar: UIBarButtonItem!
    @IBOutlet weak var snackTimePicker: UIDatePicker!
    @IBOutlet weak var s1Time: UILabel!
    @IBOutlet weak var s2Time: UILabel!
    @IBOutlet weak var s3Time: UILabel!
    @IBOutlet weak var s4Time: UILabel!
    
    let defaults = UserDefaults.standard
    
    @IBAction func setS1Notification(_ sender: Any) {
        snacktimeSetter(snack: "snack1", timePicker: snackTimePicker)
    }
    @IBAction func setS2Notification(_ sender: Any) {
        snacktimeSetter(snack: "snack2", timePicker: snackTimePicker)
    }
    @IBAction func setS3Notification(_ sender: Any) {
        snacktimeSetter(snack: "snack3", timePicker: snackTimePicker)
    }
    @IBAction func setS4Notification(_ sender: Any) {
        snacktimeSetter(snack: "snack4", timePicker: snackTimePicker)
    }
    @IBAction func setBreakfastNotification(_ sender: Any) {
        mealtimeSetter(meal: "breakfast", timePicker: mealTimePicker)
    }
    @IBAction func setLunchNotification(_ sender: Any) {
        mealtimeSetter(meal: "lunch", timePicker: mealTimePicker)
    }
    @IBAction func setDinnerNotification(_ sender: Any) {
        mealtimeSetter(meal: "dinner", timePicker: mealTimePicker)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow,error in
        })
        
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTime(timePicker: UIDatePicker) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let time = formatter.string(from: timePicker.date)
        return time
    }
    
    func setMealNotification(time: UIDatePicker, meal: String){
        if(meal == "breakfast"){
        let notifContent = UNMutableNotificationContent()
        notifContent.title = "MEAL REMINDER"
        notifContent.subtitle = "First Meal of the day"
        notifContent.body = "Time to have Breakfast"
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time.date )
            let t = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
             let request = UNNotificationRequest(identifier: "breakfast", content: notifContent, trigger: t)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
        else if(meal == "lunch")
        {
            let notifContent = UNMutableNotificationContent()
            notifContent.title = "MEAL REMINDER"
            notifContent.subtitle = "Second Meal of the day"
            notifContent.body = "Time to have Lunch"
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time.date )
            let t = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let request = UNNotificationRequest(identifier: "lunch", content: notifContent, trigger: t)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else
        {
            let notifContent = UNMutableNotificationContent()
            notifContent.title = "MEAL REMINDER"
            notifContent.subtitle = "Third Meal of the day"
            notifContent.body = "Time to have Dinner"
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time.date )
            let t = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let request = UNNotificationRequest(identifier: "dinner", content: notifContent, trigger: t)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    func mealtimeSetter( meal: String, timePicker: UIDatePicker){
        if(meal == "breakfast"){
            breakfastTime.text = getTime(timePicker: timePicker)
            setMealNotification(time: timePicker, meal: meal)
        }
        else if(meal == "lunch"){
            lunchTime.text = getTime(timePicker: timePicker)
            setMealNotification(time: timePicker, meal: meal)
        }
        else{
            dinnerTime.text = getTime(timePicker: timePicker)
            setMealNotification(time: timePicker, meal: meal)
        }
    }
    
    func snacktimeSetter( snack: String, timePicker: UIDatePicker){
        if(snack == "snack1"){
            s1Time.text = getTime(timePicker: timePicker)
            setSnackNotification(time: timePicker, snack: snack)
        }
        else if(snack == "snack2"){
            s2Time.text = getTime(timePicker: timePicker)
            setSnackNotification(time: timePicker, snack: snack)
        }
        else if(snack == "snack3"){
            s3Time.text = getTime(timePicker: timePicker)
            setSnackNotification(time: timePicker, snack: snack)
        }
        else{
            s4Time.text = getTime(timePicker: timePicker)
            setSnackNotification(time: timePicker, snack: snack)
        }
    }
    
    func setSnackNotification(time: UIDatePicker, snack: String){
        if(snack == "sanck1"){
            let notifContent = UNMutableNotificationContent()
            notifContent.title = "SNACK REMINDER"
            notifContent.subtitle = "First Snack of the day"
            notifContent.body = "Time to have Snack#1"
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time.date )
            let t = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let request = UNNotificationRequest(identifier: "s1", content: notifContent, trigger: t)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
            
        else if(snack == "snack2")
        {
            let notifContent = UNMutableNotificationContent()
            notifContent.title = "SNACK REMINDER"
            notifContent.subtitle = "Second Snack of the day"
            notifContent.body = "Time to have Snack#2"
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time.date )
            let t = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let request = UNNotificationRequest(identifier: "s2", content: notifContent, trigger: t)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else if(snack == "snack3")
        {
            let notifContent = UNMutableNotificationContent()
            notifContent.title = "SNACK REMINDER"
            notifContent.subtitle = "Third Snack of the day"
            notifContent.body = "Time to have Snack#3"
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time.date )
            let t = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let request = UNNotificationRequest(identifier: "s3", content: notifContent, trigger: t)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else
        {
            let notifContent = UNMutableNotificationContent()
            notifContent.title = "SNACK REMINDER"
            notifContent.subtitle = "Fourth Snack of the day"
            notifContent.body = "Time to have Snack#4"
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time.date )
            let t = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let request = UNNotificationRequest(identifier: "s4", content: notifContent, trigger: t)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    }



