//
//  ContentView.swift
//  Calculator
//
//  Created by Raja Sekar.J on 30/09/24.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "Clear"
    case decimal = "."
   
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear:
            return Color(.brown)
        default :
            return Color(UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1))
        }
    }
    
}

enum Operation {
    case add, subtract, multiply, divide, none
    
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currenOperation: Operation = .none
    @State var hasError = false
    
    let buttons: [[CalcButton]] = [
        [.clear, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
             VStack {
                 Spacer()
                 HStack{
                     Spacer()
                     Text(value)
                         .bold()
                         .font(.system(size: 82))
                         .foregroundStyle(.white)
                 }
                 .padding()
                 
                 ForEach(buttons, id: \.self) { row in
                     HStack(spacing: 12) {
                         ForEach(row, id: \.self) { item in
                             Button(action: {
                                 self.didTap(button: item)
                             }, label: {
                                 Text(item.rawValue)
                                     .font(.system(size: 32))
                                     .frame(
                                        width: self.buttonwidth(item: item),
                                        height: self.buttonheight())
                                     .background(item.buttonColor)
                                     .foregroundColor(.white)
                                     .cornerRadius(self.buttonwidth(item: item)/2)
                             })
                         }
                     }
                     .padding(.bottom, 3)
                 }
            }
        }
    }
    func didTap(button: CalcButton) {
        if hasError && button != .clear {
            return
        }
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currenOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currenOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currenOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currenOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currenOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide:
                    if currentValue == 0 {
                        self.value = "Error"
                        self.hasError = true
                    } else {
                        self.value = "\(runningValue / currentValue)"
                    }
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
            self.hasError = false
            
        case .decimal:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonwidth(item: CalcButton) -> CGFloat {
        if item == .clear {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 3.165}
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
       return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonheight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    ContentView()
}
