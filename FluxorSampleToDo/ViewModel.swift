//
//  ViewModel.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 23/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Combine
import Fluxor
import Foundation

class ViewModel<State: Encodable>: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    let store: Store<State>
    private var cancellables = Set<AnyCancellable>()

    init(store: Store<State>) {
        self.store = store
        setupSelectors()
    }

    func setupSelectors() {}

    func bind<V, T>(selector: @escaping ((State) -> T), to keyPath: ReferenceWritableKeyPath<V, T>) throws where V: ViewModel {
        guard let viewModel = self as? V else {
            throw ViewModelError.invalidKeyPath
        }
        store
            .select(selector)
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { _ in self.objectWillChange.send() })
            .assign(to: keyPath, on: viewModel)
            .store(in: &cancellables)
    }
}

enum ViewModelError: Error {
    case invalidKeyPath
}
