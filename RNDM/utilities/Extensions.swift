//
//  Extensions.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import Foundation

extension Date {
    func toReadableFormat() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "d MMM, hh:mm"
        return formater.string(from: self)
    }
}
