//
//  ViewController.swift
//  MoviesInc
//
//  Created by Atef on 8/9/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

class HomeMovieViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var homeMovieViewModel: HomeMoviesViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMovieViewModel()
        setupTableView()
        fetchMovies()
    }
    
    
    private func fetchMovies(){
        homeMovieViewModel.fetchMovies()
    }
    
    private func setupMovieViewModel(){
        
        homeMovieViewModel = HomeMoviesViewModel()
        
        homeMovieViewModel.movies.drive(onNext: {[unowned self] (_) in
            self.moviesTableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                HUD.hide()
            }
        }).disposed(by: disposeBag)
        
        
        homeMovieViewModel.error.drive(onNext: {[unowned self] (error) in
            self.infoLabel.isHidden = !self.homeMovieViewModel.hasError
            if(self.homeMovieViewModel.hasError) {HUD.hide()}
            self.infoLabel.text = error
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.infoLabel.isHidden = true
            }
        }).disposed(by: disposeBag)
        
        
        homeMovieViewModel.isFetching.drive(onNext:{(isLoading) in
            isLoading ? HUD.show(.progress) : HUD.hide()
        }).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        moviesTableView.rowHeight = 100
        moviesTableView?.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
    }
    
    
}

extension HomeMovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeMovieViewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        if let model = homeMovieViewModel.modelForMovie(at: indexPath.row) {
            cell.configureWith(item: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieDetailsViewController.self)) as! MovieDetailsViewController
        
        if let model = homeMovieViewModel.modelForMovie(at: indexPath.row) {
            details.movieModel = model
        }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}
