//
//  ContentView.swift
//  TCrew
//
//  Created by Sander Haug on 03/06/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataViewModel: RosterDataViewModel
    @State var isPresenting = false
    @State private var selectedItem = 1
    @State private var oldSelectedItem = 1


    var body: some View {
        TabView(selection: $selectedItem){
            HomeView()
                .tabItem {
                    Symbols.house
                    Text("Home")
                }.tag(1)

            GetRosterView()
                .tabItem {
                    Symbols.getRoster
                    Text("Roster")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Symbols.settings
                    Text("Settings")
                }.tag(3)
        }
        
        .onChange(of: selectedItem) { newValue in
            if newValue == 2 {
                isPresenting = true
                selectedItem = oldSelectedItem
            } else {
                oldSelectedItem = newValue
            }
        }
        .sheet(isPresented: $isPresenting) {
            // Sheet view
            GetRosterView()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
