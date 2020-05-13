//
//  ContentView.swift
//  UnitConverter
//
//  Created by shivakumargouda patil on 5/5/20.
//  Copyright © 2020 shivakumargouda. All rights reserved.
//

import SwiftUI


enum TimeUnit: String, CaseIterable{
    case Nanosecond
    case Microsecond
    case Millisecond
    case Second
    case Minute
    case Hour
    case Day
}

enum textField : String {
    case source, destination, none
}
    
class ConverterViewMdel: ObservableObject {
    
    @Published var editing = textField.none
    
    @Published var sourceText = "" {
        didSet {
            calculateDestination()
        }
    }

    @Published var destinationText = "" {
        didSet {
            calculateSource()
        }
    }
    
    @Published var sourceUnit = TimeUnit.Nanosecond {
        didSet {
            calculateDestination()
        }
    }
    
    @Published var destinationUnit = TimeUnit.Nanosecond {
        didSet {
             calculateDestination()
        }
    }
    
    func calculateDestination() {
        
        guard self.editing == textField.source else {
            return
        }
        
        self.destinationText = self.sourceText.uppercased()
        
        guard  let sourceValue = Double(sourceText) else {
            return
        }

        switch destinationUnit {
        case .Nanosecond:
            destinationText = String(sourceValue / 10.0)
        case .Microsecond:
            destinationText = String(sourceValue / 200.0)
        case.Millisecond:
            destinationText = String(sourceValue / 300.0)
        case .Second:
            destinationText = String(sourceValue / 60.0)
        case .Minute:
            destinationText = String(sourceValue / 400.0)
        case .Hour:
            destinationText = String(sourceValue / 500.0)
        case .Day:
            destinationText = String(sourceValue / 800.0)
        }
    }
    
    func calculateSource() {
        
        guard self.editing == textField.destination else {
            return
        }
        
        self.sourceText  = self.destinationText.lowercased()
    }
    
}

struct ContentView: View {
    
    @ObservedObject var cvm = ConverterViewMdel()
    
    var body: some View {
        
        NavigationView {
            
            Form {
            
                Section {
                    TextField("Enter", text: $cvm.sourceText, onEditingChanged: {_ in
                        self.cvm.editing = textField.source
                    }, onCommit: {
                        self.cvm.editing = textField.none
                    }).keyboardType(.decimalPad)
                    
                    Picker("Select Unit", selection: $cvm.sourceUnit) {
                        ForEach(TimeUnit.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section {
                    TextField("Enter", text: $cvm.destinationText, onEditingChanged: {_ in
                         self.cvm.editing = textField.destination
                    }, onCommit: {
                        self.cvm.editing = textField.none
                    }).keyboardType(.decimalPad)
                    
                    Picker("Select Unit", selection: $cvm.destinationUnit) {
                        ForEach(TimeUnit.allCases, id: \.self) {
                            Text($0.rawValue)
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
