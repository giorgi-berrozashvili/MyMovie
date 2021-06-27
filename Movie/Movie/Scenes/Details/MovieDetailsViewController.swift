//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit
import NotificationBannerSwift

protocol MovieDetailsView: AnyObject {
    func notify(message: String, description: String, type: BannerStyle)
    func notifyGeneralError()
    func refreshPosterView()
}

final class MovieDetailsViewController: UIViewController {
    private let coverView: UIImageView = {
        let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .redraw
            imageView.alpha = 0.84
        return imageView
    }()
    
    private let posterView: PosterView = {
        let posterView = PosterView()
            posterView.translatesAutoresizingMaskIntoConstraints = false
        return posterView
    }()
    
    private let tripleLabelView: TripleLabelView = {
        let tripleLabelView = TripleLabelView()
            tripleLabelView.translatesAutoresizingMaskIntoConstraints = false
        return tripleLabelView
    }()
    
    var presenter: MovieDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViews()
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configureFavouriteButton()
        configureTitle()
        
        presenter.viewDidLoad()
    }
    
    private func configureTitle() {
        self.set(title: presenter.getTitle() ?? "", color: .white)
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func configureViews() {
        coverView.sd_setImage(with: URL(string: presenter.getBackdropImageString()), completed: nil)
        posterView.configure(with: presenter.getPosterModel())
        tripleLabelView.configure(with: presenter.getTripleLabelModel())
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
    
    private func configureFavouriteButton() {
        self.posterView.delegate = self
    }
}

extension MovieDetailsViewController: Configurable {
    static func configured(with data: MovieEntityModel?) -> MovieDetailsViewController {
        let controller = MovieDetailsViewController()
        let configurator = MovieDetailsConfiguratorImplementation()
        configurator.configure(controller, model: data)
        return controller
    }
}

extension MovieDetailsViewController: MovieDetailsView {
    func notify(message: String, description: String, type: BannerStyle) {
        DispatchQueue.main.async {
            NotificationBanner(
                title: message,
                subtitle: description,
                style: type
            ).show()
        }
    }
    
    func notifyGeneralError() {
        DispatchQueue.main.async {
            NotificationBanner(
                title: "Error occurred",
                subtitle: "Sorry for inconvenience",
                style: .danger
            ).show()
        }
    }
    
    func refreshPosterView() {
        DispatchQueue.main.async {
            self.posterView.configure(with: self.presenter.getPosterModel())
        }
    }
}

extension MovieDetailsViewController: PosterViewDelegate {
    func posterView(_ posterView: PosterView, didTapButton button: UIButton) {
        self.presenter.didTapFavouriteButton()
    }
}

extension MovieDetailsViewController: ViewControllerNavigable { }
