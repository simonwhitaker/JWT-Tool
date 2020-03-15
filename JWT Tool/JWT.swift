//
//  JWT.swift
//  JWT Tool
//
//  Created by Simon on 07/03/2020.
//  Copyright © 2020 Simon Whitaker. All rights reserved.
//

import Foundation

enum JWTError: Error {
  case InvalidJWT
  case InvalidB64Encoding
  case InvalidJSONContent
}

struct JWTClaim {
  private(set) public var rawData: Data
  private(set) public var parsedJSON: [String: Any]
  public var formattedString: String
  
  init(_ raw: Data) throws {
    rawData = raw
    do {
      let result = try JSONSerialization.jsonObject(with: rawData, options: [])
      guard let typedResult = result as? [String: Any] else {
        throw JWTError.InvalidJSONContent
      }
      parsedJSON = typedResult
    } catch {
      throw JWTError.InvalidJSONContent
    }
    
    let formattedData = try JSONSerialization.data(withJSONObject: parsedJSON, options: .prettyPrinted)
    formattedString = String(data: formattedData, encoding: .utf8)!
  }
}

public struct JWT {
  var header: JWTClaim
  var payload: JWTClaim
  var signature: Data
  var encodedSignature: String
  var rawToken: String

  init(_ token: String) throws {
    rawToken = token
    let elements = token.split(separator: ".")
    if elements.count != 3 {
      throw JWTError.InvalidJWT
    }
    
    try header = JWTClaim(base64URLDecode(String(elements[0])))
    try payload = JWTClaim(base64URLDecode(String(elements[1])))
    encodedSignature = String(elements[2])
    try signature = base64URLDecode(encodedSignature)
  }
}

func base64URLDecode(_ s: String) throws -> Data {
  let length = s.lengthOfBytes(using: .utf8)
  let paddedString: String
  if (length % 4 > 0) {
    paddedString = s + String(repeating: "=", count: 4 - length % 4)
  } else {
    paddedString = s
  }
  let b64String = paddedString.replacingOccurrences(of: "_", with: "/").replacingOccurrences(of: "-", with: "+")
  guard let d = Data(base64Encoded: b64String) else {
    print("Got bad b64-encoded string: \(paddedString)")
    throw JWTError.InvalidB64Encoding
  }
  return d
}

