//
//  ContentView.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(MethaneType.allCases, id: \.self) { type in
                    NavigationLink(value: ViewType.report(type: type)) {
                        listItem(type.title.prefix(1).uppercased(), text: type.title)
                    }
                }
            }.navigationTitle("METHANE")
                .navigationDestination(for: ViewType.self) { view in
                    switch view {
                        case .report(type: let type): ReportView(type: type)
                    }
                }
        }
    }
    
    func listItem(_ letter: String, text: String) -> some View {
        let rectangleSize: CGFloat = 50
        
        return HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.red)
                    .frame(width: rectangleSize, height: rectangleSize)
                Text(letter)
                    .font(Font.largeTitle.bold())
                    .foregroundStyle(Color.white)
            }
            
            Spacer()
                .frame(width: 10)
            
            Text(text)
                .font(.headline)
            
        }
    }
}

#Preview {
    ContentView()
}
