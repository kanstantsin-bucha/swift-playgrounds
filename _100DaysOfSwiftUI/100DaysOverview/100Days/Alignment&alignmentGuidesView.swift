//
//  Alignment&alignmentGuidesView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 09/05/2023.
//

import SwiftUI

struct Alignment_alignmentGuidesView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Hello, world")
                    .alignmentGuide(.leading) { d in
                        d[.trailing]
                    }
                Text("This is a long line of text")
            }
            .background(.red)
            .frame(width: 300, height: 150)
            .background(.blue)
            
            VStack(alignment: .leading) {
                Text("Hello, world")
                    .offset(x: -50, y: 0)
                Text("This is a long line of text")
                    .offset(x: 50, y: 0)
            }
            .background(.red)
            .frame(width: 300, height: 150)
            .background(.blue)
            
            VStack(alignment: .leading) {
                ForEach(0..<7) { position in
                 Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in
                            Double(position) * -10
                        }
                }
            }
            .background(.red)
            .frame(width: 300, height: 150)
            .background(.blue)
            
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }
            .background(.green)
        }
    }
}

struct Alignment_alignmentGuidesView_Previews: PreviewProvider {
    static var previews: some View {
        Alignment_alignmentGuidesView()
    }
}
