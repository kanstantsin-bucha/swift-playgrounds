//: [Previous](@previous)

import Foundation

import UIKit

struct Item {
    let isTwoLines: Bool
    
    init(isTwoLines: Bool = false) {
        self.isTwoLines = isTwoLines
    }
}

class MyViewController: UIViewController {
    
    private let tableView = UITableView()
    private var counter = 0
    private let items = [
        Item(),
        Item(isTwoLines: true),
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
        Item()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        tableView.estimatedRowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = . green
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "one") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "one")
        }
        
        let item = items[indexPath.row]
        cell.contentView.backgroundColor = item.isTwoLines ? .red : .yellow
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        counter += 1
        print("heightForRowAt \(counter)")
        let item = items[indexPath.row]
        return item.isTwoLines ? 250 : 200
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let item = items[indexPath.row]
//        return item.isTwoLines ? 220 : 200
//    }
}

import PlaygroundSupport

PlaygroundSupport.PlaygroundPage.current.liveView = MyViewController()
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
