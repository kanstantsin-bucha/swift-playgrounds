//
//  LoadingImageFromServerView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 07/02/2023.
//

import SwiftUI

struct LoadingImageFromServerView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/log2.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("Loading error")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct LoadingImageFromServerView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingImageFromServerView()
    }
}
