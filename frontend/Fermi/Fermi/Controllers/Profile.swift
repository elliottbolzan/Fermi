//
//  Profile.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Profile: UIViewController {
    
    @IBOutlet weak var profilePicture: PolyImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var person = User.shared.person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupName()
        setupProfilePicture()
        setupQualities()
        setupExperience()
        setupEducation()
    }
    
    func setupView() {
        self.view.backgroundColor = State.shared.colorFor(id: person.id)
    }
    
    func setupName() {
        self.profileName.text = person.name
        self.profileName.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        self.profileName.textColor = .white
    }
    
    func setupProfilePicture() {
        Server.profilePicture(id: person.id, completion: { image in
            self.profilePicture.imageView.image = image
        })
    }
    
    func setupQualities() {
        
    }
    
    func setupExperience() {
        
    }
    
    func setupEducation() {
        
    }
    
//    func initializeTableView() {
//
//        // Set background transparent
//        tableView.backgroundColor = self.view.backgroundColor
//
//        //Set up Table View Controller
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        //Creates the nib for the table view to reference
//        let nibName1 = UINib(nibName: "educationCell", bundle: nil)
//        let nibName2 = UINib(nibName: "experienceCell", bundle: nil)
//
//
//        //registers the nib for use with the table views
//        tableView.register(nibName1, forCellReuseIdentifier: "educationCell")
//        tableView.register(nibName2, forCellReuseIdentifier: "experienceCell")
//    }
//
//    func initializeCollectionView() {
//
//        // Set background transparent
//        collectionView.backgroundColor = self.view.backgroundColor
//
//        //Set up Collection View
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        //self.navigationController?.isNavigationBarHidden = false
//    }
//
//
//
//    // Segmented Control configuration
//    @IBAction func indexChanged(_ sender: Any) {
//
//        if segmentedControl.selectedSegmentIndex == 0 {
//            collectionView.isHidden = false
//            collectionView.reloadData()
//            tableView.isHidden = true
//        }
//        else {
//            collectionView.isHidden = true
//            tableView.isHidden = false
//            tableView.reloadData()
//        }
//    }
//
//}
//
//// Handles all Table View stuff.
//extension Profile {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if segmentedControl.selectedSegmentIndex == 0 {
//            return educationArray.count
//        }
//        else {
//            return experienceArray.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if segmentedControl.selectedSegmentIndex == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "educationCell", for: indexPath) as! educationCell
//            cell.fullInit("Duke University", year: 2021, major: "Computer Science", majorType: "B.S.")
//            cell.backgroundColor = self.view.backgroundColor
//            return cell
//        }
//        else if segmentedControl.selectedSegmentIndex == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! experienceCell
//            cell.fullInit("SubPar Company", date: ["February 2018", "present"], position: "VP of Being a Douche")
//            cell.backgroundColor = self.view.backgroundColor
//            return cell
//        }
//        else { return UITableViewCell() }
//    }
//}
//
//
//
//// Handles all CollectionView stuff
//extension Profile {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statsCell", for: indexPath) as! statsCell
//        cell.fullInit(90, description: "Generosity")
//        cell.backgroundColor = self.view.backgroundColor
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let education = UIViewController.createWith(identifier: "experience", type: UINavigationController.self)
//        self.present(education, animated: true, completion: nil)
//    }
//    
}
