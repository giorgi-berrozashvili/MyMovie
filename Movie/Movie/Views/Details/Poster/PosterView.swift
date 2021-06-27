//
//  PosterView.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit

class PosterView: UIView {
    private typealias Color = ColorLibrary.MovieDetails
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .redraw
            imageView.clipsToBounds = true
        return imageView
    }()
    
    private let ratingView: UIView = {
        let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = Color.posterRatingBackgroundColor
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 14)
            label.textColor = Color.posterRatingTextColor
            label.textAlignment = .center
        return label
    }()
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tintColor = Color.posterFavouriteTintColor
            button.backgroundColor = Color.posterFavouriteBackgroundColor
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        configureHierarchy()
        configureLayout()
    }
    
    convenience init(with model: Model) {
        self.init()
        
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.posterImageView.layer.cornerRadius = 20
        self.favouriteButton.layer.cornerRadius = self.favouriteButton.frame.height / 2.0
        self.ratingView.layer.cornerRadius = self.ratingView.frame.height / 2.0
    }
    
    func configure(with model: Model) {
        self.posterImageView.sd_setImage(with: URL(string: model.imageUrl), completed: nil)
        self.ratingLabel.text = model.ratingText
        self.favouriteButton.setImage(UIImage(named: model.favouriteIconName), for: .normal)
        self.favouriteButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    private func configureHierarchy() {
        self.addSubview(posterImageView)
        self.addSubview(ratingView)
        self.addSubview(favouriteButton)
        self.ratingView.addSubview(ratingLabel)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor),
            posterImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            posterImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ratingView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -Spacing.S),
            ratingView.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: Spacing.S),
            
            ratingLabel.topAnchor.constraint(equalTo: self.ratingView.topAnchor, constant: Spacing.XS),
            ratingLabel.leftAnchor.constraint(equalTo: self.ratingView.leftAnchor, constant: Spacing.XS),
            ratingLabel.rightAnchor.constraint(equalTo: self.ratingView.rightAnchor, constant: -Spacing.XS),
            ratingLabel.bottomAnchor.constraint(equalTo: self.ratingView.bottomAnchor, constant: -Spacing.XS),
            
            favouriteButton.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: Spacing.S),
            favouriteButton.rightAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: -Spacing.S),
            
            favouriteButton.widthAnchor.constraint(equalToConstant: 40),
            favouriteButton.heightAnchor.constraint(equalTo: favouriteButton.widthAnchor),
        ])
    }
}
