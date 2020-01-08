/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import UIKit

class TodoListViewController: UITableViewController {
    let model = TodoListViewModel()
    var todos = [Todo]() { didSet { reloadSection() } }
    var loading = false { didSet { reloadSection() } }
    var error: String? { didSet { if error != nil { showErrorAlert() } } }
    var cancellables = [AnyCancellable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fluxor todos"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(TodoListViewController.addTodo))
        cancellables.append(contentsOf: [
            model.store.select(Selectors.getTodos).sink(receiveValue: { self.todos = $0 }),
            model.store.select(Selectors.isLoadingTodos).sink(receiveValue: { self.loading = $0 }),
            model.store.select(Selectors.getError).sink(receiveValue: { self.error = $0 }),
        ])
        model.fetchTodos()
    }

    func reloadSection() {
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
    }

    func showErrorAlert() {
        let alertC = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertC.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertC.dismiss(animated: true, completion: nil)
        }))
        present(alertC, animated: true, completion: nil)
    }

    @objc func addTodo() {
        let addTodoVC = AddTodoViewController(style: .grouped)
        let navC = UINavigationController(rootViewController: addTodoVC)
        navC.navigationBar.prefersLargeTitles = true
        present(navC, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading || todos.count == 0 { return 1 }
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !loading else { return createLoadingCell() }
        guard todos.count > 0 else { return createNoTodosCell() }

        let todo = todos[indexPath.row]
        let reuseIdentifier = "TodoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
            ?? UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = todo.title
        cell.accessoryType = todo.done ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard todos.count > 0 else { return }
        let todo = todos[indexPath.row]
        model.toggle(todo: todo)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.delete(at: indexPath.row)
        }
    }
}

extension TodoListViewController {
    private func createLoadingCell() -> UITableViewCell {
        let reuseIdentifier = "LoadingCell"
        let loadingCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? { () -> UITableViewCell in
            let spinner = UIActivityIndicatorView()
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.color = .black
            spinner.startAnimating()
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.text = "Loading todos..."
            let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
            cell.selectionStyle = .none
            cell.contentView.addSubview(spinner)
            cell.contentView.addSubview(titleLabel)
            cell.contentView.addConstraints([
                spinner.leftAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.leftAnchor),
                spinner.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                titleLabel.leftAnchor.constraint(equalTo: spinner.rightAnchor, constant: 8),
                titleLabel.centerYAnchor.constraint(equalTo: spinner.centerYAnchor),
            ])
            return cell
        }()
        return loadingCell
    }

    private func createNoTodosCell() -> UITableViewCell {
        let reuseIdentifier = "NoTodosCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
            ?? UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = "No todos"
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
}
