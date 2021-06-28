//
//  LaunchViewController.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 22.06.21.
//

import UIKit

// MARK: - launch screen controller declaration
class LaunchViewController: UIViewController {

    // MARK: - outlets
    @IBOutlet weak var welcomeLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeIconWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverView: UIView!
    
    // MARK: - view life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        prepareNavigationUI()
        fetchMoreMoviesForFuture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animate()
    }
    
    // MARK: - private helper methods
    private func prepareNavigationUI() {
        self.hideNavigationBar()
    }
    
    private func fetchMoreMoviesForFuture() {
        MovieManager.shared.FetchMoreMovies()
    }
    
    private func animate() {
        UIView.animateKeyframes(
            withDuration: 2,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                
                self.welcomeLabelTopConstraint.constant = 260
                self.welcomeIconWidthConstraint.constant = 180
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                    self.view.layoutIfNeeded()
                }
                
                self.coverViewWidthConstraint.constant = 2000
                UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                    self.view.layoutIfNeeded()
                    self.coverView.layer.cornerRadius = self.coverView.frame.height / 2
                }
            },
            completion: { _ in
                self.navigationController?.pushViewController(
                    GridMovieViewController.configured(with: nil),
                    animated: false
                )
            }
        )
    }
}

// MARK: - navigable implementation
extension LaunchViewController: ViewControllerNavigable { }
