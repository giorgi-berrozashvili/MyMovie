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
    func notify(message: String, description: String, type: BannerStyle)
    func notifyGeneralError()
    func push(controller: UIViewController)
    func prepareCollection()
}

final class GridMovieViewController: UIViewController {
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
    
    private let coverView: UIView = {
        let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationUI()
        configureHierarchy()
        configureLayout()
        configureCollectionView()
        configureSegment()
        configureNotification()
        synchronize()
        self.gridPresenter.viewDidLoad()
        
        configureCoverView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.7, animations: {
            self.coverView.alpha = 0
        }, completion: { _ in
            self.coverView.removeFromSuperview()
        })
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
        filterSegmentControl.selectedSegmentIndex = 0
        filterSegmentControl.addTarget(
            self,
            action: #selector(didChangeSegment(_:)),
            for: .valueChanged
        )
    }
    
    @objc private  func didChangeSegment(_ sender: UISegmentedControl) {
        let selected = MovieFilterType(rawValue: sender.selectedSegmentIndex)
    
        if let selected = selected {
            gridPresenter.didChangeFilter(to: selected)
        }
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
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeFavouriteStatus),
                                               name: NSNotification.Name(rawValue: "DidChangeFavouriteStatus"),
                                               object: nil)
    }
    
    @objc private func didChangeFavouriteStatus() {
        self.synchronize()
        self.gridPresenter.refreshData()
    }
    
    private func synchronize() {
        MovieManager.shared.synchronizeFavouriteMovies()
    }
    
    private func configureCoverView() {
        self.view.addSubview(coverView)
        
        coverView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        coverView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        coverView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        coverView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension GridMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gridPresenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridPresenter.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = gridPresenter.item(in: indexPath.section, at: indexPath.item)
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: item.identifier,
            for: indexPath
        )
        
        if let cell = cell as? CollectionCellConfigurable {
            cell.configure(with: item)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.gridPresenter.didSelectItem(in: indexPath.section, at: indexPath.item)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            
            gridPresenter.userDidReachEnd()
        }
    }
}

extension GridMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = gridPresenter.sizeForRect(for: Double(collectionView.frame.width),
                                             in: indexPath.section,
                                             at: indexPath.item)
        
        return CGSize(width: size.width, height: size.height)
    }
}

extension GridMovieViewController: GridMovieView {
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
    
    func push(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func prepareCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension GridMovieViewController: Configurable {
    
    static func configured(with data: String?) -> GridMovieViewController {
        let controller = GridMovieViewController()
        let configurator = GridMovieConfiguratorImplementation()
            configurator.configure(controller)
        return controller
    }
}

extension GridMovieViewController: ViewControllerNavigable { }
