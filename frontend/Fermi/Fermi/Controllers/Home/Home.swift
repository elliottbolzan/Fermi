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

    var people = [Person]()
    let server = Server()
    var recordsLeft = true
    
    let reuseIdentifier = "Cell"
    let insets = UIEdgeInsets(top: 40.0, left: 40.0, bottom: 40.0, right: 40.0)
    let itemsPerRow: CGFloat = 1
    let cardHeight: CGFloat = 240
    
    var filter: Filter!
    var filterView: FilterView!
    var searchController = UISearchController(searchResultsController: nil)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(Home.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Constants.tint
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.collectionView.refreshControl = refreshControl
        self.filterView = UIViewController.createWith(identifier: "filter", type: FilterView.self)
        self.filterView.searchBar = searchController.searchBar
        self.filter = Filter(name: "", company: "", university: "", qualities: [])
        configureSearchController()
        refresh()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    func refresh(clear: Bool = false) {
        if clear {
            self.people = []
            self.collectionView.reloadData()
        }
        Server.getUsersWith(filter: self.filter, completion: { users in
            self.people = users
            self.collectionView.reloadData()
        })
    }
    
    func getMore() {
        Server.getUsersWith(filter: self.filter, completion: { users in
            if users.count != 0 {
                self.people.append(contentsOf: users)
                self.collectionView.reloadData()
            }
            else {
                self.recordsLeft = false
            }
        })
    }
    
}

extension Home: UISearchBarDelegate {
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search & Filter"
        searchController.searchBar.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        addFilter(searchBar: searchBar)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        recordsLeft = true
        filter.clear()
        refresh(clear: filter != filterView.filter())
        filterView.reset()
        removeFilter(searchBar: searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateFilter()
        removeFilter(searchBar: searchBar)
    }
    
    func addFilter(searchBar: UISearchBar) {
        searchBar.placeholder = "John Smith"
        addChild(filterView!)
        filterView!.view.frame = self.view.frame
        self.view.addSubview(filterView!.view)
        self.view.bringSubviewToFront(filterView!.view)
        filterView!.didMove(toParent: self)
    }
    
    func removeFilter(searchBar: UISearchBar) {
        searchBar.placeholder = "Search & Filter"
        self.filterView!.view.removeFromSuperview()
        filterView!.didMove(toParent: nil)
    }
    
    func updateFilter() {
        recordsLeft = true
        let newFilter = filterView.filter()
        let filterUpdated = filter != newFilter
        filter = newFilter
        if !filter.active() {
            searchController.isActive = false
        }
        refresh(clear: filterUpdated)
    }
    
}

extension Home {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if recordsLeft && indexPath.row == self.people.count - 5 {
            print("5th from last")
            self.filter.offset += self.filter.limit
            getMore()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Card
        let person = people[indexPath.row]
        cell.setPerson(person: person)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIViewController.createWith(identifier: "profile", type: Profile.self)
        controller.view.backgroundColor = State.shared.colorFor(id: people[indexPath.row].id)
        controller.person = people[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilterHeader", for: indexPath) as! FilterHeader
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension Home : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - insets.left * 2, height: cardHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets.top
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if filter.active() {
            return CGSize(width: self.view.frame.size.width, height: 40)
        }
        return CGSize(width: 0, height: 0)
    }
    
}
