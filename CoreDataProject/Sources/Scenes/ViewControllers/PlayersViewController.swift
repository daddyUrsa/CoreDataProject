//
//  PlayersViewController.swift
//  CoreDataProject
//
//  Created by Alexey Golovin on 21.03.2021.
//

import UIKit
import CoreData

final class PlayersViewController: UIViewController {
    let cellID = "cellID"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let coreDataPeroform = CoreDataPerform()
    
    var players: [Player] = []
    
    let requestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Press me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: cellID)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
//        fetchPlayer()
        players = coreDataPeroform.fetchPlayer()
        tableView.reloadData()
        navigationBarSetup()
        if players.isEmpty {
            emptyPlayerAlert()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        fetchPlayer()
        players = coreDataPeroform.fetchPlayer()
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func navigationBarSetup() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addTaped() {
        let vc = AddPlayerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchPlayer() {
        do {
            self.players =  try! context.fetch(Player.fetchRequest())
        }
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
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.context.delete(playerToRemove)
            do {
                try self.context.save()
            }
            catch {

            }
//            self.fetchPlayer()
            self.players = self.coreDataPeroform.fetchPlayer()
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


