//
//  CustomNavigationView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/29/21.
//

import SwiftUI


struct CustomNavigationView: View {
   
   
    var body: some View {
        
        
        
        
            
            ZStack{
            
                VStack{
                    Spacer()
            Rectangle()
                .frame(width: UIScreen.width, height: 100, alignment: .bottom)
                .background(Color.green)
            HStack{
                VStack{
                Image(systemName: "bookmark.circle.fill")
                        .foregroundColor(Color.black)
                Text("Bookmark")
                        .foregroundColor(Color.black)
                }
                VStack{
                Image(systemName: "bookmark.circle.fill")
                Text("Bookmark")
                }
                VStack{
                Image(systemName: "bookmark.circle.fill")
                Text("Bookmark")
                }
                VStack{
                Image(systemName: "bookmark.circle.fill")
                Text("Bookmark")
                }
            }
            }
            
        }
            .background(Color.white)
    }

    
}

//struct CustomNavigationView<Content: View, Destination : [View]>: View {
//    let destination : Destination
//    let isRoot : Bool
//    let isLast : Bool
//    let color : Color
//    let content: Content
//    @State var active = false
//    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//
//    init(destination: Destination, isRoot : Bool, isLast : Bool,color : Color, @ViewBuilder content: () -> Content) {
//        self.destination = destination
//        self.isRoot = isRoot
//        self.isLast = isLast
//        self.color = color
//        self.content = content()
//    }
//
//    var body: some View {
//        NavigationView {
//          //  GeometryReader { geometry in
//                Color.white
//                VStack {
//
//                    self.content
//
//                        //.fullScreenCover(isPresented: $showingDetail, content: IntroBaseTabView.init)
//                        .padding()
//                        .background(color.opacity(0.3))
//                        .cornerRadius(20)
//                    Spacer()
//                    ZStack {
//                        Rectangle()
//
//                            .fill(Color.barGrey)
//
//                        HStack {
//                                Image(systemName: "arrow.left")
//                                    .frame(width: 30)
//                                .onTapGesture(count: 1, perform: {
//                                    self.mode.wrappedValue.dismiss()
//                                }).opacity(isRoot ? 0 : 1)
//                            Spacer()
//                            Text("Download clip")
//
//                            Spacer()
//                            Image(systemName: "arrow.right")
//                                .frame(width: 30)
//                                .onTapGesture(count: 1, perform: {
//                                    self.active.toggle()
//                                })
//                                .opacity(isLast ? 0 : 1)
//                            NavigationLink(
//                                destination: destination.navigationBarHidden(true)
//                                    .navigationBarHidden(true),
//                                isActive: self.$active,
//                                label: {
//                                    //no label
//                                })
//                        }
//                        .padding([.leading,.trailing], 8)
//                        .padding(.top, 60)
//                        .frame(width: UIScreen.width)
//                        .font(.system(size: 22))
//
//                    }
//                    .frame(width:UIScreen.width, height: UIScreen.height / 6, alignment: .bottom)
//                    .edgesIgnoringSafeArea(.bottom)
//                }
//                .frame(width: UIScreen.width)
//
//
//            .navigationBarHidden(true)
//
//        }
//    }
//}
//

//struct CustomNavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomNavigationView()
//    }
//}
