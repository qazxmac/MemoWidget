//
//  ContentView.swift
//  amemo
//
//  Created by qazx.mac on 07/09/2023.
//

import SwiftUI
import WidgetKit
import UserNotifications
import FirebaseRemoteConfig
import GoogleMobileAds

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @State var inputedMemo: String = ""
    
    // Theme
    @State var themeSelected: Theme = .YELLOW
    @State var handwritingFont: Bool = true
    @State var selectedFont: FontType = .handwritingFont
    // Noti
    @State var toggleNoti: Bool = false
    @State private var showingAlertNoti = false
    // Clipboard
    @State var toggleClipboard: Bool = false
    // Input
    @State private var isPresentedInput = false
    @State private var isTyping = false
    @FocusState var isFocusing: Bool
    private let height = UIScreen.main.bounds.size.width - 40
    // Alert
    @State private var isShowingUpdateAlert = false
    @State private var appStoreURL: URL?
    
    // Ads
    @State private var canShowApp: Bool = false
    
    // Copy
    @State private var copyState = "Copy all"
    
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
                        .font(selectedFont.font)
                        .transparentScrolling()
                        .overlay(
                            Group {
                                switch themeSelected {
                                case .BLACK:
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 1)
                                default:
                                    EmptyView()
                                }
                            }
                        )
                        .frame(width: height, height: (3/4)*height)
                        .cornerRadius(10)
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                            withAnimation {
                                isTyping = true
                            }
                            copyState = "Copy all"
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                            withAnimation {
                                isTyping = false
                            }
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
                            
                            copyState = "Copy all"
                        }
                }
                
                VStack {
                    if !isTyping {
                        Image("pngwing")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .transition(.move(edge: .top))
                    } else {
                        VStack {
                            HStack {
                                Group {
                                    Image(systemName: "doc.on.doc.fill")
                                    Text("Paste")
                                }.onTapGesture {
                                    guard let copied = UIPasteboard.general.string else { return }
                                    inputedMemo = inputedMemo.isEmpty ? copied : (inputedMemo.trimmingCharacters(in: .whitespacesAndNewlines) + "\n" + copied)
                                }
                                Spacer()
                                Group {
                                    Image(systemName: "trash.slash.circle")
                                    Text("Clear all")
                                }.onTapGesture {
                                    inputedMemo = ""
                                }
                                Spacer().frame(width: 40)
                            }
                            .opacity(0.3)
                            .padding(.bottom, 40.0)
                        }
                    }
                }
                .offset(x: 20, y: -(3/4)*height/2 + 25)
            }
            
            ZStack {
                // List
                List {
                    VStack {
                        HStack {
                            if !isTyping {
                                Image(systemName: "gear")
                                Text("Options")
                                    .fontWeight(.heavy)
                            }
                            Spacer()
                        }.frame(height: 50)
                        HStack {
                            ZStack {
                                Text(inputedMemo.isEmpty ? "Your memo look like this" : inputedMemo)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .frame(width: 100, height: 100)
                                    .background(.yellow)
                                    .foregroundColor(.black)
                                    .font(selectedFont.font)
                                    .cornerRadius(12)
                                    .gesture(
                                        TapGesture()
                                            .onEnded { _ in
                                                print("tap 1")
                                                themeSelected = .YELLOW
                                                UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(themeSelected.rawValue, forKey: "amemo.theme")
                                            }
                                    )
                                if themeSelected == .YELLOW {
                                    PenImgView()
                                }
                            }
                            Spacer()
                            ZStack {
                                Text(inputedMemo.isEmpty ? "Your memo look like this" : inputedMemo)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .frame(width: 100, height: 100)
                                    .background(.white)
                                    .foregroundColor(.black)
                                    .font(selectedFont.font)
                                    .cornerRadius(12)
                                    .gesture(
                                        TapGesture()
                                            .onEnded { _ in
                                                print("tap 2")
                                                themeSelected = .WHITE
                                                UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(themeSelected.rawValue, forKey: "amemo.theme")
                                            }
                                    )
                                if themeSelected == .WHITE {
                                    PenImgView()
                                }
                            }
                            Spacer()
                            ZStack {
                                Text(inputedMemo.isEmpty ? "Your memo look like this" : inputedMemo)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .frame(width: 100, height: 100)
                                    .background(.black)
                                    .foregroundColor(.white)
                                    .font(selectedFont.font)
                                    .cornerRadius(12)
                                    .gesture(
                                        TapGesture()
                                            .onEnded { _ in
                                                print("tap 3")
                                                themeSelected = .BLACK
                                                UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(themeSelected.rawValue, forKey: "amemo.theme")
                                            }
                                    )
                                if themeSelected == .BLACK {
                                    PenImgView()
                                }
                            }
                        }
                        Spacer()
                        Text("Theme (your widget will also be applied)")
                            .foregroundColor(Color(hue: 0.532, saturation: 0.409, brightness: 0.451))
                            .font(.system(size: 12))
                        Spacer()
                    }
                    // Handwriting font
                    Toggle("Handwriting Font", isOn: $handwritingFont)
                        .onChange(of: handwritingFont) { newValue in
                            selectedFont = newValue ? .handwritingFont : .systemFont
                            UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(selectedFont.rawValue, forKey: "amemo.handwriting")
                        }
                    // Notification
                    Toggle("Memo as a notification", isOn: $toggleNoti)
                        .onChange(of: toggleNoti) { newValue in
                            if toggleNoti {
                                print("ON")
                                requestNotificationPermission(completion: { granted in
                                    self.showingAlertNoti = !granted
                                    UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(granted, forKey: "amemo.noti")
                                })
                            } else {
                                print("OFF")
                                UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(false, forKey: "amemo.noti")
                                UIApplication.shared.applicationIconBadgeNumber = 0
                            }
                        }
                    
                    // Paste clipboard
                    Toggle("Auto paste from clipboard", isOn: $toggleClipboard)
                        .onChange(of: toggleClipboard) { newValue in
                            if toggleClipboard {
                                print("Clipboard ON")
                                UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(true, forKey: "amemo.clipboard")
                                updateClipBoard()
                            } else {
                                print("Clipboard OFF")
                                UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(false, forKey: "amemo.clipboard")
                                UserDefaults(suiteName: "group.trung.trong.nguyen")?.set("", forKey: "amemo.lastclipboard")
                            }
                        }
                    
                    // Share memo
                    HStack {
                        Text("Share")
                        Image(systemName: "square.and.arrow.up")
                        Text("|")
                        Text("Save")
                        Image(systemName: "square.and.arrow.down")
                        Text("|")
                        Text("Copy")
                        Image(systemName: "doc.on.doc")
                        Spacer()
                    }.onTapGesture {
                        shareContent()
                    }
                    
                    if canShowApp {
                        BannerView().frame(height: 250)
                    }
                    
                    Spacer()
                }
                .transparentScrolling()
                
                if isTyping {
                    VStack {
                        HStack {
                                Spacer().frame(width: 20)
                                Image(systemName: "gear")
                                Text("Options")
                            Spacer()
                            
                            Group {
                                Image(systemName: "doc.on.doc")
                                Text(copyState)
                                Spacer().frame(width: 20)
                            }.onTapGesture {
                                UIPasteboard.general.string = inputedMemo
                                copyState = "Copied"
                            }
                        }.opacity(0.3)
                        Spacer()
                    }
                    .background(.black).opacity(0.9)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.1)))
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
                
                checkAppVersion()
            } else if newPhase == .background {
                print("Background")
                WidgetCenter.shared.reloadAllTimelines()
                // Noti
                figureNotification()
            }
        }
        .fullScreenCover(isPresented: $isPresentedInput, content: {
            //InputView( isPresented: $isPresentedInput)
        })
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
        .alert(isPresented: $showingAlertNoti) {
            Alert(
                title: Text("Please go to Settings to enable notification permissions for the app."),
                message: Text("Notification permission allows you to view your memo on the lock screen as a notification. You will receive a notification of memo content immediately every time you exit the application"),
                primaryButton: .default(Text("Cancel"), action: {
                    toggleNoti = false
                }),
                secondaryButton: .default(Text("Settings"), action: {
                    openAppSettings()
                    toggleNoti = false
                })
            )
        }
        .alert(isPresented: $isShowingUpdateAlert) {
            Alert(
                title: Text("Update App"),
                message: Text("A new version of the app is available. Please update to continue using."),
                dismissButton: .default(Text("Update"), action: {
                    if let url = appStoreURL {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                })
            )
        }
    }
    
    private func loadDataContent() {
        // Content
        let content = UserDefaults(suiteName: "group.trung.trong.nguyen")?.string(forKey: "amemo.content") ?? "Hey! Here is a sample note\n1. This Widget automatically updates content immediately after taking notes.\n2. The keyboard will appear immediately and be ready for input when you touch here.\n3. Change themes and fonts to your liking.\n4. Option to send a notification of noted content immediately after leaving the application.\n5. Option to paste previously copied content when opening the application.\n6. Share noted content."
        inputedMemo = content.isEmpty ? "" : content.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
        
        // Noti
        toggleNoti = UserDefaults(suiteName: "group.trung.trong.nguyen")?.bool(forKey: "amemo.noti") ?? false
        
        // Clipboard
        updateClipBoard()
    }
    
    func updateClipBoard() {
        let content = UserDefaults(suiteName: "group.trung.trong.nguyen")?.string(forKey: "amemo.content") ?? ""
        if let clipBoard = UserDefaults(suiteName: "group.trung.trong.nguyen")?.bool(forKey: "amemo.clipboard"), clipBoard {
            toggleClipboard = clipBoard
            if let copied = UIPasteboard.general.string, toggleClipboard {
                let lastClipboard = UserDefaults(suiteName: "group.trung.trong.nguyen")?.string(forKey: "amemo.lastclipboard") ?? ""
                if lastClipboard != copied {
                    inputedMemo = inputedMemo.isEmpty ? (copied + "\n") : (content.trimmingCharacters(in: .whitespacesAndNewlines) + "\n" + copied + "\n")
                    UserDefaults(suiteName: "group.trung.trong.nguyen")?.set(copied, forKey: "amemo.lastclipboard")
                }
            }
        } else {
            toggleClipboard = false
        }
    }
    
    private func updateUI() {
        guard let themeNumber = UserDefaults(suiteName: "group.trung.trong.nguyen")?.integer(forKey: "amemo.theme") else { return }
        self.themeSelected = Theme.convertToTheme(themeNumber)
    }
    
    private func shareContent() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        let contentToShared = UserDefaults(suiteName: "group.trung.trong.nguyen")?.string(forKey: "amemo.content") ?? ""
        
        let activityViewController = UIActivityViewController(activityItems: [contentToShared], applicationActivities: nil)
        rootViewController.present(activityViewController, animated: true, completion: nil)
    }
    
    func checkAppVersion() {
        let remoteConfig = RemoteConfig.remoteConfig()

        // Thiết lập giá trị mặc định cho phiên bản ứng dụng
        let defaultConfig: [String: Any] = [
            "app_version": "1.0.0", // Phiên bản mặc định của ứng dụng
            "app_store_url": "" // URL App Store mặc định
        ]
        remoteConfig.setDefaults(defaultConfig as? [String: NSObject])

        // Lấy giá trị từ Remote Config
        remoteConfig.fetch { (status, error) in
            if status == .success {
                remoteConfig.activate { (changed, error) in
                    let remoteVersion = remoteConfig["app_version"].stringValue ?? ""
                    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""

                    // So sánh phiên bản hiện tại với phiên bản từ Remote Config
                    if remoteVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
                        let appStoreURLString = remoteConfig["app_store_url"].stringValue ?? ""
                        if let url = URL(string: appStoreURLString) {
                            appStoreURL = url
                            isShowingUpdateAlert = true
                        }
                    }
                    
                    // Show ads
                    if let canShowAdsRemote = remoteConfig["can_show_ads"].stringValue,
                        let valueInt = Int(canShowAdsRemote) {
                        canShowApp = (valueInt == 1)
                    }
                }
            }
        }
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


func requestNotificationPermission( completion: @escaping (_ granted: Bool) -> ()){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        completion(granted)
    }
}

// Hàm xử lý khi người dùng nhấn vào nút "Settings"
func openAppSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
        return
    }
    
    if UIApplication.shared.canOpenURL(settingsURL) {
        UIApplication.shared.open(settingsURL)
    }
}

func figureNotification() {
    guard let data = UserDefaults(suiteName: "group.trung.trong.nguyen")?.string(forKey: "amemo.content"), !data.isEmpty,
          let notiPermission = UserDefaults(suiteName: "group.trung.trong.nguyen")?.bool(forKey: "amemo.noti"), notiPermission
    else { return }
    UIApplication.shared.applicationIconBadgeNumber = 0
    let content = UNMutableNotificationContent()
    content.title = "amemo"
    content.body = data
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { error in }
    UIApplication.shared.applicationIconBadgeNumber = 1
}

public extension View {
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
}

enum FontType: Int {
    case handwritingFont = 0
    case systemFont = 1
    
    var font: Font {
        switch self {
        case .handwritingFont:
            return .custom("SavoyeLetPlain", size: 25)
        case .systemFont:
            return .custom("Charter-Roman", size: 16)
        }
    }
}

struct PenImgView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Image("pngwing pen")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .offset(x: 40, y: -5)
        }
    }
}

struct BannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3502939148318468~9313575820" // Thay YOUR_AD_UNIT_ID bằng ID đơn vị quảng cáo của bạn
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            bannerView.rootViewController = scene.windows.first?.rootViewController
        }
        bannerView.load(GADRequest())
        return bannerView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
        // Không cần cập nhật gì khi view đã được hiển thị
    }
}
