//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct ThreeDotsIndexView: View {
    let numberOfPages: Int
    let selectedTab: Int
    
    private let rectangularHeight: CGFloat = 6
    private let rectangularWidth: CGFloat = 18
    private let rectangularRadius: CGFloat = 10
    private let spacing: CGFloat = 4
    private let primaryColor = Color.roseColor
    private let secondoryColor = Color.roseColor.opacity(0.4)
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<numberOfPages) { index in
                    if selectedTab == index {
                    Rectangle()
                        .fill(primaryColor)
                        .frame(width: rectangularWidth, height: rectangularHeight)
                        .cornerRadius(rectangularRadius)
                    } else {
                        Circle()
                            .fill(selectedTab == index ? primaryColor : secondoryColor)
                            .frame(width: rectangularHeight, height: rectangularHeight)
                    }
                }
        }
    }
    func shouldShowIndex(_ index: Int) -> Bool {
        ((selectedTab - 1)...(selectedTab + 1)).contains(index)
    }
}

struct ThreeDotsIndexView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDotsIndexView(numberOfPages: 3, selectedTab: 0)
    }
}
