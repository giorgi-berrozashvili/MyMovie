//
//  UIViewControllerConfigurable.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

protocol Configurable {
    associatedtype ControllerType = Self
    static func configured() -> ControllerType
}
