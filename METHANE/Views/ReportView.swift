//
//  ReportView.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import SwiftUI

struct ReportView: View {
    var type: MethaneType
    
    @State private var selectedDate: Date = .now
    @State private var selectedEthane: EthaneType = .standby
    
    enum EthaneType: String, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        
        case standby = "Major incident STANDBY"
        case declared = "Major incident DECLARED"
    }
    
    var body: some View {
        List {
            Section("Date") {
                DatePicker("Date", selection: $selectedDate)
            }
            
            Section("ETHANE") {
                Picker("ETHANE", selection: $selectedEthane) {
                    ForEach(EthaneType.allCases) { ethaneType in
                        Text(ethaneType.rawValue)
                            .tag(ethaneType)
                    }
                }.pickerStyle(.inline)
                    .labelsHidden()
            }
            
            
        }.navigationTitle(type.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Now") {
                        selectedDate = .now
                    }.buttonStyle(.glassProminent)
                }
            }
    }
}

#Preview {
    NavigationStack {
        ReportView(type: .hazards)
    }
}
