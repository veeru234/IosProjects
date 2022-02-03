//
//  PageModel.swift
//  GesturesDemo
//
//  Created by tecHindustan on 27/01/22.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName : String
}
//MARK: page extension
extension Page {
    var thumNailImage : String {
        return "thumb-" + imageName
    }
}

