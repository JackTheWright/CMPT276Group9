//
//  ViewController2.swift
//  TrackITClient
//
//  Created by Alan Dong on 2018-06-27.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

var name = ""
var gender = ""
var age = ""
var weight = ""

class ViewController2: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var genderOutlet: UITextField!
    @IBOutlet weak var ageOutlet: UITextField!
    @IBOutlet weak var weightOutlet: UITextField!
/*
    @IBAction func nameAction(_ sender: AnyObject) {
        if (nameOutlet.text != "")
        {
            name = nameOutlet.text!
        }
    }
    
    @IBAction func genderAction(_ sender: AnyObject) {
        if (genderOutlet.text != "")
        {
            gender = genderOutlet.text!
        }
    }
    
    @IBAction func ageAction(_ sender: AnyObject) {
        if (ageOutlet.text != "")
        {
            age = ageOutlet.text!
        }
    }
    
    @IBAction func weightAction(_ sender: AnyObject) {
        if (weightOutlet.text != "")
        {
            weight = weightOutlet.text!
        }
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
/*        nameOutlet.delegate = self
        genderOutlet.delegate = self
        ageOutlet.delegate = self
        weightOutlet.delegate = self

   */
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

