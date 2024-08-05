//
//  ContentView.swift
//  SwiftUICalculator
//
//  Created by Kerim Sakız on 30.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var number1 = ""
    @State var number2 = ""
    @State var result: Double? = nil
    
    var body: some View {
        ZStack {
            Color(red: 12/255, green: 24/255, blue: 68/255)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Hesap Makinesi")
                    .font(.largeTitle)
                    .foregroundColor(Color(UIColor(red: 1.0, green: 0.41, blue: 0.41, alpha: 1.0)))
                    .padding(.bottom, 15)
                
                TextField("Birinci sayı", text: $number1)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor(red: 1.0, green: 0.96, blue: 0.88, alpha: 1.0)))
                    .cornerRadius(10)
                    .foregroundColor(Color(UIColor(red: 200/255, green: 0/255, blue: 54/255, alpha: 1.0)))
                    .padding()
                
                TextField("İkinci sayı", text: $number2)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor(red: 1.0, green: 0.96, blue: 0.88, alpha: 1.0)))
                    .cornerRadius(10)
                    .foregroundColor(Color(UIColor(red: 200/255, green: 0/255, blue: 54/255, alpha: 1.0)))
                    .padding()
                
                HStack {
                    VStack(spacing: 20) {
                        ForEach(0..<2) { index in
                            OperationButton(symbol: index == 0 ? "+" : "×", color: index == 0 ? .blue : .green) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    if let num1 = Double(number1), let num2 = Double(number2) {
                                        if index == 0 {
                                            self.result = num1 + num2
                                        } else {
                                            self.result = num1 * num2
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 20) {
                        ForEach(0..<2) { index in
                            OperationButton(symbol: index == 0 ? "−" : "÷", color: index == 0 ? .red : .orange) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    if let num1 = Double(number1), let num2 = Double(number2) {
                                        if index == 0 {
                                            self.result = num1 - num2
                                        } else {
                                            self.result = num1 / num2
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                if let result = result {
                    Text("Sonuç: \(result)")
                        .font(.title)
                        .foregroundColor(Color(UIColor(red: 1.0, green: 0.41, blue: 0.41, alpha: 1.0)))
                        .padding()
                        .transition(.scale)
                }
            }
            .padding()
        }
    }
    
    struct OperationButton: View {
        let symbol: String
        let color: Color
        let action: () -> Void
        
        @State private var isPressed = false
        
        var body: some View {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    action()
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed.toggle()
                    }
                }
            }) {
                Text(symbol)
                    .font(.largeTitle)
                    .frame(width: 80, height: 80)
                    .background(color)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .scaleEffect(isPressed ? 0.9 : 1.0)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
