//
//  CollectionCellModel.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit

protocol CollectionCellModel {
    var identifier: String { get }
    var domainModel: ModelEntityValidable { get set }
}
