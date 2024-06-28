//
//  PromocodeView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 11/3/21.
//

import SwiftUI

struct PromocodeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Text("Hellow promocode!")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }){
                HStack{
                    Image("ArrowBack")
                        .frame(width: 20, height: 20, alignment: .center)
                    Text("Back")
                        .foregroundColor(.roseColor)
                }
            })
    }
    
}

struct PromocodeView_Previews: PreviewProvider {
    static var previews: some View {
        PromocodeView()
    }
}
