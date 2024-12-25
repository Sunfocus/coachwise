//
//  TouchEnterExit.swift
//  CoachNest
//
//  Created by ios on 25/12/24.
//

import SwiftUI

struct TouchEnterExitReader<ID, Content>: View where ID : Hashable, Content : View {
  private let proxy: TouchEnterExitProxy<ID>
  private let content: (TouchEnterExitProxy<ID>) -> Content

  init(_ idSelf: ID.Type, // without this, the initializer can't infer ID type
       onEnter: ((ID) -> Void)? = nil,
       onExit: ((ID) -> Void)? = nil,
       @ViewBuilder content: @escaping (TouchEnterExitProxy<ID>) -> Content) {
    proxy = TouchEnterExitProxy(onEnter: onEnter, onExit: onExit)
    self.content = content
  }

  var body: some View {
    content(proxy)
      .gesture(
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
          .onChanged { value in
            proxy.check(dragPosition: value.location)
          }
      )
  }
}


class TouchEnterExitProxy<ID: Hashable> {
  let onEnter: ((ID) -> Void)?
  let onExit: ((ID) -> Void)?

  private var frames = [ID: CGRect]()
  private var didEnter = [ID: Bool]()

  init(onEnter: ((ID) -> Void)?,
       onExit: ((ID) -> Void)?) {
    self.onEnter = onEnter
    self.onExit = onExit
  }

  func register(id: ID, frame: CGRect) {
    frames[id] = frame
    didEnter[id] = false
  }

  func check(dragPosition: CGPoint) {
    for (id, frame) in frames {
      if frame.contains(dragPosition) {
        DispatchQueue.main.async { [self] in
          didEnter[id] = true
          onEnter?(id)
        }
      } else if didEnter[id] == true {
        DispatchQueue.main.async { [self] in
          didEnter[id] = false
          onExit?(id)
        }
      }
    }
  }
}

extension View {
  func firstLetterSectionIndex(proxy: ScrollViewProxy, sections: [String]) -> some View {
    self.modifier(SectionIndex(proxy: proxy, sections: sections, titleContent: { title, isSelected in
      Text(title.prefix(1))
        .font(.system(size: isSelected ? 30 : 16))
        .fontWeight(isSelected ? .bold : .regular)
        .foregroundColor(.primaryTheme)
        .padding(.trailing, 3)
    }))
  }
}
