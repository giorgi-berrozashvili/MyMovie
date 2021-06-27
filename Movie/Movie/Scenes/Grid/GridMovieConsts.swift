//
//  GridMovieConsts.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit

struct GridMovieConsts {
    struct Structure {
        static let segmentItems = ["Popular", "Top Rated", "Favourites"]
    }
    
    struct Metric {
        static let segmentHeight: CGFloat = 36.0
    }
    
    struct Text {
        static let navigationTitle = "Movies"
    }
    
    struct Color {
        static let navigationTitleColor = UIColor.white
        static let navigationBarTintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
}
