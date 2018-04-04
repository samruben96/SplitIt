//
//  GroupViewController.swift
//  SquaredUp V1
//
//  Created by Sam Ruben on 4/4/18.
//  Copyright © 2018 Sam Ruben. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    
   
    @IBOutlet weak var tableView: UITableView!
    
    
    var grp = [String]()
    
    
    
    @IBAction func backButton(_ sender: Any) {
        let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(menuViewController, animated: true)
    }
    
    
   
    @IBAction func onAddTapped(_ sender: Any) {
    
    

    
    
        let alert = UIAlertController(title:"Add Group", message:nil, preferredStyle: .alert)
        alert.addTextField { (groupTF) in groupTF.placeholder = "Enter Group"
        }
        let action = UIAlertAction(title:"Add", style:.default){ (_) in
            guard let group = alert.textFields?.first?.text else { return }
            print(group)
            self.add(group)
            
            
        }
        alert.addAction(action)
        present(alert,animated: true)
    }
    func add(_ group: String) {
        let index = 0
        grp.insert(group, at: 0)
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        
        
        
    }
   

}

extension GroupViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let group = grp[indexPath.row]
        cell.textLabel?.text = group
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        grp.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

