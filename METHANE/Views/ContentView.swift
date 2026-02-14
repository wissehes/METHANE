//
//  ContentView.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var storedReports: [StoredReport] = []
    @State private var navigation = Navigation()
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            List {
                ForEach(MethaneType.allCases, id: \.self) { type in
                    NavigationLink(value: ViewType.report(type: type)) {
                        listItem(type)
                            .swipeActions {
                                Button("Clear", systemImage: "trash") {
                                    storedReports = storedReports.filter({ $0.type != type })
                                }.tint(.red)
                            }
                    }
                }
            }.navigationTitle("METHANE")
                .navigationDestination(for: ViewType.self) { view in
                    switch view {
                        case .report(type: let type): ReportView(type: type, reports: $storedReports)
                    }
                }
        }.environment(\.navigation, navigation)
    }
    
    func listItem(_ type: MethaneType) -> some View {
        let rectangleSize: CGFloat = 50
        let associatedReport = storedReports.first(where: { $0.type == type })
        
        return HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(associatedReport != nil ? Color.green : Color .red)
                    .frame(width: rectangleSize, height: rectangleSize)
                Text(type.title.prefix(1).uppercased())
                    .font(Font.largeTitle.bold())
                    .foregroundStyle(Color.white)
            }
            
            Spacer()
                .frame(width: 10)
            
            VStack(alignment: .leading) {
                Text(type.title)
                    .font(.headline)
                
                if let report = associatedReport, !report.text.isEmpty {
                    Text(report.text)
                        .lineLimit(2)
                }
                
            }
            
        }
    }
}

#Preview {
    ContentView()
}
