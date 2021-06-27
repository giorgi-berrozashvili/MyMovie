//
//  GridMovieCellModel.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit

struct GridMovieCellModel: CollectionCellModel {
    var identifier: String { return String(describing: GridMovieCollectionViewCell.self) }
    var isBackdropped: Bool
    var domainModel: ModelEntityValidable
}
