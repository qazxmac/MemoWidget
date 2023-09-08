//
//  ContentView.swift
//  amemo
//
//  Created by qazx.mac on 07/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @State var inputedMemo: String = ""
    @State var toggleNoti: Bool = false
    @State var toggleClipboard: Bool = false
    @State private var isPresentedInput = false
    @State private var isTyping = false
    @FocusState var isFocusing: Bool
    private let height = UIScreen.main.bounds.size.width - 40
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            
            // Input
            ZStack {
                VStack {
                    Spacer().frame(height: 50)
                    TextEditor(text: self.$inputedMemo)
                        .padding(15.0)
                        .background(.yellow)
                        .foregroundColor(.black)
                        .font(.custom("SavoyeLetPlain", size: 30))
                        .frame(width: height, height: (3/4)*height)
                        .cornerRadius(10)
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                            isTyping = true
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                            isTyping = false
                        }
                        .focused($isFocusing)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                self.isFocusing = true
                            }
                        }
                        .onChange(of: inputedMemo) { newValue in
                            print(newValue)
                        }
                }

                
                VStack {
                    if !isTyping {
                        Image("pngwing")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } else {
                        Spacer().frame(width: 100, height: 100)
                    }
                }
                .offset(x: 20, y: -(3/4)*height/2 + 25)
                
//                HStack {
//                    VStack {
//                        if !isTyping {
//                            Image("pngwing")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 100)
//                        } else {
//                            Spacer().frame(width: 100, height: 100)
//                        }
//                        Spacer()
//                    }
//                }
            }
            
            
            ZStack {
                // List
                List {
                    VStack {
                        Spacer()
                        Text("Style")
                        Spacer()
                        HStack {
                            Text("Hello xin chao")
                                .frame(width: 100, height: 100)
                                .background(.yellow)
                                .foregroundColor(.black)
                                .font(.custom("SavoyeLetPlain", size: 30))
                                .cornerRadius(10)
                                .gesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            print("tap 1")
                                            
                                            isPresentedInput = true
                                            
                                        }
                                )
                            Spacer()
                            Text("Hello xin chao")
                                .frame(width: 100, height: 100)
                                .background(.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 0.5)
                                )
                                .gesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            print("tap 2")
                                        }
                                )
                            Spacer()
                            Text("Hello xin chao")
                                .frame(width: 100, height: 100)
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .gesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            print("tap 3")
                                        }
                                )
                        }
                        Spacer()
                    }
                    
                    
                    
                    Toggle("Memo as a notification", isOn: $toggleNoti)
                        .onChange(of: toggleNoti) { newValue in
                            if toggleNoti {
                                print("ON")
                            } else {
                                print("OFF")
                            }
                        }
                    
                    HStack {
                        Toggle("Auto paste from clipboard", isOn: $toggleNoti)
                            .onChange(of: toggleClipboard) { newValue in
                                if toggleClipboard {
                                    print("ON")
                                } else {
                                    print("OFF")
                                }
                            }
                    }
                    HStack {
                        Text("Share memo")
                        Spacer()
                        
                        Image(systemName: "square.and.arrow.up")
                    }
                    HStack {
                        Text("555")
                        Spacer()
                        Text("666")
                    }
                }
                
                if isTyping {
                    HStack {
                        Color.black.opacity(0.9)
                        Spacer()
                    }
                    .transition(AnyTransition.opacity.animation(.linear(duration: 0.25)))
                    .hideKeyboardWhenTappedAround()
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(.black)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("Active")
                isFocusing = true
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
            }
        }
        .fullScreenCover(isPresented: $isPresentedInput, content: {
            InputView( isPresented: $isPresentedInput)
        })
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }
    
    private func figureNoti() {
        
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
