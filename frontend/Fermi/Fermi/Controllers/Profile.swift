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
    
    var isInEditMode = false
    
    
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
        
        // Set up all Profile image stuff.
        setupProfileImage()
        
        
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
    }
    
    func setUpInternal() {
        requestButton.isHidden = true
        sendButton.isHidden = true
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editButtonPressed(_:)))
    }
    
    @objc func editButtonPressed(_ sender: Any) {
        if !self.isInEditMode {
            self.isInEditMode = true
            navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = "Done"
            tableView.reloadData()
        }
        else {
            self.isInEditMode = false
            navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = "Edit"
            tableView.reloadData()
        }
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
        
        
        //registers the nib for use with the table views
        tableView.register(nibName1, forCellReuseIdentifier: "educationCell")
        tableView.register(nibName2, forCellReuseIdentifier: "experienceCell")
    }
    
    func initializeCollectionView() {
        
        // Set background transparent
        collectionView.backgroundColor = self.view.backgroundColor
        
        //Set up Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func setupProfileImage() {
//        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
//        profileImage.contentMode = .scaleAspectFill
//        profileImage.clipsToBounds = true
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
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 1 {
            return person.education.count
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            return person.experience.count
        }
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "educationCell", for: indexPath) as! educationCell
            let currentEducation = person.education[indexPath.item]
            cell.fullInit(currentEducation.university, year: 2021, majorType: currentEducation.degreeType)
            cell.backgroundColor = self.view.backgroundColor
            return cell
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! experienceCell
            cell.isInEditMode = self.isInEditMode
            let currentEducation = person.experience[indexPath.item]
            cell.fullInit(currentEducation.company, date: [currentEducation.startdate, currentEducation.enddate as? String ?? "present"], position: currentEducation.position)
            cell.backgroundColor = self.view.backgroundColor
            return cell
        }
        else { return UITableViewCell() }
    }
}



// Handles all CollectionView stuff
extension Profile {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statsCell", for: indexPath) as! statsCell
        //print(indexPath.item)
        print(person)
        //cell.fullInit(person.qualities[indexPath.item].percentile, description: person.qualities[indexPath.item].name)
        cell.fullInit(90, description: "Blah")
        cell.backgroundColor = self.view.backgroundColor
        return cell
    }
}
