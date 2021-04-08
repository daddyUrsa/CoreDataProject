//
//  AddPlayerViewController.swift
//  CoreDataProject
//
//  Created by Alexey Pavlov on 23.03.2021.
//

import UIKit

final class AddPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    private let teamPickerData = ["Club 1", "Club 2", "Club 3", "Club 4", "Club 5"]
    private let positionPickerData = ["Position 1", "Position 2", "Position 3", "Position 4", "Position 5"]
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let coreDataPerform = CoreDataPerform()
    private let positionSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["In Play","Bench"])
        segmentControl.toAutoLayout()
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .systemBlue
//        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        return segmentControl
    }()
    private var playerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.backgroundColor = .black

        return imageView
    }()
    private var playerNumberTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "#"
        textField.textAlignment = .center
        textField.toAutoLayout()

        return textField
    }()
    private var imagePickerButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Upload image", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(imagePickerTapped), for: .touchUpInside)
        
        return button
    }()
    private var saveButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        return button
    }()
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.toAutoLayout()

        return textField
    }()
    private var nationalityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nationality"
        textField.borderStyle = .roundedRect
        textField.toAutoLayout()

        return textField
    }()
    private var ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Age"
        textField.borderStyle = .roundedRect
        textField.toAutoLayout()

        return textField
    }()
    private var teamCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Team"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.toAutoLayout()

        return label
    }()
    private var positionTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Position"
        label.toAutoLayout()

        return label
    }()
    private var teamPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.toAutoLayout()
        
        return picker
    }()
    
    private var positionPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.toAutoLayout()
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }
    
    @objc private func imagePickerTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        let player = Player(context: self.context)
        player.fullName = nameTextField.text
        player.nationality = nationalityTextField.text
        player.age = Int16(ageTextField.text ?? "0") ?? 0
        player.number = Int16(playerNumberTextField.text ?? "0") ?? 0
        player.club = teamTextField.text ?? ""
        player.position = positionTextField.text ?? ""
        if let image = playerImage.image {
            player.image = image.jpegData(compressionQuality: 0.75)
        }
        switch positionSegmentControl.selectedSegmentIndex {
        case 0:
            player.inPlay = true
        case 1:
            player.inPlay = false
        default:
            print("")
        }
        coreDataPerform.savePlayer()
        navigationController?.popViewController(animated: true)
        
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
    
    private func setupViews() {
        pickersSetup()
        view.addSubviews(playerImage, playerNumberTextField, imagePickerButton, nameTextField, nationalityTextField, ageTextField, teamCaptionLabel, positionCaptionLabel, saveButton, teamTextField, positionTextField, positionSegmentControl)
        NSLayoutConstraint.activate([
            positionSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            positionSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            positionSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            playerImage.topAnchor.constraint(equalTo: positionSegmentControl.bottomAnchor, constant: 30),
            playerImage.widthAnchor.constraint(equalToConstant: Constants.playerViewImage),
            playerImage.heightAnchor.constraint(equalToConstant: Constants.playerViewImage),
            playerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerNumberTextField.topAnchor.constraint(equalTo: playerImage.topAnchor, constant: 12),
            playerNumberTextField.trailingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: -12),
            playerNumberTextField.widthAnchor.constraint(equalToConstant: Constants.playerNumberTF),
            playerNumberTextField.heightAnchor.constraint(equalToConstant: Constants.playerNumberTF),
            imagePickerButton.topAnchor.constraint(equalTo: playerImage.bottomAnchor),
            imagePickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.textFieldLeading),
            nameTextField.widthAnchor.constraint(equalToConstant: Constants.textFieldWidth),
            nationalityTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constants.textFieldBottom),
            nationalityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.textFieldLeading),
            nationalityTextField.widthAnchor.constraint(equalToConstant: Constants.textFieldWidth),
            ageTextField.topAnchor.constraint(equalTo: nationalityTextField.bottomAnchor, constant: Constants.textFieldBottom),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.textFieldLeading),
            ageTextField.widthAnchor.constraint(equalToConstant: Constants.textFieldWidth),
            teamCaptionLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: Constants.labelBottom),
            teamCaptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.textFieldLeading),
            teamTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: Constants.labelBottom),
            teamTextField.leadingAnchor.constraint(equalTo: teamCaptionLabel.trailingAnchor, constant: Constants.textFieldLeading),
            positionCaptionLabel.topAnchor.constraint(equalTo: teamCaptionLabel.bottomAnchor, constant: Constants.labelBottom),
            positionCaptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.textFieldLeading),
            positionTextField.topAnchor.constraint(equalTo: teamCaptionLabel.bottomAnchor, constant: Constants.labelBottom),
            positionTextField.leadingAnchor.constraint(equalTo: positionCaptionLabel.trailingAnchor, constant: Constants.textFieldLeading),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            playerImage.contentMode = .scaleAspectFit
            playerImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
}

extension AddPlayerViewController {
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

