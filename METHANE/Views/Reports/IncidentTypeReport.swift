//
//  IncidentTypeReport.swift
//  METHANE
//
//  Created by Wisse Hes on 14/02/2026.
//

import SwiftUI

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
    var saveReport: (_ report: StoredReport) -> Void
    
    private let reportType: MethaneType = .typeOfIncident
    
    @Environment(\.navigation) var navigation
    
    @State private var selectedType: IncidentType? = nil
    @State private var selectedSubType: String? = nil
    
    @State private var otherInputField = ""
    
    @State private var searchInput: String = ""
    @State private var isSearchActive: Bool = false
    
    var searchResults: [String] {
        if searchInput.isEmpty {
            return IncidentType.allSubTypes
        }
        
        return IncidentType.allSubTypes.filter { $0.localizedCaseInsensitiveContains(searchInput) }.unique()
    }
    
    var body: some View {
        List {

            if let selectedType, let selectedSubType, !isSearchActive {
                Section("Selected") {
                    Text(selectedType.text)
                    Text("Sub-type: \(selectedSubType)")
                }
            }

            if !isSearchActive {
                Section {
                    ForEach(IncidentType.allCases, id: \.hashValue) { type in
                        NavigationLink(value: type) {
                            type.label
                                .labelStyle(IncidentLabelStyle())
                        }
                    }
                }
            }
            
            if isSearchActive {
                ForEach(searchResults, id: \.self) { subType in
                    Button(subType) {
                        saveSubType(type: .other, subType: subType)
                        isSearchActive = false
                    }
                }
            }
            
        }.navigationTitle(reportType.title)
            .navigationDestination(for: IncidentType.self) { type in
                if type == .other {
                    otherInput
                } else {
                    subMenuView(for: type)
                }
            }
            .searchable(text: $searchInput, isPresented: $isSearchActive)
    }

    func subMenuView(for type: IncidentType) -> some View {
        List {
            ForEach(type.subTypes, id: \.self) { subType in
                Button(subType) {
                    saveSubType(type: type, subType: subType)
                }
            }
        }.navigationTitle(type.text)
    }
    
    var otherInput: some View {
        Form {
            TextField("Other type", text: $otherInputField)
            Button("Save") {
                saveSubType(type: .other, subType: otherInputField)
            }.disabled(otherInputField.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }.navigationTitle(IncidentType.other.text)
    }
    
    func saveSubType(type: IncidentType, subType: String) {
        self.selectedType = type
        self.selectedSubType = subType
        
        let newReport = StoredReport(
            id: .init(),
            type: reportType,
            textData: subType
        )
        saveReport(newReport)
        
        navigation.path = NavigationPath()
    }
}

#Preview {
    @Previewable @State var navigation = Navigation()

    NavigationStack(path: $navigation.path) {
        IncidentTypeReport(saveReport: { _ in })
    }.environment(\.navigation, navigation)
}
