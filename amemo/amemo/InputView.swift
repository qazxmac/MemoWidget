//
//  InputView.swift
//  amemo
//
//  Created by qazx.mac on 07/09/2023.
//

import SwiftUI

struct InputView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @State var inputedMemo: String = ""
    @State var isShowedInput: Bool = false
    @FocusState var isEditing: Bool
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if isShowedInput {
                    TextEditor(text: self.$inputedMemo)
                        .padding(15.0)
                        .background(.yellow)
                        .foregroundColor(.black)
                        .font(.custom("SavoyeLetPlain", size: 30))
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: (3/4)*(UIScreen.main.bounds.size.width - 40))
                        .cornerRadius(10)
                        .focused($isEditing)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isEditing = true
                            }
                        }
                        .onChange(of: inputedMemo) { newValue in
                            print(newValue)
                        }
                        .padding(15.0)
                        .opacity(isShowedInput ? 1 : 0)
                        .animation(.easeInOut(duration: 3), value: 2)
                }

                List {
                    
                }
                .onTapGesture {
                    print("aaaaaaa")
                    isPresented = false
                }
                .hideKeyboardWhenTappedAround()
            }
            Spacer()
        }
        .onAppear {
            isShowedInput = true
        }

        
        //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.black)
    }
}
