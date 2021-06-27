//
//  ModelEntityMappable.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

protocol ModelEntityMappable {
    static func fromDictionary(_ dictionary: [String: Any?]) -> Self
    func toDictionary() -> [String: Any?]
}
