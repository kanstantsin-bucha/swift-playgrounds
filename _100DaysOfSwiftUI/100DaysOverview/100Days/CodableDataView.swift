//
//  CodableDataView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 07/02/2023.
//

import SwiftUI

struct Response: Codable {
    var result: [Result]
}

struct Result: Codable {
    var trackId: String
    var trackName: String
    var collectionName: String
}

struct CodableDataView: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
                    .font(.caption)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoderResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decoderResponse.result
            }
        } catch {
            print("Invalid URL")
        }
    }
}

struct CodableDataView_Previews: PreviewProvider {
    static var previews: some View {
        CodableDataView()
    }
}
