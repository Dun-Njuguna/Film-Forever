//
//  Extensions.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import Foundation


extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
