//
//  DataToDocumentsDirectoryView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 21/02/2023.
//

import SwiftUI

struct DataToDocumentsDirectoryView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

struct DataToDocumentsDirectoryView_Previews: PreviewProvider {
    static var previews: some View {
        DataToDocumentsDirectoryView()
    }
}
