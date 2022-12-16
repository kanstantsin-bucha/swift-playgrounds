//
//  UITableView+Cells.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-22.
//

import Foundation
import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}

extension UITableViewCell: Reusable {
    
}

extension UICollectionReusableView: Reusable {
    
}

public extension UITableView {
    
    func registerCells(_ nibNames: [String]) {
        for nibName in nibNames {
            registerCell(nibName)
        }
    }
        
    func registerCell(_ nibName: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func registerCellNib<T: UITableViewCell> (cell: T.Type) {
        register(UINib(nibName: cell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func register<T: UITableViewCell> (cell: T.Type) {
        register(cell.self, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueCell<T: UITableViewCell> (for indexPath: IndexPath, cell: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("dequeueCell error")
        }
        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell> (for indexPath: IndexPath, cell: T.Type = T.self) -> T {
        guard let dequeueCell = dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("dequeueCell error")
        }
        return dequeueCell
    }
}

