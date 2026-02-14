//
//  IncidentTypeReport.swift
//  METHANE
//
//  Created by Wisse Hes on 14/02/2026.
//

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
            return []
        case .crowd:
            return []
        case .nature:
            return []
        case .explosion:
            return []
        case .fire:
            return []
        case .industrial:
            return []
        case .transportation:
            return []
        case .water:
            return []
        case .other:
            return []
        }
    }
}

struct IncidentLabelStyle: LabelStyle {
    private let rectangleSize: CGFloat = 50

    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.gray.opacity(0.5))
                    .frame(width: rectangleSize, height: rectangleSize)

                configuration.icon
                    .foregroundStyle(.black)
                    .font(.title2)
            }

            configuration.title
        }
    }
}

struct IncidentTypeReport: View {
    private let reportType: MethaneType = .typeOfIncident
    
    @Environment(\.navigation) var navigation
    
    @State private var selectedType: IncidentType? = nil
    @State private var selectedSubType: String? = nil

    var body: some View {
        List {

            if let selectedType, let selectedSubType {
                Section("Selected") {
                    Text(selectedType.text)
                    Text("Sub-type: \(selectedSubType)")
                }
            }

            Section {
                ForEach(IncidentType.allCases, id: \.hashValue) { type in
                    NavigationLink(value: type) {
                        type.label
                            .labelStyle(IncidentLabelStyle())
                    }
                }
            }
        }.navigationTitle(reportType.title)
            .navigationDestination(for: IncidentType.self) { type in
                subMenuView(for: type)
            }
    }

    func subMenuView(for type: IncidentType) -> some View {
        List {
            ForEach(type.subTypes, id: \.self) { subType in
                Button(subType) {
                    self.selectedType = type
                    self.selectedSubType = subType
                    navigation.path.removeLast()
                }
            }
        }.navigationTitle(type.text)
    }
}

#Preview {
    @Previewable @State var navigation = Navigation()

    NavigationStack(path: $navigation.path) {
        IncidentTypeReport()
    }.environment(\.navigation, navigation)
}
