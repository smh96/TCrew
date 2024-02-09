//
//  dataViewModel.swift
//  TCrew
//
//  Created by Sander Haug on 05/02/2024.
//

import Foundation
import SwiftSoup

class RosterDataViewModel: ObservableObject {
    
    @Published var roster: [RosterEntry] = [RosterEntry]()
    
    func parse (file: String) {
        
        do {
            let fileName = Bundle.main.path(forResource: file, ofType: "html")
            let html = try String(contentsOfFile: fileName!)
            
            let doc = try SwiftSoup.parse(html)
            
            var rosterEntries = roster
            var crewOnBoardData = [CrewMember]()
            
            var tableContent = [[String]]()
            
            for row in try! doc.select("#_tabRoster tr:gt(0)") {
                tableContent.removeAll()
                var rowContent = [String]()
                
                for col in try! row.select("td") {
                
                    let colContent = try! col.text()
        
                    rowContent.append(colContent)
                    
                }
                 //Extract crew information separately
                if let crewIndex = rowContent.firstIndex(where: {$0.contains("Crew onboard")}) {
                        rowContent.remove(at: crewIndex)
                    
                } else {
                    if rowContent.count > 13 {
                        let crewNames = rowContent.remove(at: 13)
                            .components(separatedBy: " ")
                            .filter { !$0.isEmpty }
                    }
                }
    
                tableContent.append(rowContent)
                
                if rowContent.count == 27 {
                    crewOnBoardData.removeAll()
                    let crewOn = rowContent.filter { !$0.isEmpty }
                   
                    for i in stride(from: 1, to: crewOn.count, by: 3) {
                        if i + 2 < crewOn.count {
                            let crewOnBoard = CrewMember(type: crewOn[i],
                                                         code: crewOn[i + 1],
                                                         name: crewOn[i + 2 ])
                            crewOnBoardData.append(crewOnBoard)
                        }
                    }
                   
                }
                
                if rowContent.count == 13 {
                    rosterEntries.removeAll()
                    if rowContent.count == 13 {
                        let rosterEntry = RosterEntry(
                            checkin: rowContent[1],
                            activity: rowContent[2],
                            start: rowContent[3],
                            dep: rowContent[4],
                            arr: rowContent[5],
                            end: rowContent[6],
                            checkout: rowContent[7],
                            acType: rowContent[8],
                            acVersion: rowContent[9],
                            dutyDesig: rowContent[10],
                            asgCat: rowContent[11],
                            le: rowContent[12], 
                            crewDetails: crewOnBoardData
                        )
                        roster.append(rosterEntry)
                    }
                    
                    
                }
            }
        } catch {
            print("DEBUG: Error parsing HTML: \(error)")
        }
        
        
    }
}
