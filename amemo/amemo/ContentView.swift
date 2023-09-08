//
//  ContentView.swift
//  amemo
//
//  Created by qazx.mac on 07/09/2023.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @State var inputedMemo: String = ""
    
    // Theme
    @State var themeSelected: Theme = .YELLOW
    // Noti
    @State var toggleNoti: Bool = false
    // Clipboard
    @State var toggleClipboard: Bool = false
    @State var lastClipboard: String = ""
    // Input
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
                        .background(
                            Group {
                                switch themeSelected {
                                case .WHITE:
                                    Color.white
                                case .BLACK:
                                    Color.black
                                default:
                                    Color.yellow
                                }
                            }
                        )
                        .foregroundColor({
                            switch themeSelected {
                            case .WHITE:
                                return Color.black
                            case .BLACK:
                                return Color.white
                            default:
                                return Color.black
                            }
                        }())
                        .font({
                            switch themeSelected {
                            case .WHITE, .BLACK:
                                return Font.system(size: UIFont.labelFontSize)
                            default:
                                return .custom("SavoyeLetPlain", size: 25)
                            }
                        }())
                    
                        .overlay(
                            Group {
                                switch themeSelected {
                                case .BLACK:
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 0.5)
                                default:
                                    EmptyView()
                                }
                            }
                        )
                    
                    
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
                            UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(inputedMemo, forKey: "amemo.content")
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
            }
            
            ZStack {
                // List
                List {
                    VStack {
                        Spacer()
                        Text("Style (Widget will also be applied)")
                        Spacer()
                        HStack {
                            Text("Hello xin chao")
                                .frame(width: 100, height: 100)
                                .background(.yellow)
                                .foregroundColor(.black)
                                .font(.custom("SavoyeLetPlain", size: 20))
                                .cornerRadius(10)
                                .gesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            print("tap 1")
                                            themeSelected = .YELLOW
                                            UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(themeSelected.rawValue, forKey: "amemo.theme")
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
                                            themeSelected = .WHITE
                                            UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(themeSelected.rawValue, forKey: "amemo.theme")
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
                                            themeSelected = .BLACK
                                            UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(themeSelected.rawValue, forKey: "amemo.theme")
                                        }
                                )
                        }
                        Spacer()
                    }
                    
                    // Notification
                    Toggle("Memo as a notification", isOn: $toggleNoti)
                        .onChange(of: toggleNoti) { newValue in
                            if toggleNoti {
                                print("ON")
                            } else {
                                print("OFF")
                            }
                        }
                    
                    // Paste clipboard
                    HStack {
                        Toggle("Auto paste from clipboard", isOn: $toggleClipboard)
                            .onChange(of: toggleClipboard) { newValue in
                                if toggleClipboard {
                                    print("ON")
                                } else {
                                    print("OFF")
                                }
                            }
                    }
                    
                    // Share memo
                    HStack {
                        Text("Share memo")
                        Spacer()
                        
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    // TODO: -
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
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
                    .hideKeyboardWhenTappedAround()
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(.black)
        .onAppear {
            updateUI()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("Active")
                isFocusing = true
                loadDataContent()
            } else if newPhase == .background {
                print("Background")
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        .fullScreenCover(isPresented: $isPresentedInput, content: {
            InputView( isPresented: $isPresentedInput)
        })
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }
    
    private func loadDataContent() {
        let content = UserDefaults(suiteName: "group.trung.trong.nguyen")?.string(forKey: "amemo.content") ?? ""
        inputedMemo = content.isEmpty ? "" : content.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
        print("aaaaa \(content)")
        
        //        if toggleClipboard,
        //           let copied = UIPasteboard.general.string, lastClipboard != copied {
        //            inputedMemo = inputedMemo.isEmpty ? (copied + "\n") : (content.trimmingCharacters(in: .whitespacesAndNewlines) + "\n" + copied + "\n")
        //            lastClipboard = copied
        //        }
    }
    
    private func updateUI() {
        guard let themeNumber = UserDefaults(suiteName: "group.trung.trong.nguyen")?.integer(forKey: "amemo.theme") else { return }
        self.themeSelected = Theme.convertToTheme(themeNumber)
    }
}

enum Theme: Int {
    case YELLOW = 0
    case WHITE = 1
    case BLACK = 2
    
    static func convertToTheme(_ value: Int) -> Theme {
        switch value {
        case 1:
            return .WHITE
        case 2:
            return .BLACK
        default:
            return .YELLOW
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
