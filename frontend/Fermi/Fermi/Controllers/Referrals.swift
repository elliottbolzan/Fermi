//
//  FirstViewController.swift
//  Fermi
//
//  Created by Davis Booth on 11/2/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Referrals: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewReferredMe: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    

    // variables to populate table views
    var dataArray: [[String]] = [
        ["Emily Mi", "Microsoft", "Waiting for response"], ["Davis Booth", "Facebook", "Referred"], ["Jamie Palka", "Google", "Offered"]
    ]
    var dataArray2: [[String]] = [
        ["Emily Mi", "Microsoft", "Nov 16"]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up Table View Controllers
        tableView.delegate = self
        tableView.dataSource = self
        tableViewReferredMe.delegate = self
        tableViewReferredMe.dataSource = self
        
        toolbar.delegate = self
        
        // Creates the nib for the table views to reference
        let nibName1 = UINib(nibName: "referralCell", bundle: nil)
        
        //registers the nib for use with the table views
        tableView.register(nibName1, forCellReuseIdentifier: "referralCell")
        tableViewReferredMe.register(nibName1, forCellReuseIdentifier: "referralCell")
        
        
        // Sets up the initial view by hiding and unhiding table views
        tableViewReferredMe.isHidden = true
        tableView.isHidden = false
        
        // Defaults the segmented control to the first index
        segmentedControl.selectedSegmentIndex = 0
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillAppear(_ animated: Bool) {
        hideHairline()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        showHairline()
    }
    
    // Every time the index is changed
    @IBAction func indexChanged(_ sender: Any) {
        
        // Hide and unhide tables upon switching indices of the segmented control.
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.isHidden = false
            tableViewReferredMe.isHidden = true
            tableView.reloadData()
        }
        else {
            tableViewReferredMe.isHidden = false
            tableView.isHidden = true
            tableViewReferredMe.reloadData()
        }
    }
    

}



// Handle all table view delegate
extension Referrals {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return dataArray.count
        }
        else {
            return dataArray2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Populate info based on which table we are using
        var info: [String] = []
        if tableView == self.tableView {
            info = dataArray[indexPath.item]
        }
        else {
            info = dataArray2[indexPath.item]
        }
        
        // Configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "referralCell", for: indexPath) as! referralCell
        cell.fullInit(info[0], company: info[1], status: info[2])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
}

extension Referrals: UIToolbarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
}
