//
//  GridMovieViewController.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import UIKit
import NotificationBannerSwift

class GridMovieViewController: UIViewController {
    var gridPresenter: GridMoviePresenter!
    
    private let filterSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
            segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.backgroundColor = .white
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GridMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "view")
        self.showNavigationBar()
        self.view.addSubview(collectionView)
        self.configureLayout()
        self.collectionView.reloadData()
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension GridMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "view", for: indexPath)
    }
}

extension GridMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        var size = collectionView.frame.width / 4
        
        if indexPath.row == 0 {
            size = size * 2
        }
        return .init(width: size, height: size)
    }
}

extension GridMovieViewController: Configurable {
    static func configured() -> GridMovieViewController {
        let controller = GridMovieViewController()
        let configurator = GridMovieConfiguratorImplementation()
            configurator.configure(controller)
        return controller
    }
}

extension GridMovieViewController: ViewControllerNavigable { }
