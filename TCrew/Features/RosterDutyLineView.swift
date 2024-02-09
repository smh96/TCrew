//
//  RosterDutyLineView.swift
//  TCrew
//
//  Created by Sander Haug on 04/06/2023.
//

import SwiftUI

struct RosterDutyLineView: View {
    @EnvironmentObject var dataViewModel: RosterDataViewModel
    
   
    var body: some View {
        List {
            ForEach(dataViewModel.roster.sorted(by: {$0.startDate ?? Date() < $1.startDate ?? Date()}), id: \.self) { duty in
                
                Section {
                    HStack(alignment: .center) {
                        Symbols.standby
                            .font(.system(size: 30, weight: .regular))
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text(duty.activity).bold()
                            Text(duty.dep)
                        }
                        Spacer()
                        HStack {
                            Text(duty.startDate?.formatted(date: .omitted, time: .shortened) ?? duty.start)
                            Text("-")
                            Text(duty.endDate?.formatted(date: .omitted, time: .shortened) ?? duty.end)
                        }
                        .padding()
                    }
                }
            }
            
        }
        .listStyle(.grouped)
        .navigationTitle("Events")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            dataViewModel.parse(file: "Example")
            
        }
        
    }
}

struct RosterDutyLineView_Previews: PreviewProvider {
    static var previews: some View {
        RosterDutyLineView()
            .environmentObject(RosterDataViewModel())
    }
}

//Section {
//    HStack(alignment: .center) {
//        Symbols.clockFill
//            .font(.system(size: 30, weight: .regular))
//            .padding()
//
//        VStack(alignment: .leading) {
//            Text("REPORT").bold()
//            Text("AMS")
//        }
//        Spacer()
//        VStack {
//            Text("14:30L").bold()
//        }
//
//    }
//    HStack(alignment: .center) {
//        Symbols.airplane
//            .font(.system(size: 30, weight: .regular))
//            .padding()
//
//        VStack(alignment: .leading) {
//            Text("AMS - AYT").bold()
//            Text("HV173 turn 0h:50m")
//        }
//        Spacer()
//        VStack(alignment: .leading) {
//            Text("1530L - 20:15L").bold()
//        }
//
//    }
//    HStack(alignment: .center) {
//        Image(systemName: "airplane")
//            .font(.system(size: 30, weight: .regular))
//            .padding()
//
//        VStack(alignment: .leading) {
//            Text("AYT - AMS").bold()
//            Text("HV174")
//        }
//        Spacer()
//        VStack(alignment: .leading) {
//            Text("21:05L - 00:15L").bold()
//        }
//
//    }
//    HStack(alignment: .center) {
//        Image(systemName: "clock.fill")
//            .font(.system(size: 30, weight: .regular))
//            .padding()
//
//        VStack(alignment: .leading) {
//            Text("DEBRIEF").bold()
//            Text("AMS")
//        }
//        Spacer()
//        VStack(alignment: .leading) {
//            Text("00:45L").bold()
//        }
//
//    }
//} header: {
//    Text("Sun 18 Jun 2023").bold()
//        .foregroundColor(.blue)
//}
