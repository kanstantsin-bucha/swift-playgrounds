//
//  ViewController.swift
//  UIKit
//
//  Created by Andrei Kasykhin on 2022-11-22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var models = [
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "L", isFile: false),
        ViewController.createModel(text: "Long message here to layout", name: "Bill", chatName: "L", isFile: false),
        ViewController.createModel(text: "Similar message That Max", name: "Mike", chatName: "Other", isFile: true),
        ViewController.createModel(text: "Long message here to layout", name: "Bill From New York", chatName: "Long name to show", isFile: false),
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "Cousine", isFile: false),
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "Long name to show", isFile: false),
        ViewController.createModel(text: "Long message here to layout", name: "Bill", chatName: "L", isFile: false),
        ViewController.createModel(text: "Similar message 5 That Max", name: "Mike", chatName: "Other", isFile: true),
        ViewController.createModel(text: "Long message here to layout", name: "Bill From New York", chatName: "Long name to show", isFile: false),
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "Cousine", isFile: false),
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "Long name to show", isFile: false),
        ViewController.createModel(text: "Long message here to layout", name: "Bill", chatName: "L", isFile: false),
        ViewController.createModel(text: "Similar message", name: "Mike", chatName: "Other", isFile: true),
        ViewController.createModel(text: "Long message here to layout", name: "Bill From New York", chatName: "Long name to show", isFile: false),
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "Cousine", isFile: false),
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "L", isFile: false),
        ViewController.createModel(text: "Long message here to layout", name: "Bill", chatName: "L", isFile: false),
        ViewController.createModel(text: "Similar message That Max", name: "Mike", chatName: "Other", isFile: true),
        ViewController.createModel(text: "Long message here to layout", name: "Bill From New York", chatName: "Long name to show", isFile: false),
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "Cousine", isFile: false),
        ViewController.createModel(text: "Ok", name: "Mike", chatName: "Long name to show", isFile: false, isNamed: false),
        ViewController.createModel(text: "Long message here to layout", name: "Bill", chatName: "L", isFile: false, isNamed: false),
        ViewController.createModel(text: "Similar message 5 That Max", name: "Mike", chatName: "Other", isFile: true, isNamed: false),
        ViewController.createModel(text: "Long message here to layout", name: "Bill From New York", chatName: "Long name to show", isFile: false, isNamed: false),
        ViewController.createModel(text: "Ok aaaaaa", name: "Mike", chatName: "Cousine", isFile: false, isNamed: false),
        ViewController.createModel(text: "Ok aaa", name: "Mike", chatName: "Long name to show", isFile: false, isNamed: false),
        ViewController.createModel(text: "Long message here to layout", name: "Bill", chatName: "L", isFile: false, isNamed: false),
        ViewController.createModel(text: "Similar message", name: "Mike", chatName: "Other", isFile: true, isNamed: false),
        ViewController.createModel(text: "Long message here to layout", name: "Bill From New York", chatName: "Long name to show", isFile: false, isNamed: false),
        ViewController.createModel(text: "Ok aa", name: "Mike", chatName: "Cousine", isFile: false, isNamed: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 200;
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 =  tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        let cell = cell1 as! ChatMessageTableViewCell
        cell.messageView.setUp(
            model: models[indexPath.row],
            layout: indexPath.row % 2 == 0 ? .leading : .trailing,
            heightAnimationClosure: { [weak self, weak cell] layoutChange in
                UIView.animate(withDuration: 0.3, animations: {
                    layoutChange()
                    cell?.contentView.layoutIfNeeded()
                    self?.tableView.beginUpdates()
                    self?.tableView.endUpdates()
                })
            }
        )
        return cell
    }
    
    private static func createModel(text: String, name: String, chatName: String, isFile: Bool = false, isNamed: Bool = true) -> ChatMessageModel {
        ChatMessageModel(
            id: UUID().uuidString,
            roomId: UUID().uuidString,
            userName: UUID().uuidString,
            authorName: name,
            target: ChatMessageTarget(name: chatName, user: "Chat User", roomId: UUID().uuidString),
            type: isNamed ? "Named" : "",
            subType: "",
            text: text,
            anonymous: false,
            photo: "",
            vtgId: 5,
            when: "12:00",
            lastEdited: "13:00",
            reactions: [],
            threadInfo: ChatMessageThreadInfo(isAnonymous: false),
            edited: false,
            file: isFile,
            stars: []
        )
    }
}

