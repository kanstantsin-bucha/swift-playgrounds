//: [Previous](@previous)

import UIKit
import PlaygroundSupport

class Persistence {
    private(set) var items = ["Hi!", "Ola", "Privet"]
    var reloadSignal: (() -> Void)?

    private var index = 0

    // Temporary solution to imitate updates
    var timer: Timer?

    func delete(item: String) {
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
        reloadSignal?()
        startTimer()
    }

    func add(item: String) {
        print("add")
        items.append(item)
        reloadSignal?()
    }

    // Temporary solution to imitate updates
    private func startTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.5,
            repeats: true
        ) { [weak self] _ in
            guard let self = self else { return }
            self.add(item: "test \(self.index)")
            self.index += 1
            print("timer")
        }
    }
}

protocol ItemActionsProviding {
    func itemAndActions(indexPath: IndexPath) -> (String, () -> Void, () -> Void)
}

typealias ActionsCellProvider = (
    _ indexPath: IndexPath,
    _ item: String,
    _ approve: @escaping () -> Void,
    _ reject: @escaping () -> Void
) -> UITableViewCell

class DataProvider: NSObject, UITableViewDataSource {
    // TODO: start updates
    // create a snapshot of data
    // apply updates
    // TODO: end updates
    // check if snapshot equal to real data
    // after a while replace snapshot with the data and post reload signal

    let persistance: Persistence
    var cellProvider: ActionsCellProvider = {_, _, _, _ in return UITableViewCell() }

    var reloadSignal: (() -> Void)?
    private(set) var isUpdatesInProgress = false

    private var items: [String] {
        return isUpdatesInProgress ? snapshot : persistance.items
    }
    private var snapshot: [String] = []

    init(persistance: Persistence) {
        self.persistance = persistance
        super.init()

        persistance.reloadSignal = { [weak self] in
            self?.reload()
        }
    }

    func beginUpdates() {
        snapshot = persistance.items
        isUpdatesInProgress = true
    }

    func endUpdates() {
        isUpdatesInProgress = false
        if snapshot != items {
            reloadSignal?()
        }
        snapshot = []
    }

    func reload() {
        guard !isUpdatesInProgress else { return }
        reloadSignal?()
    }

    // MARK: - DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persistance.items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let item = self.persistance.items[indexPath.row]
        let cell = cellProvider(
            indexPath,
            item,
            { [weak self] in
                // here we should call interactor
                print("Approve \(item)")
                self?.persistance.delete(item: item)
                guard let index = self?.snapshot.firstIndex(of: item) else { return }
                self?.snapshot.remove(at: index)
            },
            { [weak self] in
                // here we should call interactor
                print("Reject \(item)")
                self?.persistance.delete(item: item)
                guard let index = self?.snapshot.firstIndex(of: item) else { return }
                self?.snapshot.remove(at: index)
            }
        )
        return cell
    }
}

class ViewController: UIViewController {
    var tableView: UITableView?
    var dataProvider: DataProvider!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView!.dataSource = dataProvider
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        self.view.leadingAnchor.constraint(
            equalTo: self.tableView!.leadingAnchor
        ).isActive = true
        self.view.trailingAnchor.constraint(
            equalTo: self.tableView!.trailingAnchor
        ).isActive = true
        self.view.topAnchor.constraint(
            equalTo: self.tableView!.topAnchor
        ).isActive = true
        self.view.bottomAnchor.constraint(
            equalTo: self.tableView!.bottomAnchor
        ).isActive = true
    }
    override func viewDidLayoutSubviews() {
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
    }
}

func makeButton(x: Int, title: String, action: @escaping () -> Void) -> UIButton {
    let button = UIButton(frame: CGRect(x: x, y: 10, width: 100, height: 20))
    button.setTitle(title, for: .normal)
    button.setTitleColor(.red, for: .normal)
    button.addAction(.init(handler: { _ in
        action()
    }), for: .touchUpInside)
    return button
}

let controller = ViewController()
controller.dataProvider = DataProvider(persistance: Persistence())

controller.dataProvider.reloadSignal = { [weak controller] in
    controller?.tableView!.reloadData()
}
controller.dataProvider.cellProvider = { indexPath, item, approve, reject in
    let cell = controller.tableView!.dequeueReusableCell(
        withIdentifier: "cell",
        for: indexPath
    )
    cell.textLabel?.text = item

    cell.contentView.addSubview(
        makeButton(
            x: 100,
            title: "approve",
            action: { [weak controller] in
                controller?.dataProvider.beginUpdates()
                controller?.tableView!.beginUpdates()
                approve()
                controller?.tableView!.deleteRows(at: [indexPath], with: .right)
                controller?.tableView!.endUpdates()
                controller?.dataProvider.endUpdates()
            }
        )
    )
    cell.contentView.addSubview(makeButton(x: 200, title: "reject", action: reject))

    return cell
}

PlaygroundPage.current.liveView = controller

//: [Next](@next)


//: [Next](@next)
