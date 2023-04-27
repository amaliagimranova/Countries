//
//  ContentView.swift
//  Trainig
//
//  Created by Amalia Gimranova on 21.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["UK", "USA", "Argentina", "Canada", "Brazil", "Bangladesh", "Germany", "Greece", "Russia", "Sweden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                VStack {
                    Text("Выбери флаг: ")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 130)
                            .clipShape(Capsule())
                            .overlay(Capsule() .stroke(Color.white, lineWidth: 3))
                            .shadow(color: .white, radius: 5)
                    }
                    .padding(15)
                }
                
                Text("Общий счет: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        } .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Общий счет: \(score)"), dismissButton: .default(Text("Продолжить")) {
                self.askQuestion()
            })
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильный ответ!"
            score += 1
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[number])"
            score -= 1
        }
            
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
