//
//  MovieDetailsViewController.swift
//  MoviesInc
//
//  Created by Atef on 8/10/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import Cosmos
import RxSwift
import RxCocoa
import PKHUD
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieStarCollectionView: UICollectionView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var cosmosViewRatingView: CosmosView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    var movieModel:Movie?
    
    var movieDetailsViewModel: MovieDetailsViewModel!
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRatingView()
        setupMovieViewModel()
        fillUI()
        fetchMovieDetails()
    }
    
    func fillUI()  {
        self.title = movieModel?.title
        ratingLabel.text = "\(movieModel?.vote_average ?? 0 )"
        posterImageView.kf.setImage(with: URL(string:movieModel!.getLargeImageUrl() ), placeholder: UIImage(named: "default"))
        overviewLabel.text = movieModel?.overview
        releaseYearLabel.text = movieModel?.release_date.components(separatedBy: "-").first
    }
    
    
    func configureRatingView() {
        cosmosViewRatingView.rating = (movieModel?.vote_average ?? 0)/2
        cosmosViewRatingView.didFinishTouchingCosmos = {[weak self] rating in
            let rate = rating * 2
            guard rate >= 0.5 && rate <= 10 else {
                HUD.show(HUDContentType.labeledError(title: "rating between 0.5 and 5", subtitle: ""))
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    HUD.hide()
                }
                return
                
            }
            self?.movieDetailsViewModel.rateMovie(movieId: self?.movieModel?.id ?? -1, rate: rate)
        }
    }
    
    private func fetchMovieDetails(){
        movieDetailsViewModel.fetchMovieDetails(movieId: movieModel?.id ?? 0)
    }
    
    private func setupMovieViewModel(){
        
        movieDetailsViewModel = MovieDetailsViewModel()
        
        movieDetailsViewModel.actors.drive(onNext: {[unowned self] (_) in
            self.movieStarCollectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                HUD.hide()
            }
        }).disposed(by: disposeBag)
        
        movieDetailsViewModel.geners.drive(onNext: {[weak self] genrs in
            let genrs = genrs.map{$0.name}.joined(separator: "\n •  ")
            self?.overviewLabel.text! += "\n\n •  "+genrs
        }).disposed(by: disposeBag)
        
        movieDetailsViewModel.error.drive(onNext: {[unowned self] (error) in
            if(self.movieDetailsViewModel.hasError) {
                HUD.show(HUDContentType.labeledError(title: error, subtitle: ""))
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                HUD.hide()
            }
        }).disposed(by: disposeBag)
        
        movieDetailsViewModel.rate.drive(onNext: { (rate) in
            guard rate != nil , rate?.status_code == 1 else { return}
            HUD.show(HUDContentType.success)
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                HUD.hide()
            }
        }).disposed(by: disposeBag)
        
        movieDetailsViewModel.isFetching.drive(onNext:{(isLoading) in
            isLoading ? HUD.show(.progress) : HUD.hide()
        }).disposed(by: disposeBag)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MovieDetailsViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetailsViewModel.numberOfActors
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ActorCell =  collectionView.dequeueReusableCell(withReuseIdentifier: ActorCell.identifier, for: indexPath) as! ActorCell
        
        if let model = movieDetailsViewModel.modelForActor(at: indexPath.item){
            cell.configureCellWith(actor:model)
        }
        
        return cell
    }
    
    
}
