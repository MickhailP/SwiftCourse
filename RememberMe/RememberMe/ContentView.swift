//
//  ContentView.swift
//  RememberMe
//
//  Created by Миша Перевозчиков on 06.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel = ViewModel()
    
    
    var body: some View {
        
        if viewModel.isUnlock {
            NavigationView {
                List {
                    ForEach(viewModel.units) { unit in
                        NavigationLink {
                            EditView(unit: unit, viewModel: viewModel)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(colorScheme == .dark ? Color("dark") : .white)
                                
                                HStack {
                                    Image(uiImage: unit.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 70)
                                        .clipShape(Circle())
                                        .padding()
                                        .shadow(color: .gray.opacity(0.4), radius: 3)
                                    VStack {
                                        Text(unit.name)
                                            .font(.title3)
                                    }
                                    Spacer()
                                }
                                
                            }
                            .shadow(color: .gray.opacity(0.4), radius: 5)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                    .onDelete { offsets in
                        Task { @MainActor in
                            viewModel.removeItems(at: offsets)
                        }
                    }
                }
                
                
                .listStyle(PlainListStyle())
                
                .navigationBarTitle("Remember me")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add"){
                            viewModel.showAddView = true
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    
                }
                .sheet(isPresented: $viewModel.showAddView) {
                    AddView(viewModel: viewModel)
                }
            }
            
        } else {
            //Authenticate and show alert if it's impossible
            VStack {
                Image(systemName: "faceid")
                    .font(.system(size: 50))
                Button("Unlock with FaceID") {
                    viewModel.authenticate()
                }
                .padding()
                .buttonStyle(.bordered)
                .font(.title)
                
                
                .alert("Warning", isPresented: $viewModel.showAuthenticationAlert){
                    Button("Try again", role: .cancel) {}
                } message: {
                    Text("Invalid authentication \(viewModel.authenticationError?.localizedDescription ?? "error")")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
