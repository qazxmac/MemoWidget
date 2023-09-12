//
//  SampleClass.swift
//  amemo
//
//  Created by qazx.mac on 11/09/2023.
//

import Foundation

class SampleClass {
    
    var datas: [Int] = []
    
    func sumNumber(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func addData(_ number: Int) {
        datas.append(number)
    }
    
}
