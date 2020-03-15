//
//  TextFieldView.swift
//  JWT Tool
//
//  Created by Simon Whitaker on 15/03/2020.
//  Copyright © 2020 Simon Whitaker. All rights reserved.
//

import SwiftUI

struct TextView: NSViewRepresentable {
  var value: String
  var text: Binding<String>
  
  func makeNSView(context: Context) -> NSTextView {
    let tv = NSTextView(frame: .zero)
    if let font = NSFont(name: "Menlo", size: 11.0) {
      tv.typingAttributes = [NSAttributedString.Key.font: font]
    }
    return tv
  }
  
  func updateNSView(_ view: NSTextView, context: Context) {
    view.string = text.wrappedValue
  }
  
  public init(_ content: String, text: Binding<String>) {
    value = content
    self.text = text
  }
}

struct TextView_Previews: PreviewProvider {
  static var previews: some View {
    TextView("Test value here", text: .constant("foo"))
  }
}
