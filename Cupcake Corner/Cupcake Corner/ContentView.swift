//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Миша Перевозчиков on 03.12.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var demoOrder = DemoOrderItem()
    
    @StateObject var order = Order()
    
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cupcake type", selection: $demoOrder.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Numbers of cakes \(demoOrder.quantity)", value: $demoOrder.quantity, in: 3...20)
                    
                    Section{
                        Toggle("Any special request?", isOn: $demoOrder.specialRequest.animation())
                        
                        if demoOrder.specialRequest {
                            Toggle("Add extra frosting", isOn: $demoOrder.extraFrosting)
                            Toggle("Add extra sprinkles", isOn: $demoOrder.addSprinkles)
                            
                        }
                    }
                    
                    Section{
                        NavigationLink{
                            AddressView(demoOrder: demoOrder)
                        } label: {
                            Text("Delivery details")
                        }
                    }
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
