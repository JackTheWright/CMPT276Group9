//
//  AppDelegate.swift
//  TrackITClient
//
//  Created by Jeremy S on 2018-06-03.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

<<<<<<< HEAD


struct GlobalStates {
    
    static var currentDayDictionary = [String: [String]]()
    static var foreGroundDate = String()
    static var backGroundDate = String()
    static var quickAddRefresh = Bool()
    static var meaties = "0"
    static var veggies = "0"
    static var fruities = "0"
    static var dairies = "0"
    static var grainies = "0"
    
}

=======
>>>>>>> parent of c1fc147... updated
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
<<<<<<< HEAD
        
//        let yesterday = dateAttributes.getFirstDayOfWeek()
//        print(yesterday)
//        GlobalStates.backGroundDate = dateAttributes.currentDateToString()
//
//
//
        
        
        
=======
>>>>>>> parent of c1fc147... updated
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
<<<<<<< HEAD
        
        
//        GlobalStates.foreGroundDate = dateAttributes.currentDateToString()
//
//        GlobalStates.quickAddRefresh = dateAttributes.isSameDates(date1: GlobalStates.backGroundDate, date2: GlobalStates.foreGroundDate)
//
        
        
=======
>>>>>>> parent of c1fc147... updated
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

