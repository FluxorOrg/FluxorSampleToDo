//
//  Todo.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 24/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Foundation

struct Todo: Encodable, Identifiable, Equatable {
    let id = UUID()
    let title: String
    var done = false
}
