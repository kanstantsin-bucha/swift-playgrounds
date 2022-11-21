//: [Previous](@previous)

import UIKit

class ViewController: UIViewController {
    private var counter = 0
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .black
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.contentInset = .zero
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .purple
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.backgroundColor = .brown
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // Using Content view
        
//        scrollView.addSubview(contentView)
//        NSLayoutConstraint.activate([
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ])
    
//        contentView.addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//        ])
        
        
        // Using No Content view
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        addView(size: .init(width: 100, height: 300), color: .red) { stackView.addArrangedSubview($0) }
        addView(size: .init(width: 100, height: 300), color: .yellow) { stackView.addArrangedSubview($0) }
        addView(size: .init(width: 100, height: 300), color: .green) { stackView.addArrangedSubview($0) }
        
        print("Loaded")
    }
    
    private func addView(size: CGSize, color: UIColor, addClosure: (UIView) -> Void) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        addClosure(view)
        view.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        view.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("did appear")
        
        print("view", view.frame)
        print("scroll view", scrollView.frame,  scrollView.contentSize)
        print("content view", contentView.frame)
        print("stack view", stackView.frame, stackView.subviews)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.scrollView.scrollRectToVisible(
                CGRect(x: 0, y: 600, width: self.scrollView.contentSize.width, height: 100),
                animated: true
            )
            print("scrolled")
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        counter += 1
        print("dragging", counter)
    }
}

import PlaygroundSupport
let viewController = ViewController()
viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 600)
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

print("done")
//: [Next](@next)
