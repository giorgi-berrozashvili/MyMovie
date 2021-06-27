//
//  UIViewControllerNavigable.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit

protocol ViewControllerNavigable: UIViewController {
    func hideNavigationBar()
    func showNavigationBar()
    func moveViewBelowNavigationBar()
    func moveViewBehindNavigationBar()
    func hideBackButton()
    func showBackButton()
    func set(title: String, color: UIColor)
    func set(barTintColor: UIColor)
}

extension ViewControllerNavigable {
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func moveViewBelowNavigationBar() {
        self.edgesForExtendedLayout = []
    }
    
    func moveViewBehindNavigationBar() {
        self.edgesForExtendedLayout = .all
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func showBackButton() {
        self.navigationItem.hidesBackButton = false
    }
    
    func set(title: String, color: UIColor) {
        let label = UILabel()
            label.text = title
            label.textColor = color
            label.font = .boldSystemFont(ofSize: 18)
        
        self.navigationItem.titleView = label
    }
    
    func set(barTintColor: UIColor) {
        self.navigationController?.navigationBar.barTintColor = barTintColor
    }
}
