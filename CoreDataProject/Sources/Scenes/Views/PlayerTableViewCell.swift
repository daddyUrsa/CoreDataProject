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
    
    //TODO: Не совсем понял зачем это
    override func prepareForReuse() {
        playerImage.image = nil
        playerNumberLabel.text = nil
        playerNameLabel.text = nil
        ageLabel.text = nil
        teamLabel.text = nil
        positionLabel.text = nil
        nationalityLabel.text = nil
    }

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
            playerNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            playerNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            playerNumberLabel.widthAnchor.constraint(equalToConstant: Constants.playerNumberLabel),
            playerNumberLabel.heightAnchor.constraint(equalToConstant: Constants.playerNumberLabel),
            playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            playerNameLabel.leadingAnchor.constraint(equalTo: playerNumberLabel.trailingAnchor, constant: 10),
            playerImage.topAnchor.constraint(equalTo: playerNumberLabel.bottomAnchor, constant: Constants.padding),
            playerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            playerImage.widthAnchor.constraint(equalToConstant: Constants.playerImage),
            playerImage.heightAnchor.constraint(equalToConstant: Constants.playerImage),
            playerImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.padding * -1),
            teamCaptionLabel.topAnchor.constraint(equalTo: playerImage.topAnchor, constant: 10),
            teamCaptionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: Constants.padding),
            nationalityCaptionLabel.topAnchor.constraint(equalTo: teamCaptionLabel.bottomAnchor, constant: Constants.padding),
            nationalityCaptionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: Constants.padding),
            positionCaptionLabel.topAnchor.constraint(equalTo: nationalityCaptionLabel.bottomAnchor, constant: Constants.padding),
            positionCaptionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: Constants.padding),
            ageCaptionLabel.topAnchor.constraint(equalTo: positionCaptionLabel.bottomAnchor, constant: Constants.padding),
            ageCaptionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: Constants.padding),
            teamLabel.topAnchor.constraint(equalTo: playerImage.topAnchor, constant: 10),
            teamLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: Constants.teamLabel),
            nationalityLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: Constants.padding),
            nationalityLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: Constants.teamLabel),
            positionLabel.topAnchor.constraint(equalTo: nationalityLabel.bottomAnchor, constant: Constants.padding),
            positionLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: Constants.teamLabel),
            ageLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: Constants.padding),
            ageLabel.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: Constants.teamLabel)
        ])
    }
}
