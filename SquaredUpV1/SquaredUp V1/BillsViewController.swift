//
//  BillsViewController.swift
//  SquaredUp V1
//
//  Created by Sam Ruben on 4/14/18.
//  Copyright © 2018 Sam Ruben. All rights reserved.
//

import UIKit

class BillsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol  {


    
    var feedItems: NSArray = NSArray()
    var selectedLocation : LocationModel = LocationModel()
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates and initialize homeModel
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
    }
    @IBAction func backButton(_ sender: Any) {
        let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(menuViewController, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let addBillViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddBillViewController") as! AddBillViewController
        self.present(addBillViewController, animated: true)
    }
    
    
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.listTableView.reloadData()
        print(feedItems)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: LocationModel = feedItems[indexPath.row] as! LocationModel
        // Get references to labels of cell
        myCell.textLabel!.text = "Name: \(item.name!)  |  Bill: \(item.bill!)  |  Owe: \(item.owe!)  |  Paid:\(item.amount!)"
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set selected location to var
        selectedLocation = feedItems[indexPath.row] as! LocationModel
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get reference to the destination view controllerr
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        
    }
}
