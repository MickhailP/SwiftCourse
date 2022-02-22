//
//  AddView.swift
//  RememberMe
//
//  Created by Миша Перевозчиков on 07.02.2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    let locationFetcher = LocationFetcher()
    @State private var location =  CLLocationCoordinate2D(latitude: 50, longitude: 0)
    @State private var saveCurrentLocation = false
    
    @State private var name = ""
    
    @State private var showImagePicker = false
    
    var checkName: Bool {
        if name.isEmpty || image == nil {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Image name", text: $name)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                Toggle("Add location on map? ", isOn: $saveCurrentLocation)
                    .padding()
                    .onChange(of: saveCurrentLocation) { value in
                        if saveCurrentLocation {
                            self.locationFetcher.start()
                        }
                    }
                
                Button("Select image") {
                    showImagePicker = true
                }
                .padding()
                .foregroundColor(.black)
                .font(.headline)
                .background(Color.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                image?
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray, radius: 10 )
                    .padding(20)
                Spacer()
            }
            .navigationBarTitle("Add new unit")
            .toolbar {
                Button("Save") {
                    guard let inputImage = inputImage else { return }
                    
                    if let location = self.locationFetcher.lastKnownLocation {
                        self.location = location
                        print("Your location is \(location)")
                    } else {
                        print("Your location is unknown")
                    }
                    
                    
                    let newUnit = Unit(id: UUID(), name: name, picture: inputImage, latitude: location.latitude, longitude: location.longitude)
                    print(newUnit)
                    viewModel.units.append(newUnit)
                    viewModel.units.sort()
                    viewModel.saveUnit()
                    dismiss()
                }
                .disabled(checkName)
                
            }
            
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage)
        
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)

    }
}

struct AddView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddView(viewModel: ViewModel())
    }
}
