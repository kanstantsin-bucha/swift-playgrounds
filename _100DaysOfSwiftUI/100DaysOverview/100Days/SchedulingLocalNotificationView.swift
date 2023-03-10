//
//  SchedulingLocalNotificationView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/03/2023.
//

import SwiftUI
import UserNotifications

struct SchedulingLocalNotificationView: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .padding()
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the dogs"
                content.subtitle = "They look hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            }
        }
    }
}

struct SchedulingLocalNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulingLocalNotificationView()
    }
}
