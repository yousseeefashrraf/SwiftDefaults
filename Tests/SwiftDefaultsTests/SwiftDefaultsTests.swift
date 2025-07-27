//
//  SwiftDefaultsTests.swift
//  SwiftDefaultsTests
//
//  Created by Youssef Ashraf on 27/07/2025.
//

import XCTest
@testable import SwiftDefaults

enum UserType: String, DefaultValue{
    typealias DefaultType = UserType
    
    case newUser = "newUser", currentUser = "currentUser"
    static var key: String { "UserType" }
    static var defaultValue: UserType { .newUser }
}

final class SwiftDefaultsTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

final class UserDefaultsManagerTest: XCTestCase{
    
     func testGetStoredValueWithoutInit() async{
        let result = await UserDefaultsManager.shared.getStoredValue(forType: UserType.self)
        
        XCTAssertNil(result)
    }
    
     func testInit() async{
         await UserDefaultsManager.shared.initiate(forType: UserType.self)
        let result = await UserDefaultsManager.shared.isStored(forKey: UserType.key)
        XCTAssertEqual(result, true)
    }
    
    func testGetStoredValueWithInit() async{
        let result = await UserDefaultsManager.shared.getStoredValue(forType: UserType.self)
        
        XCTAssertEqual(result, "newUser")

    }
}
