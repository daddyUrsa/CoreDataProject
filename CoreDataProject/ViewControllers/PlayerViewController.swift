//
//  PlayerViewController.swift
//  CoreDataProject
//
//  Created by Alexey Pavlov on 23.03.2021.
//

import UIKit

class PlayerViewController: UIViewController {

    private var playerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.backgroundColor = .black

        return imageView
    }()
    private var playerNumberLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.backgroundColor = .systemIndigo

        return label
    }()
    private var nameTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.toAutoLayout()

        return textField
    }()
    private var nationalityTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nationality"
        textField.toAutoLayout()

        return textField
    }()
    private var ageTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Age"
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
    }
}
