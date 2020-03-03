//
//  ContentView.swift
//  JWT Tool
//
//  Created by Simon on 03/03/2020.
//  Copyright © 2020 Simon Whitaker. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var jwtToken = ""
  var body: some View {
    HStack{
      TextField("JWT Token", text: $jwtToken)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
      VStack(alignment: .trailing) {
        Text("Header")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding()
        Spacer()
        Text("Payload")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding()
        Spacer()
        Text("Signature")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding()
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
