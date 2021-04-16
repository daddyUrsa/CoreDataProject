//
//  SearchViewController.swift
//  CoreDataProject
//
//  Created by Alexey Golovin on 07.04.2021.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private let coreDataPerform = CoreDataPerform()
    
    private let teamPickerData = ["Club 1", "Club 2", "Club 3", "Club 4", "Club 5"]
    private let positionPickerData = ["Position 1", "Position 2", "Position 3", "Position 4", "Position 5"]

    private let teamPicker = UIPickerView()
    private let positionPicker = UIPickerView()
    private let pickerView = PickerView()
    private let playersViewController = PlayersViewController()
    
    private let modalView: UIView = {
        let modalView = UIView()
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 10
        modalView.layer.borderWidth = 10
        modalView.layer.borderColor = CGColor(red: 174/255, green: 183/255, blue: 194/255, alpha: 1)
        
        return modalView
    }()
    
    private let nameSearch: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name contains:"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let ageSearch: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Age"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let chooseSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [">=","=","<="])
        segmentControl.selectedSegmentIndex = 1
        segmentControl.backgroundColor = .systemBlue
        
        return segmentControl
    }()
    
    private var teamCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Team"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.toAutoLayout()

        return label
    }()
    private var teamTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Team"
        label.toAutoLayout()

        return label
    }()
    private var positionCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Position"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.toAutoLayout()

        return label
    }()
    private var positionTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Position"
        label.toAutoLayout()

        return label
    }()
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start search", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(startSearch), for: .touchUpInside)
        
        return button
    }()
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return button
    }()
    
    @objc private func startSearch() {
        let playerName = nameSearch.text ?? ""
        let playerAge = ageSearch.text ?? ""
        let playerPosition = positionTextField.text ?? ""
        let playerTeam = teamTextField.text ?? ""
        fetchedPlayers = coreDataPerform.searchPlayers(name: playerName, age: playerAge, equality: chooseSegmentControl.selectedSegmentIndex, position: playerPosition, team: playerTeam)
        playersViewController.reloadTableView()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.isOpaque = false
        pickersSetup()
        view.addSubviews(modalView, nameSearch, ageSearch, chooseSegmentControl, teamCaptionLabel, teamTextField, positionCaptionLabel, positionTextField, searchButton, resetButton)

        modalView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(400)
        }
        
        nameSearch.snp.makeConstraints {
            $0.top.equalTo(modalView).inset(16)
            $0.left.right.equalTo(modalView).inset(16)
        }
        
        ageSearch.snp.makeConstraints {
            $0.top.equalTo(nameSearch.snp.bottom).offset(16)
            $0.left.equalTo(modalView).inset(16)
            $0.width.equalTo(150)
        }
        
        chooseSegmentControl.snp.makeConstraints {
            $0.top.equalTo(nameSearch.snp.bottom).offset(16)
            $0.left.equalTo(ageSearch.snp.right).offset(10)
            $0.right.equalTo(modalView.snp.right).inset(16)
        }
        
        teamCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(ageSearch.snp.bottom).offset(30)
            $0.left.equalTo(modalView).inset(16)
        }
        
        teamTextField.snp.makeConstraints {
            $0.top.equalTo(ageSearch.snp.bottom).offset(30)
            $0.left.equalTo(teamCaptionLabel.snp.right).offset(10)
            $0.right.equalTo(modalView.snp.right).inset(16)
        }
        
        positionCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(teamCaptionLabel.snp.bottom).offset(30)
            $0.left.equalTo(modalView).inset(16)
        }
        
        positionTextField.snp.makeConstraints {
            $0.top.equalTo(teamCaptionLabel.snp.bottom).offset(30)
            $0.left.equalTo(positionCaptionLabel.snp.right).offset(10)
            $0.right.equalTo(modalView.snp.right).inset(16)
        }
        
        searchButton.snp.makeConstraints {
            $0.bottom.equalTo(modalView.snp.bottom).inset(60)
            $0.centerX.equalToSuperview()
        }
        
        resetButton.snp.makeConstraints {
            $0.bottom.equalTo(modalView.snp.bottom).inset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func pickerSetup() {
        teamTextField.inputView = pickerView.teamPicker
    }
    
    private func pickersSetup() {
        teamTextField.inputView = teamPicker
        teamPicker.dataSource = self
        teamPicker.delegate = self
        positionTextField.inputView = positionPicker
        positionPicker.dataSource = self
        positionPicker.delegate = self
        dismissPickerView()
    }
    
    private func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        teamTextField.inputAccessoryView = toolBar
        positionTextField.inputAccessoryView = toolBar
    }
    @objc private func action() {
          view.endEditing(true)
    }
}

extension SearchViewController {
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
            teamTextField.text = teamPickerData[row]
        } else {
            positionTextField.text = positionPickerData[row]
        }

    }
}
