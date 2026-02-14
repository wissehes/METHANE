//
//  MethaneType.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import Foundation

enum MethaneType: CaseIterable, Hashable {
    case majorIncident
    case exactLocation
    case typeOfIncident
    case hazards
    case accessToScene
    case numberAndSeverity
    case emergencyServices
}

extension MethaneType {
    var title: String {
        switch self {
        case .majorIncident:
            return "Major incident"
        case .exactLocation:
            return "Exact location"
        case .typeOfIncident:
            return "Type of incident"
        case .hazards:
            return "Hazards"
        case .accessToScene:
            return "Access to scene"
        case .numberAndSeverity:
            return "Number and Severity"
        case .emergencyServices:
            return "Emergency services"
        }
    }
}
