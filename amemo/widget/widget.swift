//
//  widget.swift
//  widget
//
//  Created by qazx.mac on 08/09/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct widgetEntryView : View {
    var entry: Provider.Entry
    // Theme
    @State var themeSelected: Theme = .YELLOW
    var body: some View {
        
        let content = UserDefaults(suiteName: "group.trung.trong.nguyen")?.string(forKey: "amemo.content") ?? ""
        
        VStack {
            Text(content)
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
        }
        .padding(15)
        .onAppear{
            updateUI()
        }
        .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
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
    }
    
    private func updateUI() {
        guard let themeNumber = UserDefaults(suiteName: "group.trung.trong.nguyen")?.integer(forKey: "amemo.theme") else { return }
        self.themeSelected = Theme.convertToTheme(themeNumber)
    }
}

struct widget: Widget {
    let kind: String = "widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("amemo")
        .description("Choise your memo size")
    }
}

//struct widget_Previews: PreviewProvider {
//    static var previews: some View {
//        widgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}


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
