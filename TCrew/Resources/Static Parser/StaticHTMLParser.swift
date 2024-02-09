//
//  StaticHTMLParser.swift
//  TCrew
//
//  Created by Sander Haug on 26/06/2023.
//

import Foundation
import SwiftUI
import SwiftSoup

struct StaticHTMLParser {
    
    static func parse (file: String) {
        
        do {
            let fileName = Bundle.main.path(forResource: file, ofType: "html")
            let html = try String(contentsOfFile: fileName!)
            
            let doc = try SwiftSoup.parse(html)
            
            var tableContent = [[String]]()
            
            for row in try! doc.select("#_tabRoster tr:gt(0)") {
                tableContent.removeAll()
                var rowContent = [String]()
                
                for col in try! row.select("td") {
                    
                    let colContent = try! col.text()
                    
                    rowContent.append(colContent)
                    
                }
                // Extract crew information separately
                if let crewIndex = rowContent.firstIndex(where: {$0.contains("Crew onboard")}) {
                    let crewInfo = rowContent.remove(at: crewIndex)
                } else {
                    if rowContent.count > 13 {
                        let crewNames = rowContent.remove(at: 13)
                            .components(separatedBy: " ")
                            .filter { !$0.isEmpty }
                    }
                }
                
                tableContent.append(rowContent)
                
                var rosterEntries: [RosterEntry] = []

                for rowContent in tableContent {
                    // Assuming each rowContent represents a row of your table

                    // Extracting data from rowContent
                    let checkin = rowContent[1]
                    let activity = rowContent[2]
                    let start = rowContent[3]
                    let dep = rowContent[4]
                    let arr = rowContent[5]
                    let end = rowContent[6]
                    let checkout = rowContent[7]
                    let acType = rowContent[8]
                    let acVersion = rowContent[9]
                    let dutyDesig = rowContent[10]
                    let asgCat = rowContent[11]
                    let le = rowContent[12]

                    // Extracting crew details
                    var crewDetails: [CrewMember] = []
                    for index in stride(from: 13, to: rowContent.count, by: 3) {
                        if index + 2 < rowContent.count {
                            let type = rowContent[index]
                            let code = rowContent[index + 1]
                            let name = rowContent[index + 2]

                            let crewMember = CrewMember(type: type, code: code, name: name)
                            crewDetails.append(crewMember)
                        }
                    }

                    // Creating RosterEntry instance
                    let rosterEntry = RosterEntry(
                        checkin: checkin,
                        activity: activity,
                        start: start,
                        dep: dep,
                        arr: arr,
                        end: end,
                        checkout: checkout,
                        acType: acType,
                        acVersion: acVersion,
                        dutyDesig: dutyDesig,
                        asgCat: asgCat,
                        le: le,
                        crewDetails: crewDetails
                    )

                    // Appending to rosterEntries array
                    rosterEntries.append(rosterEntry)
                }

                // Now you have an array of RosterEntry instances containing your parsed data
           
            }
        } catch {
            print("DEBUG: Error parsing HTML: \(error)")
        }
        
        
    }
    
}



