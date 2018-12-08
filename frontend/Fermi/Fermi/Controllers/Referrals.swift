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
    @IBOutlet weak var referredMe: UITableView!
    @IBOutlet weak var referredThem: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var forMe = [Referral]()
    var forThem = [Referral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolbar.delegate = self
        setupTableViews()
        segmentedControl.selectedSegmentIndex = 0
        self.navigationController?.navigationBar.prefersLargeTitles = true
        refresh()
    }
    
    func setupTableViews() {
        referredMe.delegate = self
        referredMe.dataSource = self
        referredThem.delegate = self
        referredThem.dataSource = self
        referredMe.refreshControl = createRefreshControl()
        referredThem.refreshControl = createRefreshControl()
        let referralCell = UINib(nibName: "ReferralCell", bundle: nil)
        referredMe.register(referralCell, forCellReuseIdentifier: "ReferralCell")
        referredThem.register(referralCell, forCellReuseIdentifier: "ReferralCell")
        referredThem.isHidden = true
        referredMe.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        hideHairline()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        showHairline()
    }
    
}

extension Referrals {
    
    func createRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(Referrals.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Constants.tint
        return refreshControl
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    func refresh() {
        Server.getReferralsFor(id: User.shared.person!.id, completion: { a, b in
            self.forMe = a
            self.forThem = b
            self.referredMe.reloadData()
            self.referredThem.reloadData()
        })
    }
    
}

extension Referrals {
    
    @IBAction func indexChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            referredMe.isHidden = false
            referredThem.isHidden = true
            referredMe.reloadData()
        }
        else {
            referredThem.isHidden = false
            referredMe.isHidden = true
            referredThem.reloadData()
        }
    }
    
}

extension Referrals {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.referredMe {
            return forMe.count
        }
        else {
            return forThem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var referral: Referral
        if tableView == self.referredMe {
            referral = forMe[indexPath.item]
        }
        else {
            referral = forThem[indexPath.item]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReferralCell", for: indexPath) as! ReferralCell
        cell.setup(controller: self, referral: referral)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension Referrals: UIToolbarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
}
