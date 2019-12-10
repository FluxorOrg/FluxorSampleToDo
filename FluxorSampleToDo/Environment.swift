//
//  Environment.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 09/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

struct Environment {
    var todoService: TodoServiceProtocol = TodoService()
}

var Current = Environment()
