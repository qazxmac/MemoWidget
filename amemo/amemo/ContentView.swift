//
//  ContentView.swift
//  amemo
//
//  Created by qazx.mac on 07/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputedMemo: String = ""
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        
        
        
        for family in UIFont.familyNames {
          let sName: String = family as String
          print("family: \(sName)")

            for name in UIFont.fontNames(forFamilyName: sName) {
            print("name: \(name as String)")
          }
        }
        
        
        
        
    }
    
    var body: some View {
        VStack {
            // Input
            TextEditor(text: self.$inputedMemo)
                .padding(15.0)
                .background(.yellow)
                .foregroundColor(.black)
                .font(.custom("SavoyeLetPlain", size: 30))
                .frame(width: UIScreen.main.bounds.size.width - 40, height: (3/4)*UIScreen.main.bounds.size.width - 40)
                .cornerRadius(10)
                .onChange(of: inputedMemo) { newValue in
                    print(newValue)
                }

            
            // List
            List {

                VStack {
                    Spacer()
                    Text("Theme: ")
                    Spacer()
                    HStack {
                        Text("Hello xin chao")
                            .frame(width: 100, height: 100)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .font(.custom("SavoyeLetPlain", size: 30))
                            .cornerRadius(10)
                        Spacer()
                        Text("Hello xin chao")
                            .frame(width: 100, height: 100)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        Spacer()
                        Text("Hello xin chao")
                            .frame(width: 100, height: 100)
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)

                    }
                    Spacer()
                }
                
                
                
                HStack {
                    Text("333")
                    Spacer()
                    Text("444")
                }
                HStack {
                    Text("555")
                    Spacer()
                    Text("666")
                }
            }
            .hideKeyboardWhenTappedAround()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


extension View {
    func hideKeyboardWhenTappedAround() -> some View  {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                  to: nil, from: nil, for: nil)
        }
    }
}
