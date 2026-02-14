//
//  StoredReport.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import Foundation

struct StoredReport: Hashable {
    var id: UUID
    var type: MethaneType

    // For reports where only text is enough
    var textData: String?
    
    
    // Major Incident Report date value
    var date: Date?
    
    var text: String {
        if let date {
            return date.formatted()
        } else if let textData {
            return textData
        }
        
        return ""
    }
}
