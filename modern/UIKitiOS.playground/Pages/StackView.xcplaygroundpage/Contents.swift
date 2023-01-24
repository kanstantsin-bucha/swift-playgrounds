//: [Previous](@previous)

import UIKit

var verticalStackView : UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.alignment = .fill
    stackView.spacing = 3.0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
}()

//: [Next](@next)


