//
//  LaunchViewController.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 22.06.21.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var welcomeLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeIconWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.hideNavigationBar()
        MovieManager.shared.FetchMoreMovies()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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

extension LaunchViewController: ViewControllerNavigable { }
