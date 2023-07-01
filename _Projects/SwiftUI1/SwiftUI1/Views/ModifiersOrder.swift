//
//  ModifiersOrder.swift
//  SwiftUI1
//
//  Created by Kanstantsin Bucha on 07/04/2023.
//

import SwiftUI

final class ADS: ObservableObject {
    
}

struct ModifiersOrder: View {
    @StateObject var ads: ADS
    
    init(ads: ADS) {
        self._ads = StateObject(wrappedValue: ads)
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(.red)
            .padding(16)
            .background(.blue)
    }
}

struct ModifiersOrder_Previews: PreviewProvider {
    static var previews: some View {
        ModifiersOrder(ads: .init())
    }
}
