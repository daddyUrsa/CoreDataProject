//
//  PlayerViewController.swift
//  CoreDataProject
//
//  Created by Alexey Pavlov on 23.03.2021.
//

import UIKit

class PlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    private let pickerData = [["Club 1", "Club 2", "Club 3", "Club 4", "Club 5"], ["Position 1", "Position 2", "Position 3", "Position 4", "Position 5"]]
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var playerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.backgroundColor = .black

        return imageView
    }()
    private var playerNumberTF: UITextField = {
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
    private var nameTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.toAutoLayout()

        return textField
    }()
    private var nationalityTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nationality"
        textField.borderStyle = .roundedRect
        textField.toAutoLayout()

        return textField
    }()
    private var ageTF: UITextField = {
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
    private var positionCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Position"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        
        teamPicker.dataSource = self
        teamPicker.delegate = self
        positionPicker.dataSource = self
        positionPicker.delegate = self
        view.backgroundColor = .white
        setupViews()
    }
    
    @objc func imagePickerTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        let player = Player(context: self.context)
        player.fullName = nameTF.text
        player.nationality = nationalityTF.text
        player.age = Int16(ageTF.text ?? "0") ?? 0
        player.number = Int16(playerNumberTF.text ?? "0") ?? 0
        player.club = pickerData[0][teamPicker.selectedRow(inComponent: 0)]
        player.position = pickerData[1][teamPicker.selectedRow(inComponent: 0)]
        if let image = playerImage.image {
            player.image = image.jpegData(compressionQuality: 0.75)
        }
        
        // Save data
        do {
            try self.context.save()
        }
        catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        print(teamPicker.selectedRow(inComponent: 0))
        print(teamPicker.selectedRow(inComponent: 1))
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        view.addSubviews(playerImage, playerNumberTF, imagePickerButton, nameTF, nationalityTF, ageTF, teamCaptionLabel, positionCaptionLabel, teamPicker, saveButton)
        NSLayoutConstraint.activate([
            playerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            playerImage.widthAnchor.constraint(equalToConstant: 200),
            playerImage.heightAnchor.constraint(equalToConstant: 200),
            playerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerNumberTF.topAnchor.constraint(equalTo: playerImage.topAnchor, constant: 12),
            playerNumberTF.trailingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: -12),
            playerNumberTF.widthAnchor.constraint(equalToConstant: 30),
            playerNumberTF.heightAnchor.constraint(equalToConstant: 30),
            imagePickerButton.topAnchor.constraint(equalTo: playerImage.bottomAnchor),
            imagePickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTF.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: 16),
            nameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTF.widthAnchor.constraint(equalToConstant: 300),
            nationalityTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 10),
            nationalityTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nationalityTF.widthAnchor.constraint(equalToConstant: 300),
            ageTF.topAnchor.constraint(equalTo: nationalityTF.bottomAnchor, constant: 10),
            ageTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            ageTF.widthAnchor.constraint(equalToConstant: 300),
            teamCaptionLabel.topAnchor.constraint(equalTo: ageTF.bottomAnchor, constant: 20),
            teamCaptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            teamPicker.topAnchor.constraint(equalTo: teamCaptionLabel.bottomAnchor),
            teamPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            positionCaptionLabel.topAnchor.constraint(equalTo: ageTF.bottomAnchor, constant: 20),
            positionCaptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
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


extension PlayerViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
}

