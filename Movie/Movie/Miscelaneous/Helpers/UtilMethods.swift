//
//  UtilMethods.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import Foundation

struct Util {
    static func getConverted(_ date: String, fromFormat: String, toFormat: String) -> String? {
        let initialDateFormat = DateFormatter()
            initialDateFormat.dateFormat = fromFormat

        let desiredDateFormat = DateFormatter()
            desiredDateFormat.dateFormat = toFormat

        guard let date = initialDateFormat.date(from: date) else { return nil }
        return desiredDateFormat.string(from: date)
    }
}
