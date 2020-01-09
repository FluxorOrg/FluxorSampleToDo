/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import UIKit

class AddTodoViewController: UITableViewController {
    let model = AddTodoViewModel()
    var todoTitle = "" { didSet { saveButton.isEnabled = todoTitle.lengthOfBytes(using: .utf8) > 0 } }
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Todo"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = saveButton
        saveButton.isEnabled = false
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        model.addTodo(title: todoTitle)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func titleChanged(textField: UITextField) {
        todoTitle = textField.text!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
