//
//  ThreeDotsIndexView.swift
//  Custom Index View
//
//  Created by Brubrusha on 2/6/21.
//

import SwiftUI

struct ThreeDotsIndexView: View {
    let numberOfPages: Int
    let selectedTab: Int
    
    private let rectangularHeight: CGFloat = 6
    private let rectangularWidth: CGFloat = 18
    private let rectangularRadius: CGFloat = 10
    private let spacing: CGFloat = 4
    
    private let primaryColor = roseColor
    private let secondoryColor = roseColor.opacity(0.4)
    
   // private let smallScale: CGFloat = 0.6
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<numberOfPages) { index in
             //   if shouldShowIndex(index) {
                    if selectedTab == index{
                    Rectangle()
                        .fill(primaryColor)
                        .frame(width: rectangularWidth, height: rectangularHeight)
                        .cornerRadius(rectangularRadius)
                    } else {
                        Circle()
                            .fill(selectedTab == index ? primaryColor : secondoryColor)
//                            .scaleEffect(selectedTab == index ? 1:
//                            smallScale)
                            .frame(width: rectangularHeight, height: rectangularHeight)
                    }
                }
            //}
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

