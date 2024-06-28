//
//  KeyboardResponse.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 20.04.2022.
//

//import SwiftUI
//import Combine
//
//class KeyboardResponder: ObservableObject {
//    @Published var keyboardHeight: CGFloat = 0 // if one is in ViewModel: ObservableObject
//
//    private var cancellableSet: Set<AnyCancellable> = []
//        
//    init() {
//            
//         NotificationCenter.default.publisher(for: UIWindow.keyboardWillShowNotification)
//           .map {
//                 guard
//                     let info = $0.userInfo,
//                     let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
//                     else { return 0 }
//
//                 return keyboardFrame.height
//             }
//             .assign(to: \.keyboardHeight, on: self)
//             .store(in: &cancellableSet)
//            
//         NotificationCenter.default.publisher(for: UIWindow.keyboardDidHideNotification)
//             .map { _ in 0 }
//             .assign(to: \.keyboardHeight, on: self)
//             .store(in: &cancellableSet)
//        }
//}
