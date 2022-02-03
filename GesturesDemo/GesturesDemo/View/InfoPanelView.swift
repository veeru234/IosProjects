//
//  InfoPanelView.swift
//  GesturesDemo
//
//  Created by tecHindustan on 25/01/22.
//

import SwiftUI

struct InfoPanelView: View {
    var scale : CGFloat
    var offSet: CGSize
    @State private var isInfoPanelVisible : Bool = false
    var body: some View {
        //MARK: HSTACK
        
        HStack{
            //MARK: HOTSPOT
            Image(systemName: "smallcircle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1){
                    withAnimation(.easeOut) {
                        isInfoPanelVisible.toggle()
                    }
                }
            Spacer()
            //MARK: INFO PANEL
            HStack{
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                Image(systemName: "arrow.left.and.right")
                Text("\(offSet.width)")
                Spacer()
                Image(systemName: "arrow.up.and.down")
                Text("\(offSet.height)")
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .frame(maxWidth:420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            Spacer()
            
        }// : HSTACK
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offSet: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
