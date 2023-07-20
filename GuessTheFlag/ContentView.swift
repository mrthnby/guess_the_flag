//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mert Ali Hanbay on 20.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnswered : Bool = false
    @State private var score : Int?
    @State private var alertTitle : String = ""
    @State private var countries: Array<String> = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "USA"].shuffled()
    @State private var answer : Int = Int.random(in: 0...2)


    var body: some View {
        ZStack {

            RadialGradient(stops: [.init(color: Color(red: 0.7, green: 0, blue: 0.3), location: 0.3), .init(color: .white, location: 0.3)], center: .top, startRadius: 200, endRadius: 600).ignoresSafeArea()

            VStack(spacing: 10) {
                Text("Score: \(score ?? 0)")
                    .foregroundColor(Color(red: 1, green: 1, blue: 1,opacity : 0.8))
                    .font(.title3)
                
                Text("Tap the Flag of")
                    .foregroundColor(.white)
                Text(countries[answer].uppercased())
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                  
                VStack(spacing: 20){
                    ForEach(0..<3) { number in
                        Button {
                            onFlagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 20)
                        }
                    }

                } .padding(.top,45)
            }
                .padding()
        }.alert(alertTitle, isPresented: $isAnswered) {
            
            Button("OK",action: nextQuestion)
        } message: {
            Text("Your score is \(score ?? 0)")
        }
    }
    
    func onFlagTapped(_ number: Int){
        if number == answer{
            alertTitle = "Correct"
            if(score != nil){
                score! += 1
            }else{
                score = 1
            }
        }else{
            alertTitle = "Wrong"
        }
        
        isAnswered = true
    }
    
     func nextQuestion(){
        countries.shuffle()
        answer = Int.random(in: 0...2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
