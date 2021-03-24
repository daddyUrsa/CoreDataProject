//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Alexey Golovin on 21.03.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let cellID = "cellID"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var players: [Player] = []
    var clubs: [Clubs]?
    var nationalities: [Nationalities]?
    var positions: [Positions]?
    
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
        fetchPlayer()
        tableView.reloadData()
        navigationBarSetup()
        if players.isEmpty {
            let alert = UIAlertController(title: "Data base is empty. \nAdd player, please.", message: nil, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default) {_ in
                self.addTaped()
            }
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPlayer()
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
    
    @objc func addTaped() {
        let vc = PlayerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchPlayer() {
        do {
            self.players =  try! context.fetch(Player.fetchRequest())
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
            self.context.delete(playerToRemove)
            do {
                try self.context.save()
            }
            catch {

            }
            self.fetchPlayer()
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}


