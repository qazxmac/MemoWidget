////
////  TestCode.swift
////  amemo
////
////  Created by qazx.mac on 10/09/2023.
////
//
//import SwiftUI
//
//
//struct SampleModel: Identifiable {
//    let id: UUID = UUID()
//    let name: String
//}
//
//struct TestCode: View {
//    @State var dataModels: [SampleModel] = [
//        SampleModel(name: "Nguyen Van 1"),
//        SampleModel(name: "Nguyen Van 2"),
//        SampleModel(name: "Nguyen Van 3"),
//        SampleModel(name: "Nguyen Van 4"),
//        SampleModel(name: "Nguyen Van 5"),
//        SampleModel(name: "Nguyen Van 6"),
//        SampleModel(name: "Nguyen Van 7"),
//        SampleModel(name: "Nguyen Van 8"),
//        SampleModel(name: "Nguyen Van 9"),
//        SampleModel(name: "Nguyen Van 10"),
//    ]
//
////    var body: some View {
////        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//////        List(dataModels) { model in
//////            Text(model.name).onTapGesture {
//////                print(model.name)
//////            }
//////        }
////        ScrollView {
////            LazyVGrid(columns: [GridItem(.flexible())]) {
////                ForEach(dataModels, id: \.self) { data in
////                    Text(data.name)
////                }
////            }
////        }
////    }
//
//
//
////    var body: some View {
////        ScrollView(.vertical) {
//////            LazyHGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
//////            LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))]) {
//////                ForEach(dataModels, id: \.id) { item in
//////                    Text("\(item.name)")
//////                        .frame(width: 100, height: 100)
//////                        .background(Color.blue)
//////                        .cornerRadius(10)
//////                        .padding(5)
//////                }
//////            }
////
////            LazyVStack {
////                ForEach(dataModels, id: \.id) { item in
////                    Text("\(item.name)")
////                        .frame(width: 100, height: 100)
////                        .background(Color.blue)
////                        .cornerRadius(10)
////                        .padding(5)
////                }
////            }
////
////        }
////    }
//
//    @State private var isToggleOn = false
//
//    var body: some View {
//        VStack {
//            ToggleView(isOn: $isToggleOn)
//            Text(isToggleOn ? "Toggle is ON" : "Toggle is OFF")
//        }
//    }
//
//}
//
//struct ToggleView: View {
//    @Binding var isOn: Bool
//
//    var body: some View {
//        Toggle("Toggle", isOn: $isOn)
//            .padding()
//    }
//}
//
////struct TestCode_Previews: PreviewProvider {
////    static var previews: some View {
////        TestCode()
////    }
////}


import SwiftUI
import Combine

class NumberViewModel: ObservableObject {
    @Published var numbers: [Int] = []
    @Published var sum: Int = 0
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = $numbers
            .sink { [weak self] numbers in
                self?.sum = numbers.reduce(0, +)
            }
        
        
        //        let numbers = (1...5)
        //        let publisher = numbers.publisher
        //
        //        let mappedPublisher = publisher
        //            .map { number in
        //                return number * 2
        //            }
        //
        //        let cancellable = mappedPublisher
        //            .sink { value in
        //                print(value)
        //            }
        
        //        let numbers = (1...5)
        //        let publisher = numbers.publisher
        //
        //        let filteredPublisher = publisher
        //            .filter { number in
        //                return number % 2 == 0
        //            }
        //
        //        let cancellable = filteredPublisher
        //            .sink { value in
        //                print(value)
        //            }
        
        //        let array = ["a", "b", "c", "d", "e"]
        //        let publisher1 = array.publisher
        //
        //        publisher1
        //            .sink { value in
        //                print(value)
        //            }
        
        
        //        let publisher = [1, 2, 3].publisher
        //        let object = MyClass()
        //
        //        let cancellable = publisher
        //            .assign(to: \.value, on: object)
        
        
        
        //        let subject = PassthroughSubject<Int, Never>()
        //
        //        let cancellable = subject
        //            .sink { value in
        //                print(value)
        //            }
        //
        //        subject.send(1)
        //        subject.send(2)
        //        subject.send(3)
        
        
        
        
        
        //        let subject2 = CurrentValueSubject<Int, Never>(0)
        //
        //        let cancellable = subject2
        //            .sink { value in
        //                print(value)
        //            }
        //
        //        subject2.send(1)
        //        subject2.send(2)
        //        subject2.send(3)
        
        
        
        
        
        //        let future = Future<Int, Error> { promise in
        //            DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
        //                promise(.success(42))
        //            }
        //        }
        //
        //        cancellable = future
        //            .sink(
        //                receiveCompletion: { completion in
        //                    switch completion {
        //                    case .finished:
        //                        print("Finished")
        //                    case .failure(let error):
        //                        print("Error: \(error)")
        //                    }
        //                },
        //                receiveValue: { value in
        //                    print(value)
        //                }
        //            )
        
        
        
        //        Task {
        //            await process()
        //        }
        
        
        
        //        let queue = OperationQueue ()
        //        let operation1 = BlockOperation {
        //            for i in 0...100 {
        //                print("======A: \(i)")
        //            }
        //        }
        //        let operation2 = BlockOperation {
        //            for i in 1000...1100 {
        //                print("==============В: \(i))")
        //            }
        //        }
        //        //operation2.addDependency (operation1)
        //        queue.addOperation (operation1)
        //        queue.addOperation (operation2)
        
        
        
//        let queue = DispatchQueue.global()
//        let task1 = DispatchWorkItem {
//            for i in 0...100 {
//                print("==============A：\(i)")
//            }
//        }
//        let task2 = DispatchWorkItem {
//            for i in 1000...1100 {
//                print("==============B: \(i)")
//            }
//        }
////        let dg = DispatchGroup ()
////        queue.async(group: dg, execute: task1)
//        queue.async(execute: task1)
////        queue.async(execute: task2)
//        task1.notify(queue: queue, execute: task2)
        


        
        
//        // Dispatch Group
//        let group = DispatchGroup()
//
//        // Concurrent Dispatch Queue on background
//        let queue = DispatchQueue.global()
//
//        // Result array
//        var results = [String]()
//
//        // DispatchWorkItem
//        let task1 = DispatchWorkItem {
//            for i in 0...100 {
//                print("==============A: \(i)")
//                results.append("A: \(i)")
//            }
//        }
//
//        let task2 = DispatchWorkItem {
//            for i in 1000...1100 {
//                print("==============B: \(i)")
//                results.append("B: \(i)")
//            }
//        }
//
//        // Add DispatchWorkItem to Dispatch Group
//        group.enter()
//        queue.async(group: group, execute: task1)
//        group.leave()
//
//        group.enter()
//        queue.async(group: group, execute: task2)
//        group.leave()
//
//        // Wait all task done
//        group.notify(queue: .main) {
//            print("Result: \(results)")
//        }
        
        
        
        
        
        
        // Tạo các thể hiện của lớp Person
        var john: Person? = Person(name: "John")
        var jane: Person? = Person(name: "Jane")

        // Thiết lập mối quan hệ bestFriend giữa John và Jane
        john?.bestFriend = jane
        jane?.bestFriend = john

        // Giải phóng tham chiếu đến John và Jane
        john = nil
        jane = nil
        
        
        
        
        
        
    }
    
    func addNumber(_ number: Int) {
        numbers.append(number)
    }
    
    
    func fetchData() async -> String {
        do {
            // Simulate waiting api response
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000) // waiting 2 seconds
        } catch { }
        return "Downloading"
    }

    func process() async {
        print("Start")
        
        let result = await fetchData()
        print(result)
        
        print("End")
    }

}


class MyClass {
    var value: Int = 0 {
        didSet {
            print("Value changed to \(value)")
        }
    }
    
}

struct TestCode: View {
    @StateObject private var viewModel = NumberViewModel()
    @State private var newNumber = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter a number", text: $newNumber)
                    .keyboardType(.numberPad)
                Button("Add") {
                    if let number = Int(newNumber) {
                        viewModel.addNumber(number)
                        newNumber = ""
                    }
                }
            }
            .padding()
            
            List(viewModel.numbers, id: \.self) { number in
                Text("\(number)")
            }
            
            Text("Sum: \(viewModel.sum)")
                .font(.headline)
                .padding()
        }
    }
    
    
}

import Foundation

struct Response: Decodable {
    // Define the structure of your API response data
    // based on your specific API endpoint
    // For example, if your API returns JSON with a "message" field:
    let message: String
}

func callAPI() -> Future<Response, Error> {
    return Future<Response, Error> { promise in
        guard let url = URL(string: "https://api.example.com/endpoint") else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            promise(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                promise(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                promise(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                promise(.success(response))
            } catch {
                promise(.failure(error))
            }
        }
        
        task.resume()
    }
}

// Usage:
let cancellable = callAPI()
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("API request completed")
            case .failure(let error):
                print("API request failed with error: \(error)")
            }
        },
        receiveValue: { response in
            print("API response: \(response.message)")
        }
    )

//import CryptoSwift
//
//// MARK: - CryptoData
//class CryptoData {
//    // Encrypt string with AES CBC operation, return encrypted string
//    func AESEncryption(_ encryptString: String) -> String? {
//        let now = "\(Int(Date().timeIntervalSince1970))"
//        // Concat encryptString with now before encrypt
//        let input = Array((encryptString + now).utf8)
//        // Encrypt key
//        let key = Array(PrivateConstant.CRYPTO_KEY.utf8)
//        // Generate random IV value
//        let iv = AES.randomIV(AES.blockSize)
//
//        do {
//            // Encrypt input
//            let encrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).encrypt(input)
//            // Convert IV and encrypted input to string and return concat string
//            return iv.toHexString() + encrypted.toHexString()
//        } catch {
//            return nil
//        }
//    }
//}



class Person {
    let name: String
    weak var bestFriend: Person? // Sử dụng strong reference
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) was deinitted")
    }
}


