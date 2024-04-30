//
//  Item.swift
//  Eventbrite
//
//  Created by Steam Apple on 4/26/24.
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
