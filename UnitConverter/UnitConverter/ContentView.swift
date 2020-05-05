//
//  ContentView.swift
//  UnitConverter
//
//  Created by shivakumargouda patil on 5/5/20.
//  Copyright © 2020 shivakumargouda. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let conversions = ["Area", "Energy", "Length", "Speed", "Time", "Temperature"]
    @State private var selectedUnitType = 0
    
    let sourceUnits = ["Nanosecond", "Microsecond", "Millisecond", "Second", "Minute", "Hour", "Day"]
    @State private var selectedSourceUnitType = 0
    @State private var sourceText = ""
    
    
    let destinationUnits = ["Nanosecond", "Microsecond", "Millisecond", "Second", "Minute", "Hour", "Day"]
    @State private var selectedDestinationUnitType = 0
    @State private var destinationText = ""
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Select unit type you want to convert?")) {
                    Picker("Conversion type", selection: $selectedUnitType) {
                        ForEach(0 ..< conversions.count) {
                            Text("\(self.conversions[$0])")
                        }
                    }
                }
                
                Section {
                    TextField("Enter", text: $sourceText).keyboardType(.decimalPad)
                    Picker("Select Unit", selection: $selectedSourceUnitType) {
                        ForEach(0 ..< sourceUnits.count) {
                            Text("\(self.sourceUnits[$0])")
                        }
                    }
                }
                
                Section {
                    TextField("Enter", text: $destinationText).keyboardType(.decimalPad)
                    Picker("Select Unit", selection: $selectedDestinationUnitType) {
                        ForEach(0 ..< destinationUnits.count) {
                            Text("\(self.destinationUnits[$0])")
                        }
                    }
                }
            }.navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
