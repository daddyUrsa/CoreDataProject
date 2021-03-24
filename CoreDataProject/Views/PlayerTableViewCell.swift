//
//  PlayerTableViewCell.swift
//  CoreDataProject
//
//  Created by Alexey Pavlov on 23.03.2021.
//

import UIKit

final class PlayerTableViewCell: UITableViewCell {

    var player: Player? {
        didSet {
            playerNameLabel.text = player?.fullName
            playerNumberLabel.text = String(player?.number ?? 0)
            if let data = player?.image as Data? {
                playerImage.image = UIImage(data: data)
            }
            nationalityLabel.text = player?.nationality
            teamLabel.text = player?.club
            positionLabel.text = player?.position
            ageLabel.text = String(player?.age ?? 0)
        }
    }
    
    private var playerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.backgroundColor = .black

        return imageView
    }()
    private var playerNumberLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .center
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        
        return label
    }()
    private var playerNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()

        return label
    }()
    private var teamCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Team"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.toAutoLayout()

        return label
    }()
    private var nationalityCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Nationality"
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
    private var ageCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.toAutoLayout()

        return label
    }()
    private var teamLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()

        return label
    }()
    private var nationalityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()

        return label
    }()
    private var positionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()

        return label
    }()
    private var ageLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        contentView.backgroundColor = .lightGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func cellDataFill(player: Players) {
        playerNumberLabel.text = String(player.playerNumber)
        playerNameLabel.text = player.fullName
    }

    private func setupViews() {
        contentView.addSubviews(playerNumberLabel, playerNameLabel, playerImage, teamCaptionLabel, nationalityCaptionLabel, positionCaptionLabel, ageCaptionLabel, teamLabel, nationalityLabel, positionLabel, ageLabel)
        NSLayoutConstraint.activate([
            playerNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            playerNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            playerNumberLabel.widthAnchor.constraint(equalToConstant: 30),
            playerNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            playerNameLabel.leadingAnchor.constraint(equalTo: playerNumberLabel.trailingAnchor, constant: 10),
            playerImage.topAnchor.constraint(equalTo: playerNumberLabel.bottomAnchor, constant: 16),
            playerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            playerImage.widthAnchor.constraint(equalToConstant: 150),
            playerImage.heightAnchor.constraint(equalToConstant: 150),
            playerImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            teamCaptionLabel.topAnchor.constraint(equalTo: playerImage.topAnchor, constant: 10),
            teamCaptionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 16),
            nationalityCaptionLabel.topAnchor.constraint(equalTo: teamCaptionLabel.bottomAnchor, constant: 16),
            nationalityCaptionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 16),
            positionCaptionLabel.topAnchor.constraint(equalTo: nationalityCaptionLabel.bottomAnchor, constant: 16),
            positionCaptionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 16),
            ageCaptionLabel.topAnchor.constraint(equalTo: positionCaptionLabel.bottomAnchor, constant: 16),
            ageCaptionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 16),
            teamLabel.topAnchor.constraint(equalTo: playerImage.topAnchor, constant: 10),
            teamLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 120),
            nationalityLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 16),
            nationalityLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 120),
            positionLabel.topAnchor.constraint(equalTo: nationalityLabel.bottomAnchor, constant: 16),
            positionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 120),
            ageLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 16),
            ageLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 120)
        ])
    }
}
