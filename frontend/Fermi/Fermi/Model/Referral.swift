//
//  Referral.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/2/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

struct Referral: Codable {
    
    let id: Int
    let senderId: Int
    let sender: String
    let recipientId: Int
    let recipient: String
    let company: String
    var status: Status
    let timestamp: String
    
    func iAmSender() -> Bool {
        return senderId == /*User.shared.person!.id*/ 27
    }
    
}
