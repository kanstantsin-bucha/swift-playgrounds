//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kanstantsin Bucha on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var selectedIndex: Int?
    
    var body: some View {
        let _ = Self._printChanges()
        ZStack {
            LinearGradient(
                colors: [.red, .green, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack(alignment: .center) {
                Text("Type a flag of")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.thickMaterial)
                    .shadow(color: .blue, radius: 4)
                Text("\(countries[correctAnswer])")
                    .font(.largeTitle)
                    .foregroundStyle(.thickMaterial)
                    .shadow(color: .blue, radius: 4)
                ForEach(0..<3) { index in
                    button(
                        viewSettings(
                            atIndex: index,
                            selectedIndex: selectedIndex,
                            correctIndex: correctAnswer
                        ),
                        imageName: countries[index]
                    ) {
                        selectFlag(atIndex: index)
                    }
                }
            }
        }
    }
    
    private func button(
        _ settings: (rotation: Double, opacity: Double, scale: Double),
        imageName: String,
        selection: @escaping () -> Void
    ) -> some View {
        let (rotation, opacity, scale) = settings
        return Button {
            selection()
        } label: {
            Image(imageName)
                .resizable()
                .frame(width: 200 * scale, height: 100 * scale)
                .border(.white, width: 2)
                .padding(20)
                .background(Color(red: 0.4, green: 0.6, blue: 0.1, opacity: 0.2))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .rotation3DEffect(Angle(degrees: rotation), axis: (x: 0, y: 1, z: 0))
                .opacity(opacity)
        }
    }
    
    private func viewSettings(
        atIndex index: Int,
        selectedIndex: Int?,
        correctIndex: Int
    ) -> (rotation: Double, opacity: Double, scale: Double) {
        guard let selectedIndex else {
            return (0, 1, 1)
        }
        if index == correctIndex && correctIndex == selectedIndex {
            return (0, 1, 1.5)
        } else if index == correctIndex {
            return (0, 1, 1)
        }
        return (90, 0.5, 1)
    }
    
    private func selectFlag(atIndex index: Int) {
        withAnimation {
            selectedIndex = index
        }
        Task {
            try? await Task.sleep(for: .seconds(1))
            await MainActor.run() {
                print("reload")
                withAnimation {
                    selectedIndex = nil
                }
                Task {
                    try? await Task.sleep(for: .seconds(0.3))
                    await MainActor.run() {
                        withAnimation {
                            countries = countries.shuffled()
                            correctAnswer = Int.random(in: 0...2)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
