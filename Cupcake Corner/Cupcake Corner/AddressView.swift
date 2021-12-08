//
//  AdressView.swift
//  Cupcake Corner
//
//  Created by Миша Перевозчиков on 04.12.2021.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var demoOrder: DemoOrderItem
    
    //    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section{
                //                TextField("Name", text: $order.name)
                //                TextField("Street address", text: $order.streetAddress)
                //                TextField("City", text: $order.city)
                //                TextField("Zip", text: $order.zip)
                
                TextField("Name", text: $demoOrder.name)
                TextField("Street address", text: $demoOrder.streetAddress)
                TextField("City", text: $demoOrder.city)
                TextField("Zip", text: $demoOrder.zip)
            }
            
            Section{
                NavigationLink{
                    //                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(demoOrder.validateAddressDemo == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(demoOrder: DemoOrderItem())
        }
    }
}
