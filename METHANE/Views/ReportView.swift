//
//  ReportView.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import SwiftUI

struct ReportView: View {
    var type: MethaneType
    
    @Binding var reports: [StoredReport]
    @Environment(\.dismiss) var dismiss
    
    var associatedReport: StoredReport? {
        reports.first(where: { $0.type == type })
    }
    
    var body: some View {
        switch type {
        case .majorIncident: MajorIncidentReport(saveReport: saveReport(report:))
        case .exactLocation: LocationReport(saveReport: saveReport(report:), initialReport: associatedReport)
        case .typeOfIncident: IncidentTypeReport(saveReport: saveReport(report:))
            
        default: defaultView
        }
    }
    
    func saveReport(report: StoredReport) {
        let existingReportIdx = reports.firstIndex(where: { $0.type == type })
        
        if let idx = existingReportIdx {
            reports.remove(at: idx)
        }
        
        reports.append(report)
    }
    
    var defaultView: some View {
        ContentUnavailableView {
            Label("Not implemented yet", systemImage: "figure.wave")
        } actions: {
            Button("Go back") {
                dismiss()
            }.buttonStyle(.borderedProminent)
        }

    }
}

#Preview {
    NavigationStack {
        ReportView(type: .hazards, reports: .constant([]))
    }
}
