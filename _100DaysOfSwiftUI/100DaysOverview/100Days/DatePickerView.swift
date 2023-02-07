//
//  DatePickerView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 23/01/2023.
//

import SwiftUI

struct DatePickerView: View {
    @State private var wakeUp = Date.now
    var body: some View {
        VStack {
            Text(Date.now.formatted(date: .complete, time: .omitted))
           
            
            DatePicker("Please select Date", selection: $wakeUp,  in: Date.now..., displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
    }
    //    Just example
    func trivialExample() {
        let components  = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
