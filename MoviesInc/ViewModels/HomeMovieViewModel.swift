//
//  HomeMovieViewModel.swift
//  MoviesInc
//
//  Created by Atef on 8/10/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift
import RxCocoa

class HomeMoviesViewModel {
    
      
       private let disposeBag = DisposeBag()
       private let _movies = BehaviorRelay<[Movie]>(value: [])
       private let _isFetching = BehaviorRelay<Bool>(value: false)
       private let _error = BehaviorRelay<String?>(value: nil)
       
  
    
       var isFetching: Driver<Bool> {
           return _isFetching.asDriver()
       }
       
       var movies: Driver<[Movie]> {
           return _movies.asDriver()
       }
       
       var error: Driver<String?> {
           return _error.asDriver()
       }
       
       var hasError: Bool {
           return _error.value != nil
       }
      
      
       var numberOfMovies: Int {
           return _movies.value.count
       }
       
       func modelForMovie(at index: Int) -> Movie? {
           guard index < _movies.value.count else {
               return nil
           }
           return  _movies.value[index]
       }
       
     func fetchMovies() {
        self._isFetching.accept(true)
        self._error.accept(nil)
        MovieRepo().loadMovies().done {[weak self] movieModel in
            self?._isFetching.accept(false)
           let resultSorted = movieModel.results.sorted(by: { $0.title < $1.title })
            self?._movies.accept(resultSorted)
        }.catch{[weak self] error in
            print(error)
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)

        }
    
       }
    
    
}
