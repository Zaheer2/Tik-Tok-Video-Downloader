//
//  ButtonStyle.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/26/21.
//

import SwiftUI

enum ButtonsColor {
    case rose
    case gray
}

struct MainButtonStyle: ButtonStyle {
    var color: ButtonsColor
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: Constant.Size.mainButtonsWidth, height: 50, alignment: .center)
            .foregroundColor(color.getFontColor)
            .background(color.getBackgroundColor).opacity( configuration.isPressed ? 0.5 : 1 )
            .cornerRadius(10)
    }
}

func makeMainButtonLabel(image: String, text: String, isReversed: Bool, color: ButtonsColor) -> some View {
    HStack {
        if isReversed {
            Text(text)
                .font(.system(size: 16, weight: .regular, design: .default))
            Image(systemName: image)
                .frame(width: 20, height: 20, alignment: .center)
        } else {
            Image(systemName: image)
                .frame(width: 20, height: 20, alignment: .center)
            Text(text)
                .font(.system(size: 16, weight: .regular, design: .default))
        }
    }
}

extension ButtonsColor {
    var getFontColor: Color {
        get {
            switch self {
            case .rose: return Color.white
            case .gray: return Color.lightGray
            }
        }
    }
    
    var getBackgroundColor: Color {
        get {
            switch self {
            case .rose: return Color.roseColor
            case .gray: return Color.barBackgroundGrey
            }
        }
    }
}

extension View {
    func mainButtonStyle(color: ButtonsColor) -> some View {
        buttonStyle(MainButtonStyle(color: color))
    }
}
