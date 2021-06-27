//
//  ColorLibrary.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import UIKit

struct ColorLibrary {
    struct Welcome {
        static let applicationWelcomeLabelColor = #colorLiteral(red: 0.6, green: 0.2, blue: 1, alpha: 1)
        static let applicationLogoTintColor = #colorLiteral(red: 0.431372549, green: 0.2, blue: 1, alpha: 1)
        static let applicationSplashingViewColor = #colorLiteral(red: 0.4308167358, green: 0.2, blue: 1, alpha: 1)
    }
    
    struct MovieDetails {
        static let titleLabelColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        static let descriptionLabelColor = #colorLiteral(red: 0.08407842368, green: 0.1311740577, blue: 0.0653648302, alpha: 1)
        static let releaseDateLabelColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        static let posterRatingBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        static let posterRatingTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let posterFavouriteBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        static let posterFavouriteTintColor = #colorLiteral(red: 0.4308167358, green: 0.2, blue: 1, alpha: 1)
    }
}
