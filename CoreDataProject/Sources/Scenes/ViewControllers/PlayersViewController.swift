//
//  PlayersViewController.swift
//  CoreDataProject
//
//  Created by Alexey Golovin on 21.03.2021.
//

import UIKit
import CoreData

final class PlayersViewController: UIViewController {
    private let cellID = "cellID"
    private let coreDataPerform = CoreDataPerform()
    
    let playersTableView = PlayersTableView()
    
    private var players: [Player] = []
    
    private let positionSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["All","In Play","Bench"])
        segmentControl.toAutoLayout()
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        return segmentControl
    }()
    
    private let requestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Press me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: cellID)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupNavigationBar()
        playersDataPrepare()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        players = coreDataPerform.fetchPlayer()
//        players = coreDataPerform.filterPlayers()
        playersDataPrepare()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    private func playersDataPrepare() {
        players = coreDataPerform.fetchPlayer()
//        players = coreDataPerform.filterPlayers(name: "a", age: 10)
        if players.isEmpty {
            emptyPlayerAlert()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        view.addSubviews(positionSegmentControl, tableView)
        NSLayoutConstraint.activate([
            positionSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            positionSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            positionSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: positionSegmentControl.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaped))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTaped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = searchButton
    }
    
    @objc private func addTaped() {
        let vc = AddPlayerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func searchTaped() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .formSheet
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        players = coreDataPerform.filterPlayersInPlay(inPlay: positionSegmentControl.selectedSegmentIndex)
        tableView.reloadData()
    }
}

extension PlayersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! PlayerTableViewCell
        let player = players[indexPath.row]
        cell.player = player
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let playerToRemove = self.players[indexPath.row]
            self.players.remove(at: indexPath.row)
            tableView.performBatchUpdates { // Вроде как более плавная анимация 🤷‍♂️
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            self.coreDataPerform.deletePlayer(player: playerToRemove)
            self.players = self.coreDataPerform.fetchPlayer()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func emptyPlayerAlert() {
        let alert = UIAlertController(title: "Data base is empty. \nAdd player, please.", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) {_ in
            self.addTaped()
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}


