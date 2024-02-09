//
//  TCrewApp.swift
//  TCrew
//
//  Created by Sander Haug on 03/06/2023.
//

import SwiftUI

@main
struct TCrewApp: App {
    @StateObject var dataViewModel: RosterDataViewModel = RosterDataViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataViewModel)
        }
    }
}
