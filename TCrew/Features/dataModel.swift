//
//  dataModel.swift
//  TCrew
//
//  Created by Sander Haug on 05/02/2024.
//

import Foundation

struct RosterEntry: Hashable {
    let id = UUID()
    var checkin: String
    var activity: String
    var start: String
    var dep: String
    var arr: String
    var end: String
    var checkout: String
    var acType: String
    var acVersion: String
    var dutyDesig: String
    var asgCat: String
    var le: String
    var crewDetails: [CrewMember]
    
    var startDate: Date? {
        return convertToDate(from: start)
    }
    
    var endDate: Date? {
        return convertToDate(from: end)
    }
}

struct CrewMember: Hashable {
    var type: String
    var code: String
    var name: String
}
