//
//  StoredReport.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import Foundation

struct StoredReport {
    var id: UUID
    var type: MethaneType

    var date: Date?
    
    var text: String {
        if let date = date {
            return date.formatted()
        }
        
        return ""
    }
}
