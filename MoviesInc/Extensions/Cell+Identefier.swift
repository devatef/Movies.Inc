//
//  Cell+Identefier.swift
//  MoviesInc
//
//  Created by Atef on 8/10/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import UIKit
extension UITableViewCell{
    
    static var nib:UINib {
            return UINib(nibName: identifier, bundle: nil)
        }

}

extension UIView{
    static var identifier: String {
               return String(describing: self)
           }
}
