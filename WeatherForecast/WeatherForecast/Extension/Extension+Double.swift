//
//  GlobalExtension.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 05/06/21.
//

import Foundation



// MARK: - Double Extension
extension Double {
    func roundedString(to digits: Int) -> String {
        String(format: "%.\(digits)f", self)
    }
}
