//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit

protocol MovieDetailsView: AnyObject {
    
}

class MovieDetailsViewController: UIViewController {
    
    private let coverView: UIImageView = {
        let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .redraw
            imageView.alpha = 0.84
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w400/yImmxRokQ48PD49ughXdpKTAsAU.jpg"), completed: nil)
        return imageView
    }()
    
    private let posterView: PosterView = {
        let posterView = PosterView(with: .init(imageUrl: "https://image.tmdb.org/t/p/w500/kTQ3J8oTTKofAVLYnds2cHUz9KO.jpg", ratingText: "8.7 / 10", favouriteIconName: "star-filled"))
            posterView.translatesAutoresizingMaskIntoConstraints = false
        return posterView
    }()
    
    private let tripleLabelView: TripleLabelView = {
        let tripleLabelView = TripleLabelView(with: .init(title: "Rambo", description: "To rekindle their marriages, best friends-turned-in-laws Shanthi and Jennifer plan a couples' getaway. But it comes with all kinds of surprises.", additional: "Release date: August 6, 2009"))
            tripleLabelView.translatesAutoresizingMaskIntoConstraints = false
        return tripleLabelView
    }()
    
    var presenter: MovieDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func configureHierarchy() {
        self.view.addSubview(coverView)
        self.view.addSubview(posterView)
        self.view.addSubview(tripleLabelView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: self.view.topAnchor),
            coverView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            coverView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            coverView.heightAnchor.constraint(equalToConstant: 200),
            
            posterView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Spacing.XL),
            posterView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.72),
            posterView.heightAnchor.constraint(equalTo: self.posterView.widthAnchor, multiplier: 1.3),
            posterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            tripleLabelView.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: Spacing.L),
            tripleLabelView.leftAnchor.constraint(equalTo: posterView.leftAnchor, constant: -Spacing.XXL),
            tripleLabelView.rightAnchor.constraint(equalTo: posterView.rightAnchor, constant: Spacing.XXL),
            
            tripleLabelView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Spacing.XS)
        ])
    }
}

extension MovieDetailsViewController: Configurable {
    static func configured() -> MovieDetailsViewController {
        let controller = MovieDetailsViewController()
        let configurator = MovieDetailsConfiguratorImplementation()
            configurator.configure(controller)
        return controller
    }
}
