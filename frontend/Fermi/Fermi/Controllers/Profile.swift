//
//  Profile.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Profile: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    // Outlets
    @IBOutlet weak var profilePic: PolyImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // person variable -- stores data arrays necessary for cell population.
    var person: Person = User.shared.person!
    
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    var personIsUser = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // determines if person variable is the user themself.
        if !person.equals(Person2: User.shared.person!) {
            personIsUser = false
            setUpExternal()
        }
        else {
            setUpInternal()
        }
        profilePic.imageView.image = #imageLiteral(resourceName: "wallpaper.wiki-Free-Download-Fruit-Background-PIC-WPD004648")
        
        // Set selected index to 0
        segmentedControl.selectedSegmentIndex = 0
        
        
        // sets background color
        if self.view.backgroundColor == UIColor.white {
            self.view.backgroundColor = State.shared.colorFor(id: User.shared.person!.id)
        }
        
        profileName.text = person.name
        
        // Initialize Views for segmented control
        initializeTableView()
        initializeCollectionView()
        
        
        // Show the view for the first segmented control index.
        collectionView.isHidden = false
        tableView.isHidden = true
        
        // In order to allow switching between tabs
        collectionView.reloadData()
        tableView.reloadData()
        
    }
    
    func setUpExternal() {
        requestButton.isHidden = false
        sendButton.isHidden = false
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Actions", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionsPressed(_:)))
        
    }
    
    @objc func actionsPressed(_ sender: Any) {
        // I was thinking here that we could do a similar thing to what you did in the referrals tab with the alert popping up
        //let alert = UIAlertController(title: "Request or send a referral to " + person.name + "?", message: "", preferredStyle: .actionSheet)
    }
    
    func setUpInternal() {
        requestButton.isHidden = true
        sendButton.isHidden = true
    }
    
    func initializeTableView() {
        
        // Set background transparent
        tableView.backgroundColor = self.view.backgroundColor
        
        //Set up Table View Controller
        tableView.delegate = self
        tableView.dataSource = self
        
        //Creates the nib for the table view to reference
        let nibName1 = UINib(nibName: "educationCell", bundle: nil)
        let nibName2 = UINib(nibName: "experienceCell", bundle: nil)
        let nibName3 = UINib(nibName: "addExperience", bundle: nil)
        
        
        //registers the nib for use with the table views
        tableView.register(nibName1, forCellReuseIdentifier: "educationCell")
        tableView.register(nibName2, forCellReuseIdentifier: "experienceCell")
        tableView.register(nibName3, forCellReuseIdentifier: "addExperience")
    }
    
    func initializeCollectionView() {
        
        // Set background transparent
        collectionView.backgroundColor = self.view.backgroundColor
        
        //Set up Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    // Segmented Control configuration
    @IBAction func indexChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            collectionView.isHidden = false
            collectionView.reloadData()
            tableView.isHidden = true
        }
        else {
            collectionView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        print("send referral")
    }
    
    @IBAction func requestButton(_ sender: Any) {
        print("send referral request")
    }
    
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }

}

// Handles all Table View stuff.
extension Profile {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentedControl.selectedSegmentIndex == 1 {
            if indexPath.item > person.education.count { return 30 }
        }
        if segmentedControl.selectedSegmentIndex == 2 {
            if indexPath.item > person.experience.count { return 30 }
        }
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if User.shared.person!.equals(Person2: self.person) {
            if segmentedControl.selectedSegmentIndex == 1 {
                if person.education.count == 3 { return person.education.count }
                else { return person.education.count + 1 }
            }
            else if segmentedControl.selectedSegmentIndex == 2 {
                if person.experience.count == 1 { return person.experience.count }
                else { return person.experience.count + 1 }
            }
            else { return 0 }
        }
        else {
            if segmentedControl.selectedSegmentIndex == 1 {
                return person.education.count
            }
            else {
                return person.experience.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            if indexPath.item >= person.education.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "addExperience", for: indexPath) as! addExperience
                cell.fullInit("Add Education")
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "educationCell", for: indexPath) as! educationCell
                let currentEducation = person.education[indexPath.item]
                cell.fullInit(currentEducation.university, year: 2021, majorType: currentEducation.degreeType)
                cell.backgroundColor = self.view.backgroundColor
                return cell
            }
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            if indexPath.item > person.education.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "addExperience", for: indexPath) as! addExperience
                cell.fullInit("Add Experience")
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! experienceCell
                let currentEducation = person.experience[indexPath.item]
                cell.fullInit(currentEducation.company, date: [currentEducation.startdate, currentEducation.enddate ?? "present"], position: currentEducation.position)
                cell.backgroundColor = self.view.backgroundColor
                return cell
            }
        }
        else { return UITableViewCell() }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if User.shared.person!.equals(Person2: self.person) {
            return true
        }
        else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // TODO: Handle delete for the server
            
            
            
            // Handle delete locally
            if segmentedControl.selectedSegmentIndex == 1 {
                print("deleting education!!")
                person.education.remove(at: indexPath.item)
            }
            else {
                print("deleting experience!!")
                person.experience.remove(at: indexPath.item)
            }
            tableView.reloadData()
        }
    }
    
}



// Handles all CollectionView stuff
extension Profile {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statsCell", for: indexPath) as! statsCell
        cell.fullInit(person.qualities[indexPath.item].percentile, description: person.qualities[indexPath.item].name.capitalized)
        cell.backgroundColor = self.view.backgroundColor
        return cell
    }
}
