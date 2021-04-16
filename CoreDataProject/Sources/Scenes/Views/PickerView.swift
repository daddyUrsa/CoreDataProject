//
//  PickerView.swift
//  CoreDataProject
//
//  Created by Alexey Pavlov on 08.04.2021.
//

import UIKit

class PickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    private let teamPickerData = ["Club 111", "Club 222", "Club 3", "Club 4", "Club 5"]
    private let positionPickerData = ["Position 1", "Position 2", "Position 3", "Position 4", "Position 5"]
    
    let teamPicker = UIPickerView()
    let positionPicker = UIPickerView()
    var teamPickerText = ""
    var positionPickerText = ""
//    private let teamTextField: UITextField
//    private let positionTextField: UITextField
    
    private func pickersSetup() {
//        teamTextField.inputView = teamPicker
        teamPicker.dataSource = self
        teamPicker.delegate = self
//        positionTextField.inputView = positionPicker
        positionPicker.dataSource = self
        positionPicker.delegate = self
        dismissPickerView()
    }
    
    init() {
//        self.teamTextField = teamTextField
//        self.positionTextField = positionTextField
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        pickersSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
//        teamTextField.inputAccessoryView = toolBar
//        positionTextField.inputAccessoryView = toolBar
    }
    @objc private func doneButtonPressed() {
          endEditing(true)
    }
}

extension PickerView {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == teamPicker {
            return teamPickerData.count
        } else {
            return positionPickerData.count
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == teamPicker {
            return teamPickerData[row]
        } else {
            return positionPickerData[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == teamPicker {
            teamPickerText = teamPickerData[row]
        } else {
            positionPickerText = positionPickerData[row]
        }
        
    }
}
