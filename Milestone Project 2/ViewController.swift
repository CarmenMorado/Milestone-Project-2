//
//  ViewController.swift
//  Milestone Project 2
//
//  Created by Carmen Morado on 11/23/20.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(restartList))
    }
    
    func startGame() {
        shoppingItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    @objc func promptForItem() {
        let ac = UIAlertController(title: "Enter shopping item", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        shoppingItems.insert(answer, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func restartList() {
        let ac = UIAlertController(title: "Clear the list?", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.startGame()
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }

}

