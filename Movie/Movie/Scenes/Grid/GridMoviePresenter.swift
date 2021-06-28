//
//  GridMoviePresenter.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

// MARK: - grid presenter declaration
protocol GridMoviePresenter {
    func viewDidLoad()
    func userDidReachEnd()
    func didChangeFilter(to type: MovieFilterType)
    func refreshData()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(in section: Int, at item: Int) -> CollectionCellModel
    func didSelectItem(in section: Int, at index: Int)
    func sizeForRect(for width: Double,
                     in section: Int,
                     at index: Int) -> (width: Double, height: Double)
}

// MARK: - grid presenter implementation
class GridMoviePresenterImplementation {
    // MARK: - properties
    let router: GridMovieRouter
    
    // MARK: - private properties
    private weak var view: GridMovieView?
    private var movieCollectionDataSource: [CollectionCellModel] = []
    private var dataProvider: GridMovieDataProvider {
        didSet {
            prepareCollectionDataSource()
            self.view?.prepareCollection()
        }
    }
    
    // MARK: - initialization
    init(view: GridMovieView,
         router: GridMovieRouter,
         dataProvider: GridMovieDataProvider) {
        
        self.view = view
        self.router = router
        self.dataProvider = dataProvider
    }
}

// MARK: - grid presenter implementation
extension GridMoviePresenterImplementation: GridMoviePresenter {
    func viewDidLoad() {
        if let error = getServiceErrorIfExists() {
            view?.notify(message: "Network error occurred",
                         description: error,
                         type: .danger)
            return
        }
        prepareCollectionDataSource()
        self.view?.prepareCollection()
    }
    
    func userDidReachEnd() {
        MovieManager.shared.FetchMoreMovies { [weak self] in
            MovieManager.shared.FetchMoreMovies { [weak self] in
                self?.prepareCollectionDataSource()
                self?.view?.prepareCollection()
            }
        }
    }
    
    func didChangeFilter(to type: MovieFilterType) {
        switch type {
        case .favourite:
            self.dataProvider = GridMovieFavouriteDataProvider()
        case .popular:
            self.dataProvider = GridMoviePopuparDataProvider()
        case .topRated:
            self.dataProvider = GridMovieTopRatedDataProvider()
        }
    }
    
    func refreshData() {
        prepareCollectionDataSource()
        view?.prepareCollection()
    }
    
    func numberOfSections() -> Int {
        return (movieCollectionDataSource.count / 20) + 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return min(10, movieCollectionDataSource.count)
    }
    
    func item(in section: Int, at item: Int) -> CollectionCellModel {
        let index = section * 10 + item
        return movieCollectionDataSource[index]
    }
    
    func didSelectItem(in section: Int, at index: Int) {
        let index = section * 10 + index
        let item = movieCollectionDataSource[index].domainModel
        if let item = item as? MovieEntityModel {
            self.router.navigateToMovieDetails(with: item)
        }
    }
    
    func sizeForRect(for width: Double,
                     in section: Int,
                     at index: Int) -> (width: Double, height: Double) {
        
        let index = section * 10 + index
        if let item = movieCollectionDataSource[index] as? GridMovieCellModel {
            return getSizeFor(width: width, isBackDropped: item.isBackdropped)
        }
        
        return getSizeFor(width: width, isBackDropped: false)
    }
}

// MARK: - helper methods for implementation
extension GridMoviePresenterImplementation {
    private func prepareCollectionDataSource() {
        movieCollectionDataSource = dataProvider
            .getData()
            .enumerated()
            .map { (index, item) in
                return GridMovieCellModel(
                    isBackdropped: self.isBackDropped(index: index),
                    domainModel: item
                )
            }
    }
    
    private func isBackDropped(index: Int) -> Bool {
        return index % 10 == 0 || index % 10 == 6
    }
    
    private func getSizeFor(width: Double, isBackDropped: Bool) -> (width: Double, height: Double) {
        let size = width / 3.02
        
        return isBackDropped ? (width: size * 2, height: size)
                             : (width: size, height: size)
    }
    
    private func getServiceErrorIfExists() -> String? {
        return MovieManager.shared.getErrorMessageIfExists()
    }
}
