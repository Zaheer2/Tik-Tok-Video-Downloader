//
//  PopupViewModel.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 18.01.2022.
//

import SwiftUI

struct PopupViewModel {
    let image: String
    let numberText: String
    let headText: String
    let instructionText: String
}

extension PopupViewModel {
    static let promotion = [
        PopupViewModel(image: "promoStar", numberText: "Rate the app", headText: "Month free", instructionText: "Rate the app 5 stars and write a review in the AppStore"),
        PopupViewModel(image: "promoPhone", numberText: "Take a screenshot", headText: "Month free", instructionText: "Take a screenshot of the rating screen"),
        PopupViewModel(image: "promoLetter", numberText: "Send us a screenshot", headText: "Month free", instructionText: "In response, we will send you a promotional code that can be activated in Settings"),
    ]
    
    static let intro = [
        PopupViewModel(image: "IntroPhone1", numberText: "Step #1", headText: "Instruction", instructionText: "In the Tik-Tok application, click “Share” button on the video you like"),
        PopupViewModel(image: "IntroPhone2", numberText: "Step #2", headText: "Instruction", instructionText: "In the drop-down menu - click the \"Link\" button"),
        PopupViewModel(image: "IntroPhone3", numberText: "Step #3", headText: "Instruction", instructionText: "Return to our application and click \"Download Clip\""),
    ]
}
