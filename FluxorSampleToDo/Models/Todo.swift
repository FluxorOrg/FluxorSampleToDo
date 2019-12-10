//
//  Todo.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 24/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Foundation

struct Todo: Codable, Identifiable, Equatable {
    let id: UUID
    let title: String
    var done = false
    
    init(title: String) {
        id = UUID()
        self.title = title
    }
}
