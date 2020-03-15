//
//  ContentView.swift
//  JWT Tool
//
//  Created by Simon on 03/03/2020.
//  Copyright © 2020 Simon Whitaker. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var jwtToken: JWT = try! JWT("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c")
  var body: some View {
    HStack{
      TextView("JWT Token", text: $jwtToken.rawToken)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack(alignment: .trailing) {
        TextView("Header", text: $jwtToken.header.formattedString)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        TextView("Payload", text: $jwtToken.payload.formattedString)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        TextView("Signature", text: $jwtToken.encodedSignature)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
