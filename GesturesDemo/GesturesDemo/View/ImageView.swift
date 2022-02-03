//
//  ImageView.swift
//  GesturesDemo
//
//  Created by tecHindustan on 25/01/22.
//

import SwiftUI

struct ImageView: View {
    let icon: String
    var body: some View {
        Image(systemName: icon)
                .font(.system(size: 35))
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}
