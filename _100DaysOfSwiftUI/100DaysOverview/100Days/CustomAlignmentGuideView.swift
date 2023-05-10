//
//  CustomAlignmentGuideView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/05/2023.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuideView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@mail")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                Image(systemName: "mail")
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("Full name")
                Text("Full name")
                Text("Full name")
            }
            VStack {
                Text("Full name")
                Text("Full name")
                Text("Full name")
                Text("Full name")
                Text("Paul Hadson")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

struct CustomAlignmentGuideView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuideView()
    }
}
