//
//  CoreDataView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/02/2023.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct CoreDataView: View {
    let students = [Student(name:"Miguel de Cervantes"),Student(name: "Lewis Carroll"),Student(name:"Mark Twains"),Student(name:"Robert Louis Stevenson"), Student(name:"Jane Austen"),]
    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct CoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataView()
    }
}
