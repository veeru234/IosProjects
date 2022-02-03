//
//  ContentView.swift
//  GesturesDemo
//
//  Created by tecHindustan on 25/01/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: Property
    
    @State private var isAnimating : Bool = false
    @State private var imageScale : CGFloat = 1
    @State private var imageOffSet : CGSize = .zero
    @State private var isDrawerOPen : Bool  = false
    @State private var pageIndex : Int = 1
    //MARK: Instance of pageModel
    let pages: [Page] = pageData
    
    
    //MARK: Function
    // for resetting the images
    func resetImageSize(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffSet = .zero
        }
    }
    func currentPage()-> String {
        return pages[pageIndex-1].imageName
    }
    //MARK: Content
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                //MARK: Page Image
                Image(currentPage())
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(imageOffSet)
                    .scaleEffect(imageScale)
                //MARK: DoubleTapGesture
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                            
                        } else {
                            resetImageSize()
                        }
                    })
                //MARK: Drag Gesture
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.easeInOut(duration: 1)){
                                    imageOffSet = value.translation
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    resetImageSize()
                                }
                            }
                    )
                //MARK: MAGNIFICATION GESTURE
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    } else if  imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                            .onEnded { _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageSize()
                                }
                            }
                    )
            }// : ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            })
            //MARK: Info PanelView
            .overlay(
                InfoPanelView(scale: imageScale, offSet: imageOffSet)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            //MARK: Controls
            .overlay (
                Group {
                    HStack {
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    if imageScale <= 1 {
                                        resetImageSize()
                                    }
                                }
                                
                            }
                        } label: {
                            ImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // SCALE DOWN
                        // RESET
                        Button {
                            resetImageSize()
                        } label: {
                            ImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        // SCALE UP
                        Button {
                            withAnimation(.spring()){
                                if imageScale < 5 {
                                    imageScale += 1
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            ImageView(icon: "plus.magnifyingglass")
                        }
                        
                    } //: Controls
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom , 30)
                , alignment: .bottom
            )
            //MARK: DRAWER
            .overlay(
                HStack(spacing: 12) {
                    //MARK: DRAW HANDLE
                    Image(systemName: isDrawerOPen ? "chevron.compact.right" :"chevron.compact.left" )
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut) {
                            isDrawerOPen.toggle()
                            }
                        })
                    //MARK: THUMBNAILS
                    ForEach(pages) { item in
                        Image(item.thumNailImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .opacity(isDrawerOPen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrawerOPen)
                            .onTapGesture(perform: {
                             isAnimating = true
                            pageIndex = item.id
                                
                                
                            })
                    }
                    Spacer()
                } //: DRAWER
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width : 260)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOPen ? 20 : 220)
                , alignment: .topTrailing
            )
            
        }//: NavigationView
        .navigationViewStyle(.stack)
    }
}
//MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
