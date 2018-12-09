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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    func setupForm() {
        form
            +++ Section("Is / was at")
            <<< TextRow(){ row in
                row.tag = "company"
                row.title = "Company"
                row.placeholder = "Facebook"
            }
            <<< TextRow(){ row in
                row.tag = "university"
                row.title = "University"
                row.placeholder = "Duke University"
            }
            +++ Section("Has")
            <<< ButtonRow(){ row in
                row.title = "Add Quality"
                }.onCellSelection({ cell, row in
                    self.form.insert(self.addMetric(), at: self.form.endIndex - 2)
                })
            +++ Section()
            <<< ButtonRow(){ row in
                row.title = "Clear"
                }.cellUpdate { cell, row in
                    cell.textLabel!.textColor = UIColor.red
                }.onCellSelection({ cell, row in
                    self.searchBar.text = ""
                    let company = self.form.rowBy(tag: "company") as! TextRow
                    company.value = ""
                    company.updateCell()
                    let university = self.form.rowBy(tag: "university") as! TextRow
                    university.value = ""
                    university.updateCell()
                    while self.form.endIndex > 3 {
                        self.form.remove(at: 1)
                    }
                })
            <<< ButtonRow(){ row in
                row.title = "Filter"
                }.cellUpdate { cell, row in
                    cell.textLabel!.textColor = UIColor.white
                    cell.backgroundColor = Constants.tint
                }.onCellSelection({ cell, row in
                    self.searchBar.endEditing(true)
                    self.searchBar.delegate!.searchBarSearchButtonClicked!(self.searchBar)
                })
    }
    
    func addMetric() -> Section {
        let id = self.form.endIndex - 2
        return
            Section(header: "Is in the", footer: self.descriptions["Generosity"]!)
                <<< StepperRow(){ row in
                    row.tag = "\(id):percentile"
                    row.title = "Percentile"
                    row.cell.stepper.minimumValue = 10
                    row.cell.stepper.maximumValue = 90
                    row.cell.stepper.stepValue = 10
                    row.value = 50
                    }.cellUpdate({ (cell, row) in
                        if row.value != nil {
                            cell.valueLabel?.text = "\(Int(row.value!))%"
                        }
                    }).onChange({ (row) in
                        if row.value != nil {
                            row.cell.valueLabel?.text = "\(Int(row.value!))%"
                        }
                    })
                <<< PushRow<String>(){ row in
                    row.tag = "\(id):quality"
                    row.title = "When It Comes To"
                    row.options = ["Generosity", "Impact", "Popularity", "Success"]
                    row.value = "Generosity"
                    }.onPresent { from, to in
                        to.title = "Quality"
                        self.navigationController?.navigationBar.prefersLargeTitles = false
                    }.onChange({ row in
                        if row.value == nil {
                            row.value = "Generosity"
                            row.reload()
                        }
                        else {
                            row.section!.footer = HeaderFooterView(title: self.descriptions[row.value!])
                            self.tableView.reloadData()
                        }
                    })
                <<< ButtonRow() {
                    $0.title = "Delete"
                    }.onCellSelection({ cell, row in
                        self.form.remove(at: row.section!.index!)
                    })
    }

}
