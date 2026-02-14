//
//  IncidentType.swift
//  METHANE
//
//  Created by Wisse Hes on 14/02/2026.
//

import Foundation
import SwiftUI

enum IncidentType: CaseIterable, Hashable {
    case access
    case attack
    case crowd
    case nature
    case explosion
    case fire
    case industrial
    case transportation
    case water
    case other

    var text: LocalizedStringKey {
        switch self {
        case .access: return "Access"
        case .attack: return "Attack"
        case .crowd: return "Crowd"
        case .nature: return "Nature"
        case .explosion: return "Explosion"
        case .fire: return "Fire"
        case .industrial: return "Industrial"
        case .transportation: return "Transportation"
        case .water: return "Water"
        case .other: return "Other"
        }
    }

    var label: some View {
        switch self {
        case .access:
            return Label(self.text, systemImage: "door.left.hand.open")
        case .attack: return Label(self.text, systemImage: "figure.hunting")
        case .crowd: return Label(self.text, systemImage: "person.wave.2")
        case .nature: return Label(self.text, systemImage: "tornado")
        case .explosion:
            return Label(self.text, systemImage: "exclamationmark.circle")
        case .fire: return Label(self.text, systemImage: "flame")
        case .industrial:
            return Label(
                self.text,
                systemImage: "building.2"
            )
        case .transportation:
            return Label(self.text, systemImage: "car.2")
        case .water: return Label(self.text, systemImage: "water.waves")
        case .other:
            return Label(self.text, systemImage: "questionmark.circle.dashed")
        }
    }
    
    static var allSubTypes: [String] = Self.allCases.flatMap(\.subTypes)
    
    var subTypes: [String] {
        switch self {
        case .access:
            return [
                "Maritime transport",
                "Collapsed structure",
                "Flood/water access",
                "Seating collapse",
                "Steep slope/angle",
                "Confined space",
                "Landslide"
            ]
        case .attack:
            return [
                "Terrorism fire",
                "Multiple attackers: shooting",
                "Terrorism CBRN",
                "Terrorism general",
                "Single attacker: shooter",
                "Knife/blade attack",
                "Terrorism explosion"
            ]
        case .crowd:
            return [
                "Fire at crowd event",
                "Crowd crush",
                "Public disorder",
                "Stage collapse",
                "Seating collapse",
                "Terrorism at crowd event"
            ]
        case .nature:
            return [
                "Forest fire",
                "Landslide",
                "Tornado",
                "Vulcano",
                "Bush fire",
                "Lightning strike",
                "Tsunami",
                "Avalanche",
                "Flood",
                "Earthquake"
            ]
        case .explosion:
            return [
                "Explosion (generic)",
                "Military munitions",
                "Transportation explosions",
                "Domestic gas explosion",
                "Fuel explosion",
                "Terrorism explosion",
                "Industrial explosion"
            ]
        case .fire:
            return [
                "Transportation fire",
                "HAZCHEM/CBRN",
                "Fire - general",
                "Forest fire",
                "Fire at crowd event",
                "Building fire",
                "Bush fire",
                "Fuel fire",
                "Industrial fire",
                "Terrorism fire"
            ]
        case .industrial:
            return [
                "Industrial general",
                "Industrial fire",
                "Industrial explosion",
                "Industrial - HAZCHEM/CBRN",
                "Industrial - collapse",
                "Industrial - confined space"
            ]
        case .transportation:
            return [
                "Transport general",
                "Maritime",
                "Rail - overground",
                "Rail - underground",
                "Aviation",
                "Road traffic collision",
                "Cable car",
                "Transportation fire",
                "Livestock"
            ]
        case .water:
            return [
                "Flood",
                "People in water",
                "Water - access problem",
                "Maritime transport",
                "Drowning"
            ]
        case .other:
            return []
        }
    }
}
