//
//  Recommendations.swift
//  TrackITClient
//
//  Created by Jack Wright on 2018-07-28.
//  Copyright © 2018 Group 9. All rights reserved.
//

import Foundation
import UIKit


class recommend {
    
    static weak var viewController: viewControl!
    func recommendIt()->Array<String> {
        //recommendations based on food group
        let counterM = ((Float(UserDefaults.standard.string(forKey: "meatTotal") ?? "0") ?? 0) / 3) * 100
        let counterV = ((Float(UserDefaults.standard.string(forKey: "vegetableTotal") ?? "0") ?? 0) / 5) * 100
        let counterF = ((Float(UserDefaults.standard.string(forKey: "fruitTotal") ?? "0") ?? 0) / 5) * 100
        let counterD = ((Float(UserDefaults.standard.string(forKey: "dairyTotal") ?? "0") ?? 0) / 3) * 100
        let counterG = ((Float(UserDefaults.standard.string(forKey: "grainsTotal") ?? "0") ?? 0) / 8) * 100
        print("loop")
        
        var comparr = Array<Float>()
        var comphold = 4926
        var comphold2 = 982
        var compholdindx = 0
        var compholdindx2 = 0
        var ind = 0
        var finalarr = Array<String>()
        comparr = [counterM,counterV,counterF,counterD,counterG]
        
        if let first = comparr.first {
            for elem in comparr {
                print(elem)
                if elem != first {
                    comphold = 1253716
                }
            }
        }
        if (comphold != 1253716) {
            print("fart in my bed")
            comphold = 5
            comphold2 = 5
            compholdindx = 5
            compholdindx2 = 5
        }
        
        
        while (ind < 5) && (comphold != 5) {
            print("ind and hold")
            print(comparr[ind])
            print(comphold)
            if comparr[ind] < Float(comphold) {
                comphold = Int(comparr[ind])
                compholdindx = ind
                print("Index1")
                print(compholdindx)
            }
            
            ind = ind + 1
        }
        
        ind = 0
        
        while (ind < 5) && (comphold != 5) {
            if (((comparr[ind]) < (Float(comphold2))) && (ind != compholdindx)) {
                comphold2 = Int(comparr[ind])
                compholdindx2 = ind
                print("Index2")
                print(compholdindx2)
            }
            ind = ind + 1
        }
        
        print(compholdindx)
        print(compholdindx2)

        
        switch compholdindx {
        case 0:
            finalarr = ["Meat"]
        case 1:
            finalarr = ["Vegetable"]
        case 2:
            finalarr = ["Fruit"]
        case 3:
            finalarr = ["Dairy"]
        case 4:
            finalarr = ["Grain"]
        default:
            finalarr = ["Equal"]
        }
        
        switch compholdindx2 {
        case 0:
            finalarr += ["Meat"]
        case 1:
            finalarr += ["Vegetable"]
        case 2:
            finalarr += ["Fruit"]
        case 3:
            finalarr += ["Dairy"]
        case 4:
            finalarr += ["Grain"]
        default:
            finalarr += ["Equal"]
        }
        
        return finalarr
    }

    func randomPickFrom (foodGroup: String, otherindex: String) -> Array<String> {
        var foodarr = Array<String>()
        var returnarr: Array<String> = ["","",""]
        if foodGroup == "Meat" {
            foodarr = ["Pork", "Chicken", "Turkey", "Lean Beef", "Eggs", "Salmon", "Tuna, Ahi", "Halibut", "Shrimp", "Turkey Bacon"]
        }
        else if foodGroup == "Vegetable" {
            foodarr = ["Carrots","Asparagus","Spinach","Broccoli","Brussel Sprouts","Peas","Corn","Peppers","Mushroom","Cabbage","Beans","Cauliflower"]
        }
        else if foodGroup == "Fruit" {
            foodarr = ["Apple","Orange","Pear","Berries","Banana","Mango","Plum","Pineapple","Peach","Watermelon","GrapeFruit"]
        }
        else if foodGroup == "Dairy" {
            foodarr = ["Yogurt","Milk","Cheddar Cheese","Blue Cheese","Goat Cheese","Mozarella Cheese","Havarti Cheese","Chocolate Milk"]
        }
        else if foodGroup == "Grain" {
            foodarr = ["Spaghetti Noodles","Rice","Whole Wheat Bread","Linguini","White Bread","Breakfast Cereal","Bagel","Muffin","Bun","Baguette"]
        }
        else {
            foodarr = [ "Pork", "Chicken", "Turkey", "Lean Beef", "Eggs", "Salmon", "Tuna, Ahi", "Halibut", "Shrimp", "Turkey Bacon","Carrots","Asparagus","Spinach","Broccoli","Brussel Sprouts","Peas","Corn","Peppers","Mushroom","Cabbage","Beans","Cauliflower","Apple","Orange","Pear","Berries","Banana","Mango","Plum","Pineapple","Peach","Watermelon","GrapeFruit","Yogurt","Milk","Cheddar Cheese","Blue Cheese","Goat Cheese","Mozarella Cheese","Havarti Cheese","Chocolate Milk","Spaghetti Noodles","Rice","Whole wheat bread","Linguini","White Bread","Breakfast Cereal","Bagel","Muffin","Bun","Baguette"]
        }
        var rand = Int(arc4random_uniform(UInt32(foodarr.count)))

        while (String(rand) == otherindex) {
            print(rand)
            rand = Int(arc4random_uniform(UInt32(foodarr.count)))
        }
        returnarr[0] = foodarr[rand]
        returnarr[1] = String(rand)
        if (foodarr.count > 15) {
            if (rand < 10) {
                returnarr[2] = "Meat"
            }
            else if (rand >= 10) && (rand < 22) {
                returnarr[2] = "Vegetables"
            }
            else if (rand >= 22) && (rand < 34) {
                returnarr[2] = "Fruit"
            }
            else if (rand >= 34) && (rand < 43) {
                returnarr[2] = "Dairy"
            }
            else {
                returnarr[2] = "Grains"
            }
        }
        return returnarr
    }
}


