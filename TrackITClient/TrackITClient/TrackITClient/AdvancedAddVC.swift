//
//  AdvancedAddVC.swift
//  TrackITClient
//
//  Created by Jack Wright on 2018-07-05.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

class AdvancedAddVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var advancedTextField: UITextField!
    @IBOutlet weak var advancedSuggestions: UITableView!
    @IBOutlet weak var anyStepper: UIStepper!
    @IBOutlet weak var anyLabel: UILabel!
    @IBOutlet weak var anyCount: UILabel!
    @IBOutlet weak var submit: UIButton!
    
    
    @IBAction func anyStepped(_ sender: UIStepper) {
        anyCount.text = Int(sender.value).description
    }
    
    @IBAction func submitIt(_ sender: UIButton) {
        anyCount.text = "0"
        anyStepper.value = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advancedTextField.delegate = self
        advancedSuggestions.delegate = self
        
        anyStepper.wraps = false
        anyStepper.autorepeat = true
        anyStepper.maximumValue = 10
        
        
    }
    
    //Food Groups: Meats: 1, Veggies: 2, Fruit: 3, Dairy: 4, Grains: 5
    
    var autoComplete = [String]()
    var autoCompletionPossibilities = ["Apple": 3, "Pineapple": 2, "Orange": 1]
    var autoCompleteCharacterCount = 0
    var timer = Timer()
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        searchAutoCompleteEntriesWithSubstring(substring: substring)
        
        return true
    }
    
    func searchAutoCompleteEntriesWithSubstring (substring: String) {
        
        autoComplete.removeAll(keepingCapacity: false)
        let lazyMapCollection = autoCompletionPossibilities.keys
        let stringArray = Array(lazyMapCollection.map { String($0) })

        for keys in stringArray {
            
           
            let myString:NSString! = keys as NSString
            let substringRange: NSRange! = myString.range(of: substring)
            
            if (substringRange.location == 0)
            {
                autoComplete.append(keys)
            }
            
        }
        advancedSuggestions.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let index = indexPath.row as Int
        cell.textLabel!.text = autoComplete[index]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = advancedSuggestions.cellForRow(at: indexPath)!
        let Label = selectedCell.textLabel
        advancedTextField.text = Label?.text
    }
}
