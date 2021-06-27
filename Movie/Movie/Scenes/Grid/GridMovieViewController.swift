//
//  GridMovieViewController.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import UIKit
import NotificationBannerSwift
import SDWebImage

protocol GridMovieView: AnyObject {
    func push(controller: UIViewController)
}

class GridMovieViewController: UIViewController {
    private typealias Structure = GridMovieConsts.Structure
    private typealias Metric = GridMovieConsts.Metric
    private typealias Text = GridMovieConsts.Text
    private typealias Color = GridMovieConsts.Color
    
    var gridPresenter: GridMoviePresenter!
    
    private let filterSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: Structure.segmentItems)
            segmentControl.translatesAutoresizingMaskIntoConstraints = false
            segmentControl.heightAnchor.constraint(equalToConstant: Metric.segmentHeight).isActive = true
        return segmentControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: 1, height: 1)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.backgroundColor = .white
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationUI()
        configureHierarchy()
        configureLayout()
        configureCollectionView()
        configureSegment()
        
        self.collectionView.reloadData()
        
        
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        self.collectionView.backgroundColor = .white
    }
    
    private func configureNavigationUI() {
        self.showNavigationBar()
        self.moveViewBelowNavigationBar()
        self.hideBackButton()
        self.set(title: Text.navigationTitle, color: Color.navigationTitleColor)
        self.set(barTintColor: Color.navigationBarTintColor)
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            UINib(nibName: String(describing: GridMovieCollectionViewCell.self), bundle: nil),
            forCellWithReuseIdentifier: String(describing: GridMovieCollectionViewCell.self)
        )
    }
    
    private func configureSegment() {
        filterSegmentControl.addTarget(
            self,
            action: #selector(didChangeSegment(_:)),
            for: .valueChanged
        )
    }
    
    @objc private  func didChangeSegment(_ sender: UISegmentedControl) {
        
    }
    
    private func configureHierarchy() {
        self.view.addSubview(filterSegmentControl)
        self.view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            filterSegmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.M),
            filterSegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Spacing.L),
            filterSegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Spacing.L),
            
            collectionView.topAnchor.constraint(equalTo: filterSegmentControl.bottomAnchor, constant: Spacing.S),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Spacing.M)
        ])
    }
    
    let movies = MovieStore.shared.getAllMovies()
}

extension GridMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: "GridMovieCollectionViewCell", for: indexPath)
        let movie = movies[10*indexPath.section + indexPath.row]
        var url = ImageURLBuilder().withBaseUrl().withSize(.w500).withIdentifier(movie.posterPath ?? "").urlString
        if indexPath.row == 0 || indexPath.row == 6 {
            url = ImageURLBuilder().withBaseUrl().withSize(.w500).withIdentifier(movie.backdropPath ?? "").urlString
        }
        if let view = view as? GridMovieCollectionViewCell {
           
            view.configure(with: url)
        }
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MovieDetailsViewController.configured(), animated: true)
    }
}

extension GridMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        var size = collectionView.frame.width / 3.02
        
        if indexPath.row == 0 || indexPath.row == 6 {
            return .init(width: 2 * size, height: size)
        }
        return .init(width: size, height: size)
    }
}

extension GridMovieViewController: GridMovieView {
    func push(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
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
