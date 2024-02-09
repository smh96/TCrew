//
//  GetRosterView.swift
//  TCrew
//
//  Created by Sander Haug on 03/06/2023.
//

import SwiftUI
import SwiftSoup

struct GetRosterView: View {
  
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var isFocused: Bool
    
    @State private var userName: String = ""
    @State private var passWord: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(alignment: .center, spacing: 50) {
                    Text("Username")
                    
                    TextField("Required", text: $userName)
                        .focused($isFocused)
                    
                }
                HStack(alignment: .center, spacing: 50) {
                    Text("Password ")
                    SecureField("Required", text: $passWord)
                        .focused($isFocused)
                    
                }
             
            }
            .navigationTitle("Import Roster")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct GetRosterView_Previews: PreviewProvider {
    static var previews: some View {
        GetRosterView()
    }
}
