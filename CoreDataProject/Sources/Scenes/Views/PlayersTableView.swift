//
//  PlayersTableView.swift
//  CoreDataProject
//
//  Created by Alexey Golovin on 28.03.2021.
//

import UIKit

class PlayersTableView: UIView {
    private let cellID = "cellID"
    private let coreDataPerform = CoreDataPerform()

    private var players: [Player] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .red
        
        return tableView
    }()
    
    private func playersDataPrepare() {
        players = coreDataPerform.fetchPlayer()
        if players.isEmpty {
            emptyPlayerAlert()
        }
        tableView.reloadData()
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
            backgroundColor = .brown
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
//    private func setupNavigationBar() {
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaped))
////        navigationItem.rightBarButtonItem = addButton
//    }
//    
//    @objc private func addTaped() {
//        let vc = AddPlayerViewController()
////        navigationController?.pushViewController(vc, animated: true)
//    }
}

extension PlayersTableView: UITableViewDataSource, UITableViewDelegate {
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
//            self.addTaped()
        }
        alert.addAction(okButton)
//        present(alert, animated: true, completion: nil)
    }
}


