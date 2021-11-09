/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import UIKit

class AddTodoViewController: UITableViewController {
    private var store: Store<AppState, AppEnvironment> { TodoApp.store }
    var todoTitle = "" { didSet {
        navigationItem.rightBarButtonItem?.isEnabled = todoTitle.lengthOfBytes(using: .utf8) > 0
    } }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Todo"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(save))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    @objc func cancel() {
        store.dispatch(action: NavigationActions.hideAddSheet())
    }

    @objc func save() {
        store.dispatch(action: HandlingActions.addTodo(payload: todoTitle))
        store.dispatch(action: NavigationActions.hideAddSheet())
    }

    @objc func titleChanged(textField: UITextField) {
        todoTitle = textField.text!
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "TitleCell"
        let textFieldCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
            ?? { () -> UITableViewCell in
                let textField = UITextField()
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.autocorrectionType = .no
                textField.placeholder = "Title"
                textField.addTarget(self, action: #selector(titleChanged(textField:)), for: .editingChanged)
                let cell = UITableViewCell()
                cell.selectionStyle = .none
                cell.contentView.addSubview(textField)
                cell.contentView.addConstraints([
                    textField.leftAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.leftAnchor),
                    textField.rightAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.rightAnchor),
                    textField.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
                ])
                return cell
            }()
        return textFieldCell
    }
}
