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
  case InvalidUTF8Content
}

public struct JWT {
  var header: String
  var payload: String
  var signature: Data

  init(_ token: String) throws {
    let elements = token.split(separator: ".")
    if elements.count != 3 {
      throw JWTError.InvalidJWT
    }
    
    try header = utf8(b64url_decode(String(elements[0])))
    try payload = utf8(b64url_decode(String(elements[1])))
    try signature = b64url_decode(String(elements[2]))
  }
}

func b64url_decode(_ s: String) throws -> Data {
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

func utf8(_ d: Data) throws -> String {
  guard let s = String(data: d, encoding: .utf8) else {
    throw JWTError.InvalidUTF8Content
  }
  return s
}
