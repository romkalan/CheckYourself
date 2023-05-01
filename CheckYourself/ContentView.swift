//
//  ContentView.swift
//  CheckYourself
//
//  Created by Roman Lantsov on 01.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var thumbOpacity = 0.0
    @State private var currentValue = 50.0
    @State private var targetValue = Int.random(in: 0...100)
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Подвиньте слайдер как можно ближе к: \(targetValue)")
            HStack {
                Text("0")
                UISliderRepresentation(
                    currentValue: $currentValue,
                    thumbOpacity: thumbOpacity
                )
                    .onChange(of: currentValue) { _ in
                        setThumbOpacity()
                    }
                Text("100")
            }
            Button("Проверь меня!", action: { showAlert.toggle() })
                .alert("Ваш результат:", isPresented: $showAlert, actions: {}) {
                    Text("\(computeScore())")
                }
            Button("Начать заново", action: {
                targetValue = Int.random(in: 0...100)
                setThumbOpacity()
            })
        }
        .padding()
        .onAppear {
            setThumbOpacity()
        }
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
    
    private func setThumbOpacity() {
        thumbOpacity = Double(computeScore())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
