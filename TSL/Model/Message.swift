//
//  Message.swift
//  TSL
//
//  Created by Chayon Ahmed on 6/24/21.
//  Copyright © 2021 Chayon Ahmed. All rights reserved.
//

import Foundation

struct Message: Codable, Identifiable {
    let id: Int
    let message: String
    let name: String
}
