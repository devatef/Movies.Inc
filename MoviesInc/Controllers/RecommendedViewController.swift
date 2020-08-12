//
//  RecommendedViewController.swift
//  MoviesInc
//
//  Created by Atef on 8/12/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit

class RecommendedViewController: HomeMovieViewController {

    var movieId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recommended Movies"

        // Do any additional setup after loading the view.
    }
    
    override func fetchMovies() {
        
        homeMovieViewModel.fetchRecommendedMovies(movieId: movieId ?? 0)
          
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
