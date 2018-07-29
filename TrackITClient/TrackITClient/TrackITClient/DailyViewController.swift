//
//  DailyViewController.swift
//  TrackITClient
//
//  Created by user143897 on 7/28/18.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {

    @IBOutlet weak var todayLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCurrentDate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let str = formatter.string(from: Date())
        todayLbl.text?.append(str)
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
