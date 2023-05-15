//
//  ContentView.swift
//  CheckCoreData
//
//  Created by Aliaksandr Bucha on 13/02/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<WizardEntity>
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            Button("Add wizard") {
                let wizard = WizardEntity(context: context)
                wizard.name = "Harry Potter"
            }
            
            Button("Save wizard") {
                do{
                    try? context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
