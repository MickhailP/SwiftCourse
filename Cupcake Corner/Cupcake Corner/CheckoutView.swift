//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Миша Перевозчиков on 04.12.2021.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var showInternetConnectionFail = false
    
    @ObservedObject var demoOrder: DemoOrderItem
    //    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total order cost is \(demoOrder.costDemo, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    // WE NEED TO USE TASK BECAUSE OUR BUTTON ISN'T UNDERSTAND ASYNC METH. BUTTON RUNS CODE IMMEDIATELY
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("Ok") { }
            
        } message: {
            Text(confirmationMessage)
        }
        .alert("Error", isPresented: $showInternetConnectionFail) {
            Button("Ok") { }
        } message: {
            Text("Check your internet connection")
        }
    }
    
    func placeOrder() async {
        
        //        Convert our current order object into some JSON data that can be sent.
        guard let encoded = try? JSONEncoder().encode(demoOrder.orderD) else {
            print("Failed to encode order")
            return
        }
        //        Tell Swift how to send that data over a network call.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //            we’ll decode the data that came back, use it to set our confirmation message property
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way "
            showingConfirmation = true
        } catch{
            showInternetConnectionFail = true
            print("Checkout failed")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(demoOrder: DemoOrderItem())
    }
}
