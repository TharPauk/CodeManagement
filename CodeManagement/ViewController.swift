//
//  ViewController.swift
//  CodeManagement
//
//  Created by Min Thet Maung on 25/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private let upcomingMoviesViewModel = UpcomingMoviesViewModel()
    
    private enum CellTypes: String, CaseIterable {
        case UpcomingMovieCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        upcomingMoviesViewModel.fetchUpcomingMovies()
    }
    
    private func setupTableView() {
        tableView.rowHeight = 216
        
        CellTypes.allCases.forEach {
            let nib = UINib(nibName: $0.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: $0.rawValue)
        }
        
    }
    
    private func bindTableView() {
        upcomingMoviesViewModel.movies.bind(to: tableView.rx.items(cellIdentifier: CellTypes.UpcomingMovieCell.rawValue, cellType: UpcomingMovieCell.self)) { (row, movie, cell) in
            cell.setData(movie: movie)
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Movie.self).bind { [unowned self] movie in
            self.pushToDetailView(movie: movie)
        }.disposed(by: bag)
    }

    private func pushToDetailView(movie: Movie) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailController = storyboard.instantiateViewController(withIdentifier: "MovieDetailController") as! MovieDetailController
        detailController.setData(movie: movie)
        navigationController?.pushViewController(detailController, animated: true)
    }
    

}



//
//extension ViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        216
//    }
//
//
//}
