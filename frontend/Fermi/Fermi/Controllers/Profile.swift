//
//  Profile.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Profile: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var horizontalStack: UIStackView!
    @IBOutlet weak var givenLabel: UILabel!
    @IBOutlet weak var receivedLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // person variable
    var person: Person?
    
    // Data arrays
    var educationArray: [String] = ["someValue"] {
        didSet {
            tableView.reloadData()
        }
    }
    var experienceArray: [String] = ["someValue"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupProfileImage()
        
        profileName.text = "Davis Booth"
        givenLabel.text = "10 Given"
        givenLabel.text = "20 Rec'd"
        
        //Set up FRIEND Table View Controller
        tableView.delegate = self
        tableView.dataSource = self
        
        //Creates the nib for the table view to reference
        let nibName1 = UINib(nibName: "educationCell", bundle: nil)
        let nibName2 = UINib(nibName: "experienceCell", bundle: nil)
        
        
        //registers the nib for use with the table views
        tableView.register(nibName1, forCellReuseIdentifier: "educationCell")
        tableView.register(nibName2, forCellReuseIdentifier: "experienceCell")
        
        
        
        
    }
    
    
    
    @IBAction func indexChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    fileprivate func setupProfileImage() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return educationArray.count
        }
        else {
            return experienceArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "educationCell", for: indexPath) as! educationCell
            cell.fullInit("Duke University", year: 2021, major: "Computer Science", majorType: "B.S.")
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! experienceCell
            cell.fullInit(NSMutableAttributedString(string: "SubPar Company"), date: ["February 2018", "present"], position: NSMutableAttributedString(string: "VP of Being a Douche"))
            return cell
        }
    }
    
    
    
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
    }

}
