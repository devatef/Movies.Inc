//
//  MovieDetailsViewModel.swift
//  MoviesInc
//
//  Created by Atef on 8/11/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import PromiseKit
import RxSwift
import RxCocoa

class MovieDetailsViewModel {
    
    
    private let disposeBag = DisposeBag()
    private let _actors = BehaviorRelay<[ActorModel]>(value: [])
    private let _geners = BehaviorRelay<[Genres]>(value: [])
    private let _rate = BehaviorRelay<RateModel?>(value: nil)
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var actors: Driver<[ActorModel]> {
        return _actors.asDriver()
    }
    
    var geners: Driver<[Genres]> {
        return _geners.asDriver()
    }
    
    var rate: Driver<RateModel?>{
        return _rate.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    
    var numberOfActors: Int {
        return _actors.value.count
    }
    
    func modelForActor(at index: Int) -> ActorModel? {
        guard index < _actors.value.count else {
            return nil
        }
        return  _actors.value[index]
    }
    
    func fetchMovieDetails(movieId:Int) {
        self._isFetching.accept(true)
        self._error.accept(nil)
        MovieRepo().loadMovieDeatils(movieId: movieId).done {[weak self] movieModel in
            self?._isFetching.accept(false)
            self?._actors.accept(movieModel.credits.cast)
            self?._geners.accept(movieModel.genres)
            
        }.catch{[weak self] error in
            print(error)
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)
        }
        
    }
   
    
    func rateMovie(movieId:Int, rate:Double){
        
         self._isFetching.accept(true)
         self._error.accept(nil)
        
         firstly {
            RateRepo().getGuestSession()
         }.then { (model:GuestSessionModel) in
             RateRepo().rateMovie(movieId: movieId, rate: rate, sessionId: model.guest_session_id)
         }.done {[weak self] (rateModel)  in
             self?._isFetching.accept(false)
             self?._rate.accept(rateModel)
         }.catch {[weak self] (error) in
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)
        }
         
     }
    
}
