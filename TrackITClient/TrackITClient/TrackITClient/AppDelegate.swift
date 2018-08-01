//
// File         : AppDelegate.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-03
//
// Edited By    : Jack Wright
// Edited On    : 2018-06-28
//  - Implementation
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
//

import UIKit
import NetConnect
import SwiftyJSON

typealias foodTuple = (foodname: String, foodid: Int, foodgroup: Int)

struct GlobalStates {
    
    static var currentDayDictionary = [String: [String]]()
    static var meaties = "0"
    static var veggies = "0"
    static var fruities = "0"
    static var dairies = "0"
    static var grainies = "0"
    static var foodnames: [(foodTuple)] = []
    static var port = 60011
    static var foodForTable = [String: Int]()
    static var arr = Data()
    static var totalNutrientsCount = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    static var yest = String()
    static var foodGroupyBoy1 = String()
    static var foodGroupyBoy2 = String()
    static var foodGroupyBoy3 = String()
    static var foodGroupyBoy = String()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var totalNutrients = [Double]()
    
    var window: UIWindow?
    
    var vc = viewControl()
    var dateAttributes = DateAttributes()
    
    var storyboard:UIStoryboard?
    
    
    
    
    
//  When the Application loads it does many things. First the launchedBefore variable is set to the userdefault launchedBefore, which is a bool. If it's false then it is the first time using the app. This means all the label values are 0 and the first view controller should be the information page, then the user input page. If launchedBefore is true, it'll set the first view to be the overview page.

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        let yest = UserDefaults.standard.string(forKey: "backGroundDate") ?? time.currentDateToString()
        let today = time.currentDateToString()
        print(today)
        print(yest)
        let quickAddRefresh = dateAttributes.isSameDates(date1: yest, date2: today)
        print(quickAddRefresh)
        UserDefaults.standard.set(quickAddRefresh, forKey: "checkToSeeIfLastAccessWasYesterday")
        UserDefaults.standard.set(true, forKey: "alertShouldShow")
        
        DispatchQueue.global(qos: .background).async{
            let interface = NetworkInterface()!
            
            interface.connect(to: "app.trackitdiet.com", on: GlobalStates.port) { host in
                var flags = Message.Flags()
                interface.setTimeout(10)
                
                flags.set(MessageFlags.DBQuery)
                print("sending")
                do {
                    try host.send("select foodId, foodDescription, foodGroupId from 'food name' limit 1000;", flags: flags)
                    print("sent")
                    let JSONreply = try host.receiveJSON()
                    print("didrecieve")
                    if let fn = JSONreply.array?.compactMap({ element in
                        return (element.dictionary!["FOODDESCRIPTION"]!.string!,
                                element.dictionary!["FOODID"]!.int!,
                                element.dictionary!["FOODGROUPID"]!.int!)
                    }) {
                        GlobalStates.foodnames = fn
                    }
                } catch{
                    UserDefaults.standard.set("nosir", forKey: "didWork")
                }
                print(GlobalStates.foodnames)
            }
        }
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        if launchedBefore == false {
            
            
            print("wb this bad boy")
            UserDefaults.standard.set("0", forKey: "meatTotal")
            UserDefaults.standard.set("0", forKey: "vegetableTotal")
            UserDefaults.standard.set("0", forKey: "fruitTotal")
            UserDefaults.standard.set("0", forKey: "dairyTotal")
            UserDefaults.standard.set("0", forKey: "grainsTotal")
            
            storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootController = storyboard!.instantiateViewController(withIdentifier: "start")
            
            if let window = self.window {
                window.rootViewController = rootController
            }
            
        }
        else {
            storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootController = storyboard!.instantiateViewController(withIdentifier: "Overview")
            
            if let window = self.window {
                window.rootViewController = rootController
            }
        }
        let shortcutItem1 = UIMutableApplicationShortcutItem(type: "Dynamic01", localizedTitle: NSLocalizedString("Quick Add", comment: ""), localizedSubtitle: nil, icon: nil, userInfo: nil)
        
      
        
        UIApplication.shared.shortcutItems = [shortcutItem1]
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        UserDefaults.standard.set(time.currentDateToString(), forKey: "backGroundDate")

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
//  Use Global variable date of when the date goes into the foreground and turn it to a string. Then we create the variable yest and make it equal to the date the app went into the background. We then check if the two dates are the same and save the bool response to the variable quick add refresh and then make that variable a user default to check if the last access date was yesterday or today.
            GlobalStates.yest = UserDefaults.standard.string(forKey: "backGroundDate") ?? time.currentDateToString()
            let today = time.currentDateToString()
            print(today)
            print(GlobalStates.yest)
            let quickAddRefresh = dateAttributes.isSameDates(date1: GlobalStates.yest, date2: today)
            print(quickAddRefresh)
            UserDefaults.standard.set(quickAddRefresh, forKey: "checkToSeeIfLastAccessWasYesterday")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        
    }
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type{
        case "Dynamic01" :
            storyboard = UIStoryboard(name: "FoodAdd", bundle: nil)
            let rootController = storyboard!.instantiateViewController(withIdentifier: "QuickAdd")
            window?.rootViewController = rootController
        default:
        break
    }
    completionHandler(true)
}


}

