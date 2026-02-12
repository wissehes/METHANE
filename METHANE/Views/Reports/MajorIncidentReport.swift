//
//  MajorIncidentReport.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import SwiftUI

fileprivate enum EthaneType: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case standby = "Major incident STANDBY"
    case declared = "Major incident DECLARED"
}

struct MajorIncidentReport: View {
    var saveReport: (_ report: StoredReport) -> Void
    private var reportType: MethaneType = .majorIncident
    
    @State private var selectedDate: Date = .now
    @State private var selectedEthane: EthaneType = .standby
    
    @Environment(\.dismiss) private var dismiss
    
    init(saveReport: @escaping (_ report: StoredReport) -> Void) {
        self.saveReport = saveReport
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
            
            Section {
                Button("Save") {
                    save()
                }
            }
            
        }.navigationTitle(reportType.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Now") {
                        selectedDate = .now
                    }.buttonStyle(.glassProminent)
                }
            }
    }
    
    func save() {
        let newReport = StoredReport(
            id: .init(),
            type: reportType,
            date: selectedDate
        )
        
        saveReport(newReport)
        dismiss()
    }
}

#Preview {
    MajorIncidentReport(saveReport: { _ in })
}
