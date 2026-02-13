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
    
    var body: some View {
        switch type {
        case .majorIncident: MajorIncidentReport(saveReport: saveReport(report:))
        case .exactLocation: LocationReport(saveReport: saveReport(report:))
            
        default: EmptyView()
        }
    }
    
    func saveReport(report: StoredReport) {
        let existingReportIdx = reports.firstIndex(where: { $0.type == type })
        
        if let idx = existingReportIdx {
            reports.remove(at: idx)
        }
        
        reports.append(report)
    }
}

#Preview {
    NavigationStack {
        ReportView(type: .exactLocation, reports: .constant([]))
    }
}
