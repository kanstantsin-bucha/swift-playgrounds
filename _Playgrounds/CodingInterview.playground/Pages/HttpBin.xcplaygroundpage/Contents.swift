//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)


//: [Previous](@previous)

import UIKit

class ViewController: UIViewController {
    private var counter = 0
    let url = URL(string: "https://httpbin.org/get")!
    private var jsonLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(jsonLabel)
        jsonLabel.textColor = .blue
        jsonLabel.translatesAutoresizingMaskIntoConstraints = false
        jsonLabel.text = " Have text "
        jsonLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            jsonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jsonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            jsonLabel.topAnchor.constraint(equalTo: view.topAnchor),
            jsonLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task { @MainActor [weak self] in
            print("start")
            do {
                let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
                print(" got \(data), response: \(response)")
                guard let string =  String(data: data, encoding: .utf8) else { return }
                self?.show(json: string)
            } catch {
                print("got error: \(error)")
            }
        }
    }
    
    private func show(json: String) {
        print(jsonLabel.frame)
        jsonLabel.text = json
    }
}

import PlaygroundSupport
let viewController = ViewController()
viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 600)
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

print("done")
//: [Next](@next)
