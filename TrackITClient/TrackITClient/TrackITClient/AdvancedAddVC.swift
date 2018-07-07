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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advancedTextField.delegate = self
        advancedSuggestions.delegate = self
        
        
    }
    
    
    var autoComplete = [String]()
    var autoCompletionPossibilities = ["Apple", "Pineapple", "Orange"]
    var autoCompleteCharacterCount = 0
    var timer = Timer()
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        searchAutoCompleteEntriesWithSubstring(substring: substring)
        
        return true
    }
    
    func searchAutoCompleteEntriesWithSubstring (substring: String) {
        
        autoComplete.removeAll(keepingCapacity: false)
        
        for key in autoCompletionPossibilities {
            
            let myString:NSString! = key as NSString
            let substringRange: NSRange! = myString.range(of: substring)
            
            if (substringRange.location == 0)
            {
                autoComplete.append(key)
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
