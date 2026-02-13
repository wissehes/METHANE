//
//  LocationReport.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationReport: View {
    var saveReport: (_ report: StoredReport) -> Void
    private let reportType: MethaneType = .exactLocation
    
    @State private var locationManager = LocationManager()
    @State private var textValue: String = ""
    
    @State private var sheetShowing = true
    
    // View of The Netherlands
    @State private var camera: MapCameraPosition = .camera(.init(
        centerCoordinate: CLLocationCoordinate2D(latitude: 52.117080, longitude: 5.074043),
        distance: 500_000
    ))
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Map(position: $camera) {
            UserAnnotation()
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button("Back", systemImage: "chevron.backward") {
                    sheetShowing = false
                    dismiss()
                }
            }
        }
            .navigationBarBackButtonHidden()
            .safeAreaPadding([.bottom], 250)
            .navigationTitle(reportType.title)
            .navigationBarTitleDisplayMode(.inline)
            .mapControls {
                MapUserLocationButton()
            }
            .onChange(of: locationManager.location, { oldValue, newValue in
                guard let location = newValue, oldValue == nil else { return }
                
                camera = .camera(.init(
                    centerCoordinate: location.coordinate,
                    distance: 5_000
                ))
            })
            .task {
                locationManager.requestUserAuthorization()
                locationManager.startLocationUpdates()
            }
            .sheet(isPresented: $sheetShowing) {
                sheetContent
                    .presentationDetents([.fraction(0.40)])
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
            }
    }
    
    var sheetContent: some View {
        VStack(alignment: .leading) {
            Text("Location information")
                .font(Font.largeTitle.bold())
            
            TextEditor(text: $textValue)
                .contentMargins(10)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack(alignment: .center, spacing: 25) {
                Button("Address", action: insertAddress)
                Button("Coordinates", action: insertCoordinates)
                
                Spacer()
                
                Button("Save") {
                    // TODO
                }.buttonStyle(.borderedProminent)
            }.padding([.top, .bottom], 10)
            
            Spacer()
        }.padding(25)
    }
    
    func insertAddress() {
        guard let location = locationManager.location else { return }
        
        Task {
            guard let request = MKReverseGeocodingRequest(location: location) else { return }
            
            let mapitems = try? await request.mapItems
            guard let address = mapitems?.first?.address?.shortAddress else { return }
            
            textValue += address + "\n"
        }
    }
    
    func insertCoordinates() {
        guard let location = locationManager.location else { return }
        let coordinatesString = "lat: \(location.coordinate.latitude), lon: \(location.coordinate.longitude)"
        
        textValue += coordinatesString + "\n"
    }
}

#Preview {
    NavigationStack {
        LocationReport(saveReport: { _ in })
    }
}
