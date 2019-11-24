//
//  ViewModel.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 23/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Combine
import Fluxor

class ViewModel {
    let objectWillChange = PassthroughSubject<Void, Never>()
    private let store: Store<AppState>
    private var cancellables = Set<AnyCancellable>()

    init(store: Store<AppState>) {
        self.store = store
        setupSelectors()
    }

    func setupSelectors() {}

    func assign<S, T>(selector: @escaping ((AppState) -> T), to keyPath: ReferenceWritableKeyPath<S, T>) {
        guard let viewModel = self as? S else { return }
        store
            .select(selector)
            .handleEvents(receiveOutput: { _ in self.objectWillChange.send() })
            .assign(to: keyPath, on: viewModel)
            .store(in: &cancellables)
    }
}
