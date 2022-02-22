//
//  EditView.swift
//  RememberMe
//
//  Created by Миша Перевозчиков on 08.02.2022.
//

import SwiftUI
import Foundation
import MapKit

struct EditView: View {
    
//    @State private var coordinate: CLLocationCoordinate2D
    @State private var mapRegion: MKCoordinateRegion
    
    var unit: Unit
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
//        ScrollView{
            VStack{
                Image(uiImage: unit.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray, radius: 10 )
                    .padding(20)
                
                Map(coordinateRegion: $mapRegion, annotationItems: viewModel.units ) { unit in
                    MapMarker(coordinate: unit.coordinate)
                }
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            

        .navigationTitle(unit.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    init(unit: Unit, viewModel: ViewModel) {
        self.unit = unit
        self.viewModel = viewModel
       
        _mapRegion = State(initialValue: MKCoordinateRegion(center: unit.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }
}


struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(unit: Unit.example, viewModel: ViewModel())
    }
}
