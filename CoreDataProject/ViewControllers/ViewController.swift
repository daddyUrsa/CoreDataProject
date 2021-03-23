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
        tableView.backgroundColor = .cyan
//        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: cellID)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchPlayer()
        navigationBarSetup()
        players.forEach { print("\($0.fullName ?? "") - \($0.nationality ?? "")") }
        
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
        let addButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTaped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addTaped() {
        let vc = PlayerViewController()
        navigationController?.pushViewController(vc, animated: true)
/*
        let alert = UIAlertController(title: "Add player", message: "Enter name", preferredStyle: .alert)
        alert.addTextField()
        
        let addPlayerButton = UIAlertAction(title: "Add", style: .default) { action in
            let textField = alert.textFields![0]
            
            // Create player
            let player = Player(context: self.context)
            player.fullName = textField.text
            player.age = 34
            player.number = 1334
            
            // Save data
            do {
                try self.context.save()
            }
            catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            // Reload data
            self.fetchPlayer()
        }
        alert.addAction(addPlayerButton)
        present(alert, animated: true, completion: nil)
 */
    }
    
    func fetchPlayer() {
        do {
            self.players =  try! context.fetch(Player.fetchRequest())
        }
    }
    
    func createPlayer() {
        

    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let cell: PlayerTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! PlayerTableViewCell
        let player = players[indexPath.row]
        cell.player = player
//        cell.textLabel?.text = players[indexPath.row].fullName
        return cell
    }
    
    
}

