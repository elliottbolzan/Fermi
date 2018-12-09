//
//  DraftExperience.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/8/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit
import Eureka

class DraftExperience: FormViewController {
    
    var experience: Experience!
    var completion: ((Experience) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Edit"
        setupNavigationBar()
        setupForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
    }
    
    func load(experience: Experience?, completion: @escaping (Experience) -> Void) {
        self.experience = experience
        if self.experience == nil {
            self.experience = Experience(id: -1, company: "", position: "", startdate: "", enddate: "")
        }
        self.completion = completion
    }
    
    @objc func cancel() {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        if form.validate().count == 0 {
            print(form.values())
            self.experience!.company = form.values()["company"] as! String
            self.experience!.position = form.values()["position"] as! String
            self.experience!.startdate = (form.values()["startdate"] as! Date).toBackendFormat()
            if let enddate = form.values()["enddate"] as? Date {
                self.experience!.enddate = enddate.toBackendFormat()
            }
            else {
                self.experience!.enddate = nil
            }
            completion(self.experience)
            self.navigationController!.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupForm() {
        form
            +++ Section("Experience")
            <<< TextRow(){ row in
                row.add(rule: RuleRequired())
                row.tag = "company"
                row.title = "Company"
                row.placeholder = "Facebook"
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel!.textColor = .red
                }
            }
            <<< TextRow(){ row in
                row.add(rule: RuleRequired())
                row.tag = "position"
                row.title = "Position"
                row.placeholder = "Software Engineer"
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel!.textColor = .red
                }
            }
            <<< DateInlineRow(){ row in
                row.add(rule: RuleRequired())
                row.tag = "startdate"
                row.title = "Start Date"
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel!.textColor = .red
                }
            }
            <<< DateInlineRow(){ row in
                row.tag = "enddate"
                row.title = "End Date"
        }
        
    }
    
}
