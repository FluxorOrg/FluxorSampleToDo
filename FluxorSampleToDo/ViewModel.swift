//
//  ViewModel.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 08/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Fluxor

class ViewModel {
    let store: Store<AppState>

    init(store: Store<AppState>) {
        self.store = store
    }
}
