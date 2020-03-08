//
//  JWT_Tests.swift
//  JWT ToolTests
//
//  Created by Simon on 07/03/2020.
//  Copyright © 2020 Simon Whitaker. All rights reserved.
//

import XCTest

class JWT_Tests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testValidJWT() {
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    do {
      let jwt = try JWT(token)
      XCTAssertEqual(jwt.header.parsedJSON["typ"] as! String, "JWT")
      XCTAssertEqual(jwt.header.parsedJSON["alg"] as! String, "HS256")
      XCTAssertEqual(jwt.payload.parsedJSON["name"] as! String, "John Doe")
      XCTAssertEqual(jwt.payload.parsedJSON["iat"] as! Int, 1516239022)
      XCTAssertEqual(jwt.payload.parsedJSON["sub"] as! String, "1234567890")
    } catch {
      XCTFail()
    }
  }
  
  func testInvalidJWTStructure() {
    XCTAssertThrowsError(try JWT("a")) {
      error in
        XCTAssertEqual(error as! JWTError, JWTError.InvalidJWT)
    }
  }

  func testInvalidJWTEncoding() {
    XCTAssertThrowsError(try JWT("*.*.*")) {
      error in
      XCTAssertEqual(error as! JWTError, JWTError.InvalidB64Encoding)
    }
  }
  func testInvalidJSONContent() {
    XCTAssertThrowsError(try JWT("Zm9v.Zm9v.Zm9v")) {
      error in
      XCTAssertEqual(error as! JWTError, JWTError.InvalidJSONContent)
    }
  }
}
