/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import UIKit

class TodoListViewController: UICollectionViewController {
    private var store: Store<AppState, AppEnvironment> { TodoApp.store }
    @StoreValue(TodoApp.store, TodosSelectors.getTodos) var todos
    @StoreValue(TodoApp.store, TodosSelectors.isLoadingTodos) var loading
    @StoreValue(TodoApp.store, TodosSelectors.getError) var error
    @StoreValue(TodoApp.store, NavigationSelectors.shoulShowAddShet) var shouldShowAddSheet
    private var cancellables = Set<AnyCancellable>()

    private enum PlaceholderCell: Hashable {
        case loading
        case noTodos
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([0])
        if loading {
            snapshot.appendItems([PlaceholderCell.loading])
        } else if todos.count == 0 {
            snapshot.appendItems([PlaceholderCell.noTodos])
        } else {
            snapshot.appendItems(todos)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fluxor Todos"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(TodoListViewController.addTodo))
        setupCollectionView()
        store.$state
            .receive(on: RunLoop.main) // Wait for the properties to be updated
            .sink(receiveValue: { _ in self.applySnapshot() })
            .store(in: &cancellables)
        $error
            .sink(receiveValue: { error in
                if let error = error {
                    let alertC = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                    alertC.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.store.dispatch(action: FetchingActions.dismissError())
                    }))
                    self.present(alertC, animated: true, completion: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .store(in: &cancellables)
        $shouldShowAddSheet
            .sink { shouldShowAddSheet in
                if shouldShowAddSheet {
                    let addTodoVC = AddTodoViewController(style: .grouped)
                    let navC = UINavigationController(rootViewController: addTodoVC)
                    navC.navigationBar.prefersLargeTitles = true
                    self.present(navC, animated: true, completion: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            .store(in: &cancellables)
        store.dispatch(action: FetchingActions.fetchTodos())
    }

    @objc func addTodo() {
        store.dispatch(action: NavigationActions.showAddSheet())
    }

    override func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard todos.count > 0 else { return }
        let todo = todos[indexPath.row]
        if todo.done {
            store.dispatch(action: HandlingActions.uncompleteTodo(payload: todo))
        } else {
            store.dispatch(action: HandlingActions.completeTodo(payload: todo))
        }
    }

    override func collectionView(_: UICollectionView, shouldHighlightItemAt _: IndexPath) -> Bool {
        todos.count > 0
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, AnyHashable> = {
        let todoCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Todo>(
            handler: { cell, _, todo in
                var content = cell.defaultContentConfiguration()
                content.text = todo.title
                cell.contentConfiguration = content
                if todo.done {
                    cell.accessories = [.checkmark()]
                } else {
                    cell.accessories = []
                }
            })
        let loadingCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Void>(
            handler: { cell, _, _ in
                var content = cell.defaultContentConfiguration()
                content.text = "Loading..."
                cell.contentConfiguration = content
            })
        let noTodosCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Void>(
            handler: { cell, _, _ in
                var content = cell.defaultContentConfiguration()
                content.text = "No todos"
                cell.contentConfiguration = content
            })
        return UICollectionViewDiffableDataSource<Int, AnyHashable>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, hashable -> UICollectionViewCell? in
                if let todo = hashable as? Todo {
                    return collectionView.dequeueConfiguredReusableCell(using:
                        todoCellRegistration, for: indexPath, item: todo)
                } else if let placeholder = hashable as? PlaceholderCell {
                    switch placeholder {
                    case .loading:
                        return collectionView.dequeueConfiguredReusableCell(using:
                            loadingCellRegistration, for: indexPath, item: ())
                    case .noTodos:
                        return collectionView.dequeueConfiguredReusableCell(using:
                            noTodosCellRegistration, for: indexPath, item: ())
                    }
                }
                return nil
            })
    }()

    private func setupCollectionView() {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.trailingSwipeActionsConfigurationProvider = { indexPath in
            .init(actions: [.init(style: .destructive, title: "Delete", handler: { _, _, actionPerformed in
                self.store.dispatch(action: HandlingActions.deleteTodo(payload: indexPath.item))
                actionPerformed(true)
            })])
        }
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.dataSource = dataSource
    }
}
