//
//  HitTestingView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 13/04/2023.
//

import SwiftUI

struct HitTestingView: View {
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle")
                    }
                    .allowsHitTesting(false)
                Circle()
                    .fill(.red)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Circle")
                    }
                
            }
            VStack{
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
//            .contentShape(Rectangle())
            .onTapGesture {
                print("Hello word")
            }
        }
    }
}

struct HitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        HitTestingView()
    }
}
