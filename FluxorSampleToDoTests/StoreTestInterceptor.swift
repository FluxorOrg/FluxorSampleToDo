//
//  StoreTestInterceptor.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 04/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Fluxor
@testable import FluxorSampleToDo

class StoreTestInterceptor: StoreInterceptor {
    typealias State = AppState
    private(set) var dispatchedActions = [Action]()

    func actionDispatched(action: Action, newState: AppState) {
        dispatchedActions.append(action)
    }
}
