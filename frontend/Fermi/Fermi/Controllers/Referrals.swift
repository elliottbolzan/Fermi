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

    var forMe = [Referral]()
    var forThem = [Referral]()

    // variables to populate table views
    var dataArray: [[String]] = [
        ["Emily Mi", "Microsoft", "Waiting for response"], ["Davis Booth", "Facebook", "Referred"], ["Jamie Palka", "Google", "Offered"]
    ]
    var dataArray2: [[String]] = [
        ["Emily Mi", "Microsoft", "Nov 16"]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolbar.delegate = self
        setupTableViews()
        segmentedControl.selectedSegmentIndex = 0
        self.navigationController?.navigationBar.prefersLargeTitles = true
        refresh()
    }
    
    func setupTableViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableViewReferredMe.delegate = self
        tableViewReferredMe.dataSource = self
        let referralCell = UINib(nibName: "referralCell", bundle: nil)
        tableView.register(referralCell, forCellReuseIdentifier: "referralCell")
        tableViewReferredMe.register(referralCell, forCellReuseIdentifier: "referralCell")
        tableViewReferredMe.isHidden = true
        tableView.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        hideHairline()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        showHairline()
    }
    
}

extension Referrals {
    
    func refresh() {
        Server.getReferralsFor(id: User.shared.person!.id, completion: { a, b in
            self.forMe = a
            self.forThem = b
            self.tableView.reloadData()
            self.tableViewReferredMe.reloadData()
        })
    }
    
}

extension Referrals {
    
    @IBAction func indexChanged(_ sender: Any) {
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

extension Referrals {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return forMe.count
        }
        else {
            return forThem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var referral: Referral
        if tableView == self.tableView {
            referral = forMe[indexPath.item]
        }
        else {
            referral = forThem[indexPath.item]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "referralCell", for: indexPath) as! ReferralCell
        cell.setup(referral: referral)
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
