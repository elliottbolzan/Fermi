//
//  Home.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Home: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegate and datasource to this class
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nibName = UINib(nibName: "InitialTableCell", bundle: nil)
        
        self.tableView.register(nibName, forCellReuseIdentifier: "Cell1")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = dataArray![indexPath.item]
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
