//
//  Home.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit
import Alamofire

class Home: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var data: [Person] = []

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(Home.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //set delegate and datasource to this class
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nibName = UINib(nibName: "InitialTableCell", bundle: nil)
        self.tableView.addSubview(refreshControl)

        self.tableView.register(nibName, forCellReuseIdentifier: "Cell1")
        
        refresh()

    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = data[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! InitialTableCell
        cell.commonInit(pName: currentUser.name, pId: currentUser.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func refresh() {
        data = []
        let uri = Constants.host + "example"
        Alamofire.request(uri, method: .get, parameters: nil, headers: nil).validate().responseJSON { response in
            guard response.result.isSuccess else {
                print("error")
                return
            }
            guard let response = response.result.value as? [[String: Any]] else {
                print("error")
                return
            }
            for entry in response {
                guard let person = Person(json: entry) else {
                    print("error")
                    return
                }
                self.data.append(person)
            }
            self.tableView.reloadData()
        }
        
    }

}
