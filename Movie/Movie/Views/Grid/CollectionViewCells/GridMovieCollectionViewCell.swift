//
//  GridMovieCollectionViewCell.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import UIKit
import SDWebImage

class GridMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.layer.cornerRadius = 16
        self.imageView.image = UIImage(named: "movie-grid-placeholder")
    }
}

extension GridMovieCollectionViewCell: CollectionCellConfigurable {
    func configure(with model: CollectionCellModel) {
        guard let model = model as? GridMovieCellModel,
              let entityModel = model.domainModel as? MovieEntityModel,
              entityModel.isValid() else { return }
        
        let path = model.isBackdropped ? entityModel.backdropPath : entityModel.posterPath
        
        let url = URL(
            string:
                ImageURLBuilder()
                .withBaseUrl()
                .withSize(.w500)
                .withIdentifier(path!)
                .urlString
        )
        
        self.imageView.sd_setImage(with: url) { [weak self] _,_,_,_ in
            self?.imageView.layer.borderWidth = 0.5
            self?.imageView.layer.borderColor = UIColor.black.cgColor
        }
    }
}
