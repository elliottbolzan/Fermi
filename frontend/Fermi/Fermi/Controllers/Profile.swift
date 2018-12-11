//
//  Profile.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Profile: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var profilePicture: PolyImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var qualityView: UICollectionView!
    @IBOutlet weak var educationView: UITableView!
    @IBOutlet weak var experienceView: UITableView!
    @IBOutlet weak var contactButton: BadgeButton!
    @IBOutlet weak var backButton: UIButton!

    var person: Person = User.shared.person!
    var firstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func setup(person: Person) {
        self.person = person
        sortEducation()
        self.view.backgroundColor = State.shared.colorFor(id: person.id)
        setupName()
        setupProfilePicture()
        setupQualityView()
        setupEducationView()
        setupExperienceView()
        if thisIsMe() {
            setupMe()
        }
        else {
            setupThem()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstLoad {
            firstLoad = false
            return
        }
        self.navigationController?.navigationBar.isHidden = true
        if thisIsMe() {
            User.shared.refresh(completion: { user in
                self.person = user
                self.qualityView.reloadData()
                self.educationView.reloadData()
                self.experienceView.reloadData()
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func thisIsMe() -> Bool {
        return person.id == User.shared.person!.id
    }
    
    func setupName() {
        profileName.text = person.name
        profileName.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        profileName.textColor = .white
    }
    
    func setupProfilePicture() {
        Server.profilePicture(id: person.id, completion: { image in
            self.profilePicture.imageView.image = image
        })
    }
    
    func setupMe() {
        contactButton.isHidden = true
    }
    
    func setupThem() {
        contactButton.isHidden = false
    }
    
    func showBackButton() {
        backButton.isHidden = false
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupEducationView() {
        educationView.backgroundColor = .clear
        educationView.delegate = self
        educationView.dataSource = self
        educationView.register(UINib(nibName: "EducationCell", bundle: nil), forCellReuseIdentifier: "EducationCell")
        educationView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        educationView.isHidden = true
        educationView.tableFooterView = UIView()
    }
    
    func setupExperienceView() {
        experienceView.backgroundColor = .clear
        experienceView.delegate = self
        experienceView.dataSource = self
        experienceView.register(UINib(nibName: "ExperienceCell", bundle: nil), forCellReuseIdentifier: "ExperienceCell")
        experienceView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        experienceView.isHidden = true
        experienceView.tableFooterView = UIView()
    }
    
    func setupQualityView() {
        qualityView.backgroundColor = .clear
        qualityView.delegate = self
        qualityView.dataSource = self
        qualityView.isHidden = false
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            qualityView.isHidden = false
            educationView.isHidden = true
            experienceView.isHidden = true
            qualityView.reloadData()
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            qualityView.isHidden = true
            educationView.isHidden = false
            experienceView.isHidden = true
            educationView.reloadData()
        }
        else {
            qualityView.isHidden = true
            educationView.isHidden = true
            experienceView.isHidden = false
            educationView.reloadData()
        }
    }
    
}

extension Profile {
    
    @IBAction func contact(sender: UIButton) {
        let alert = UIAlertController(title: "Contacting " + person.name, message: "The following options are available.", preferredStyle: .actionSheet)
        if User.shared.person!.experience.count > 0 {
            alert.addAction(UIAlertAction(title: "Refer", style: .default, handler: { action in
                Server.createReferral(sender: User.shared.person!.id, recipient: self.person.id, status: Status.granted, completion: { referral in })
            }))
        }
        if person.experience.count > 0 {
            alert.addAction(UIAlertAction(title: "Request Referral", style: .default, handler: { action in
                Server.createReferral(sender: self.person.id, recipient: User.shared.person!.id, status: Status.requested, completion: { referral in })
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}

extension Profile {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView == educationView && indexPath.item > person.education.count) ||
            (tableView == experienceView && indexPath.item > person.experience.count) {
            return 30
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if thisIsMe() {
            if segmentedControl.selectedSegmentIndex == 1 {
                return min(3, person.education.count + 1)
            }
            return 1
        }
        else {
            if segmentedControl.selectedSegmentIndex == 1 {
                return person.education.count
            }
            return person.experience.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == educationView {
            if indexPath.item >= person.education.count {
                return tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddCell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "EducationCell", for: indexPath) as! EducationCell
            cell.load(education: person.education[indexPath.item])
            return cell
        }
        else if tableView == experienceView {
            if indexPath.item >= person.experience.count {
                return tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddCell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCell", for: indexPath) as! ExperienceCell
            cell.load(experience: person.experience[indexPath.item])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if thisIsMe() {
            if tableView == educationView {
                clickedEducationRow(cell: cell, indexPath: indexPath)
            }
            else if tableView == experienceView {
                clickedExperienceRow(cell: cell, indexPath: indexPath)
            }
        }
    }
    
    func clickedEducationRow(cell: UITableViewCell, indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "education") as! UINavigationController
        let child = controller.viewControllers[0] as! DraftEducation
        if let _ = cell as? EducationCell {
            child.load(education: self.person.education[indexPath.item], completion: { education in
                self.updatedEducation(education: education)
            })
            let alert = UIAlertController(title: "Do you want to edit or delete this entry?", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
                DispatchQueue.main.async { [weak self] in
                    self!.present(controller, animated: true, completion: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
                self.person.education.remove(at: indexPath.item)
                self.educationView.reloadData()
                self.update()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            DispatchQueue.main.async { [weak self] in
                self!.present(alert, animated: true)
            }
        }
        else {
            child.load(education: nil, completion: { education in
                self.addedEducation(education: education)
            })
            DispatchQueue.main.async { [weak self] in
                self!.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func clickedExperienceRow(cell: UITableViewCell, indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "experience") as! UINavigationController
        let child = controller.viewControllers[0] as! DraftExperience
        if let _ = cell as? ExperienceCell {
            child.load(experience: self.person.experience[indexPath.item], completion: { experience in
                self.updatedExperience(experience: experience)
            })
            let alert = UIAlertController(title: "Do you want to edit or delete this entry?", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
                DispatchQueue.main.async { [weak self] in
                    self!.present(controller, animated: true, completion: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
                self.person.experience.remove(at: indexPath.item)
                self.experienceView.reloadData()
                self.update()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            DispatchQueue.main.async { [weak self] in
                self!.present(alert, animated: true)
            }
        }
        else {
            child.load(experience: nil, completion: { experience in
                self.addedExperience(experience: experience)
            })
            DispatchQueue.main.async { [weak self] in
                self!.present(controller, animated: true, completion: nil)
            }
        }
    }
    
}

extension Profile: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / 2.0
        let yourHeight = CGFloat(150)
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QualityCell", for: indexPath) as! QualityCell
        cell.load(quality: person.qualities[indexPath.row])
        return cell
    }
    
}

extension Profile {
    
    func addedEducation(education: Education) {
        self.person.education.append(education)
        sortEducation()
        update()
        educationView.reloadData()
    }
    
    func updatedEducation(education: Education) {
        self.person.education = self.person.education.filter { $0.id != education.id }
        addedEducation(education: education)
    }
    
    func addedExperience(experience: Experience) {
        self.person.experience.append(experience)
        experienceView.reloadData()
        update()
    }
    
    func updatedExperience(experience: Experience) {
        self.person.experience = self.person.experience.filter { $0.id != experience.id }
        addedExperience(experience: experience)
    }
    
    func update() {
        User.shared.person = person
        Server.updateUser(person: person, completion: { person in
            self.person = person
            self.sortEducation()
            User.shared.person = person
        })
    }
    
    func sortEducation() {
        self.person.education = self.person.education.sorted(by: {
            Constants.degrees.firstIndex(of: $0.degreeType)! < Constants.degrees.firstIndex(of: $1.degreeType)!
        })
    }
    
}
