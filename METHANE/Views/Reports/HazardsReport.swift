//
//  HazardsReport.swift
//  METHANE
//
//  Created by Wisse Hes on 14/02/2026.
//

import SwiftUI

struct HazardsReport: View {
    var saveReport: (_ report: StoredReport) -> Void
    var initialReport: StoredReport? = nil

    @Environment(\.dismiss) var dismiss
    
    private let reportType: MethaneType = .hazards
    
    private let blockSize: CGFloat = 100
    private let spacing: CGFloat = 20
    
    @State private var selectedHazards: Set<String> = .init()

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                .init(.fixed(blockSize), spacing: spacing),
                .init(.fixed(blockSize), spacing: spacing),
                .init(.fixed(blockSize), spacing: spacing)
            ], spacing: 20) {
                ForEach(HazardItem.hazards, content: hazardItemView(for:))
            }
        }.navigationTitle(reportType.title)
            .onAppear {
                guard let initialSelection = initialReport?.hazards else { return }
                self.selectedHazards = Set(initialSelection)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Save", action: save)
                }
            }
    }
    
    // Block-shaped button to select/deselect the hazards
    private func hazardItemView(for hazard: HazardItem) -> some View {
        let isSelected = selectedHazards.contains(hazard.id)
        
        return Button {
            selectedHazards.toggle(hazard.id)
        } label: {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? .blue.opacity(0.5) : .gray.opacity(0.25))
                    .frame(width: blockSize, height: blockSize)
                
                // Icon + label text
                VStack(alignment: .center, spacing: 10) {
                    Image(systemName: hazard.systemImage)
                        .font(.title)
                    
                    Text(hazard.title)
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
                .frame(width: blockSize - 10, height: blockSize - 10)
            }
        }.buttonStyle(.plain)
    }
    
    func save() {
        let newReport = StoredReport(
            id: .init(),
            type: reportType,
            hazards: selectedHazards.sorted()
        )
        saveReport(newReport)
        dismiss()
    }
}

fileprivate struct HazardItem: Identifiable {
    let title: String
    let systemImage: String
    
    var id: String {
        self.title
    }
    
    var label: some View {
        Label(title, systemImage: systemImage)
    }
    
    static let hazards: [HazardItem] = [
        .init(title: "Mararuding attackers", systemImage: "person.3"),
        .init(title: "Explosives", systemImage: "flame"),
        .init(title: "Suspect Devices", systemImage: "flame"),
        .init(title: "Hostages taken", systemImage: "figure.run"),
        .init(title: "Fire", systemImage: "flame"),
        .init(title: "Smoke/fumes", systemImage: "smoke"),
        .init(title: "Munition", systemImage: "exclamationmark.triangle"),
        .init(title: "Biological", systemImage: "leaf"),
        .init(title: "Chemical", systemImage: "exclamationmark.triangle"),
        .init(title: "Confined space", systemImage: "square.split.bottomrightquarter"),
        .init(title: "Gas leak", systemImage: "pipe.and.drop"),
        .init(title: "Moving vehicles", systemImage: "car.side"),
        .init(title: "Public disorder", systemImage: "person.3"),
        .init(title: "Radiological", systemImage: "dot.radiowaves.left.and.right"),
        .init(title: "Structure collapse", systemImage: "building"),
        .init(title: "Flowing water", systemImage: "water.waves"),
        .init(title: "Fuel spill", systemImage: "fuelpump.exclamationmark"),
        .init(title: "Ice", systemImage: "snowflake"),
        .init(title: "Landslide", systemImage: "mountain.2"),
        .init(title: "Moving trains", systemImage: "train.side.front.car"),
        .init(title: "Mud/quick sand", systemImage: "exclamationmark.triangle"),
        .init(title: "Open water", systemImage: "fish"),
        .init(title: "Power lines", systemImage: "bolt"),
        .init(title: "Rising water/tide", systemImage: "water.waves.and.arrow.trianglehead.up"),
        .init(title: "Steep incline", systemImage: "mountain.2"),
        .init(title: "Unstable wreckage", systemImage: "exclamationmark.triangle")
    ]
}

#Preview {
    NavigationStack {
        HazardsReport(saveReport: { _ in })
    }
}
