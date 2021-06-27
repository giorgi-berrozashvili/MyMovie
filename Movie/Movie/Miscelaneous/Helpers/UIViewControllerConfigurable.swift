//
//  UIViewControllerConfigurable.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

protocol Configurable {
    associatedtype TransferData
    static func configured(with data: TransferData?) -> Self
}
