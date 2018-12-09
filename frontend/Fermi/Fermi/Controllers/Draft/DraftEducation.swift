//
//  DraftEducation.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/8/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit
import Eureka

class DraftEducation: FormViewController {
    
    var education: Education!
    var completion: ((Education) -> Void)!
    
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
    
    func load(education: Education?, completion: @escaping (Education) -> Void) {
        self.education = education
        if self.education == nil {
            self.education = Education(id: -1, university: "", degreeType: "", startdate: "", enddate: nil)
        }
        self.completion = completion
    }
    
    @objc func cancel() {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        if form.validate().count == 0 {
            self.education!.university = form.values()["university"] as! String
            self.education!.degreeType = form.values()["degree"] as! String
            self.education!.startdate = (form.values()["startdate"] as! Date).toBackendFormat()
            if let enddate = form.values()["enddate"] as? Date {
                self.education!.enddate = enddate.toBackendFormat()
            }
            else {
                self.education!.enddate = nil
            }
            completion(self.education)
            self.navigationController!.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupForm() {
        form
            +++ Section("Education")
            <<< TextRow(){ row in
                row.add(rule: RuleRequired())
                row.tag = "university"
                row.title = "University"
                row.placeholder = "Duke University"
                row.value = education.university
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel!.textColor = .red
                }
            }
            <<< PushRow<String>(){ row in
                row.add(rule: RuleRequired())
                row.tag = "degree"
                row.title = "Degree"
                row.options = ["Bachelors", "Masters", "Doctorate"]
                if education.degreeType != "" {
                    row.value = education.degreeType
                }
            }.onPresent { from, to in
                from.title = "Edit"
                to.title = "Degree"
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel!.textColor = .red
                }
            }
            <<< DateInlineRow(){ row in
                row.add(rule: RuleRequired())
                row.tag = "startdate"
                row.title = "Start Date"
                if education.startdate != "" {
                    row.value = Date.fromBackendFormat(input: education.startdate)
                }
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel!.textColor = .red
                }
            }
            <<< DateInlineRow(){ row in
                row.tag = "enddate"
                row.title = "End Date"
                if education.enddate != nil {
                    row.value = Date.fromBackendFormat(input: education.enddate!)
                }
            }
        
    }
    
}
