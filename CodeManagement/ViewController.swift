//
//  ViewController.swift
//  CodeManagement
//
//  Created by Min Thet Maung on 25/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var movies = [Movie]()
    private enum CellTypes: String, CaseIterable {
        case UpcomingMovieCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUpcomingMovies()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        CellTypes.allCases.forEach {
            let nib = UINib(nibName: $0.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: $0.rawValue)
        }
    }

    
    private func fetchUpcomingMovies() {
        ApiService.shared.get(.upcoming, UpcomingMovieResponse.self) { [unowned self] result in
            switch result {
            case .success(let response):
                self.movies = response.results ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print("Errror in fetching upcoming movies: \(error.localizedDescription)")
            }
        }
    }
    

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellTypes.UpcomingMovieCell.rawValue, for: indexPath) as? UpcomingMovieCell
        else { return UITableViewCell() }
        cell.setData(movie: movies[indexPath.row])
        return cell
    }
    
}



extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        216
    }
    
    
}
