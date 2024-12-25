//
//  SectionIndexProxy.swift
//  CoachNest
//
//  Created by ios on 25/12/24.
//

import SwiftUI

struct SectionIndex<ID, TitleContent>: ViewModifier where ID : Hashable, TitleContent : View {
  let proxy: ScrollViewProxy
  let sections: [ID]
  @ViewBuilder let titleContent: (ID, Bool) -> TitleContent

  @State private var selection: ID? = nil

  func body(content: Content) -> some View {
    ZStack {
      content
      // TouchEnterExitReader allows for tracking of finger movement over index shortcuts
      TouchEnterExitReader(ID.self,
                           onEnter: { id in
        selection = id
        withAnimation {
          proxy.scrollTo(id)
        }
      },
                           onExit: { id in
        selection = nil
      }) { touchEnterExitProxy in
        HStack {
          Spacer() // right-align the index
          VStack { // the index itself
            ForEach(sections, id: \.self) { section in
              titleContent(section, selection == section)
                .touchEnterExit(id: section, proxy: touchEnterExitProxy)
                .onTapGesture {
                  withAnimation {
                    proxy.scrollTo(section)
                  }
                }
              }
            }
          }
      }
    }
  }
}


struct GroupTouchEnterExit<ID>: ViewModifier where ID : Hashable {
  let id: ID
  let proxy: TouchEnterExitProxy<ID>

  func body(content: Content) -> some View {
    content
      .background(GeometryReader { geo in
        dragObserver(geo)
      })
  }

  private func dragObserver(_ geo: GeometryProxy) -> some View {
    proxy.register(id: id, frame: geo.frame(in: .global))
    return Color.clear
  }
}

extension View {
  func touchEnterExit<ID: Hashable>(id: ID, proxy: TouchEnterExitProxy<ID>) -> some View {
    self.modifier(GroupTouchEnterExit(id: id, proxy: proxy))
  }
}
