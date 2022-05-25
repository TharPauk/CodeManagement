//
//  UpcomingMoviesViewModel.swift
//  CodeManagement
//
//  Created by Min Thet Maung on 25/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

class UpcomingMoviesViewModel {
    
    var movies = PublishSubject<[Movie]>()
    
    func fetchUpcomingMovies() {
        ApiService.shared.get(.upcoming, UpcomingMovieResponse.self) { [unowned self] result in
            
            switch result {
            case .success(let response):
                self.movies.onNext(response.results ?? [])
                self.movies.onCompleted()
            case .failure(let error):
                print("Errror in fetching upcoming movies: \(error.localizedDescription)")
                self.movies.onError(error)
            }
        }
    }

    
}
