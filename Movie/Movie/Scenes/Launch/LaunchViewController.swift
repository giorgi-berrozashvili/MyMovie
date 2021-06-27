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
        
        
        welcomeLabelTopConstraint.constant = 200
        welcomeIconWidthConstraint.constant = 120
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.coverViewWidthConstraint.constant = 2000
            
            UIView.animate(withDuration: 0.8, animations: {
                self.view.layoutIfNeeded()
                self.coverView.layer.cornerRadius = self.coverView.frame.height / 2
                
            }, completion: { _ in
                self.navigationController?.pushViewController(GridMovieViewController.configured(with: nil), animated: false)
                
            })
        })
    }

}

extension LaunchViewController: ViewControllerNavigable { }
