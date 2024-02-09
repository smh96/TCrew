//
//  HomeView.swift
//  TCrew
//
//  Created by Sander Haug on 03/06/2023.
//

import SwiftUI
import SwiftSoup

struct HomeView: View {
    
    @EnvironmentObject var dataViewModel: RosterDataViewModel
    
    var body: some View {
        NavigationView {
            RosterDutyLineView()
        }
        .onAppear {
            dataViewModel.parse(file: "Example")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RosterDataViewModel())
    }
}
