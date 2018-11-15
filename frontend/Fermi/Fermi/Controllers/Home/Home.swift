//
//  Home.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit
import Alamofire

class Home: UICollectionViewController {

    let reuseIdentifier = "Cell"
    let sectionInsets = UIEdgeInsets(top: 30.0, left: 50.0, bottom: 30.0, right: 50.0)
    let itemsPerRow: CGFloat = 1
    let cardHeight: CGFloat = 290
    let gap: CGFloat = 30
    
    var people = [Person]()
    let server = Server()
    
    var searchController = UISearchController(searchResultsController: nil)
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(Home.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        people.append(Person(id: "1995325", name: "Elliott Bolzan"))
//        people.append(Person(id: "253223", name: "Thara Veera"))
//        people.append(Person(id: "34352", name: "Jamie Palka"))
//        people.append(Person(id: "4", name: "Davis Booth"))
//        people.append(Person(id: "5", name: "Emily Mi"))
        self.navigationController?.navigationBar.prefersLargeTitles = true
        configureSearchController()
        refresh()
    }
    
}


extension Home: UISearchResultsUpdating {
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search & Filter"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
    
}

extension Home {
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }

    func refresh() {
        self.people = []
        let uri = Constants.host + "example"
        Alamofire.request(uri, method: .get, parameters: nil, headers: nil).validate().responseJSON { response in
            guard response.result.isSuccess else {
                print("A")
                return
            }
            guard let response = response.result.value as? [[String: Any]] else {
                print("B")
                return
            }
            for entry in response {
                guard let person = Person(json: entry) else {
                    print("C")
                    return
                }
                self.people.append(person)
            }
            self.collectionView.reloadData()
        }

    }

}

extension Home {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Card
        let person = people[indexPath.row]
        cell.name?.text = person.name
        person.profilePicture(completion: { image in
            cell.profilePicture?.imageView.image = image
        })
        return cell
    }
    
}

extension Home : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(cardHeight)
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return gap
    }
}

extension Home : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Show edit view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        let activityIndicator = UIActivityIndicatorView(style: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        // Should search.
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
}
