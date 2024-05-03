//
//  Item.swift
//  demo
//
//  Created by Steam Apple on 5/2/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
