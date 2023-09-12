//
//  amemoTests.swift
//  amemoTests
//
//  Created by qazx.mac on 11/09/2023.
//

import XCTest

final class amemoTests: XCTestCase {

    func testSum() {
        
        // Arrange
        let classNeedTest = SampleClass()
        
        // Action
        let result = classNeedTest.sumNumber(a: 1, b: 2)
        
        // Assert
        XCTAssertEqual(result, 3, "Expected the sum to be 3")
    }
    
    
    func testAdd() {
        // Arrange
        let classNeedTest = SampleClass()

        // Action
        classNeedTest.addData(4)
        classNeedTest.addData(5)
        classNeedTest.addData(6)
        classNeedTest.addData(7)
        
        
        // Assert
        XCTAssertEqual(classNeedTest.datas.count, 4)
        
    }
    
    

}
