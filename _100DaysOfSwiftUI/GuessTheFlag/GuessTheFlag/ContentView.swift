//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aliaksandr Bucha on 18/01/2023.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color(red: 0.1, green: 0.23, blue: 0.27) ,radius: 15)
    }
}

struct ContentView: View {
    @State private var isShowingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var selectedIndex = -1
    @State private var attemptNumber = 0
    @State private var animationAmount = 0.0
    @State private var correctAnswer = Int.random(in: 0...2)
    private let opacityValue = 0.25
    private let scaleValue = 0.75
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag ")
                    .font(.largeTitle.weight(.semibold))
                    .foregroundColor(.white)
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.semibold))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.title.weight(.bold))
                    }
                    
                    VStack(spacing: 30) {
                        ForEach(0..<3) { index in
                            Button {
                                flagTapped(index)
                                selectedIndex = index
                                withAnimation {
                                    animationAmount += 360
                                }
                            } label: {
                                FlagImage(image: countries[index])
                            }
                            .rotation3DEffect(
                                Angle(degrees: effectValue(itemIndex: index, selectedItemIndex: selectedIndex).degrees),
                                axis: (x: 0, y: 1, z: 0))
                            .scaleEffect(effectValue(itemIndex: index, selectedItemIndex: selectedIndex).scale)
                            .opacity(effectValue(itemIndex: index, selectedItemIndex: selectedIndex).opacity)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                
                Spacer()
                Spacer()
                
                HStack{
                Text("Score:")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.white)
                
                    Text(score, format: .number)
                        .font(.title.weight(.semibold))
                        .foregroundColor(.white)
                    Text("of")
                        .font(.title.weight(.semibold))
                        .foregroundColor(.white)
                    Text(attemptNumber, format: .number)
                        .font(.title.weight(.semibold))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
            .alert(scoreTitle, isPresented: $isShowingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your Score is \(score) of \(attemptNumber)")
            }
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "You right, it's is flag of \(countries[number])"
            score += 1
            attemptNumber += 1
        } else {
            scoreTitle = "You wrong, it's is flag of \(countries[number])"
            attemptNumber += 1
        }
        isShowingScore = true
    }
    
    private func effectValue(itemIndex: Int, selectedItemIndex: Int) -> (opacity: Double,
                                                                 scale: Double,
                                                                 degrees: Double) {
        let isSelected = selectedItemIndex >= 0
        let isItemSelected = itemIndex == selectedItemIndex
        let opacity = isItemSelected ? 1 : (isSelected ? opacityValue : 1)
        let scale = isItemSelected ? 1 : (isSelected ? scaleValue : 1)
        let degrees = isItemSelected ? animationAmount : 0
        return (opacity, scale, degrees)
    }
    
    private func askQuestion() {
        if attemptNumber == 8 {
            score = 0
            attemptNumber = 0
        }
        selectedIndex = -1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
