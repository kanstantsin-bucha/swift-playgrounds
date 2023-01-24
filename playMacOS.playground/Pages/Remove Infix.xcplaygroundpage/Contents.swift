import UIKit



print("result " + "👲🏾 1 iPhone 👲🏾".trim("iphone", 12))

extension String {
    public func trim(_ component: String, _ maxSize: Int, _ separator: String = " ") -> String {
        let componentsWithoutInfix = components(ignore: component)
        print("componentsWithoutInfix \(componentsWithoutInfix)")
        // Check name capacity without infix
        return componentsWithoutInfix.join(separator, maxSize: 12)
    }

    private func components(ignore: String, _ separatedBy: CharacterSet = .whitespaces) -> [String] {
        let separated = components(separatedBy: separatedBy)
        print("separated \(separated)")
        return separated.compactMap { component in
            guard !component.isEmpty else { return nil }
            print("component " + component)
            guard let range = component.range(of: ignore, options: [.caseInsensitive]) else {
                return component
            }
            var res = component
            res.removeSubrange(range)
            print("res <\(res)>")
            guard !res.isEmpty else { return nil }
            return res
        }
    }
}

extension Array where Element == String {
    func join(_ separator: String, maxSize: Int) -> String {
        var res = ""
        for (index, component) in enumerated() {
            guard !component.isEmpty else { break }
            let item = res + (index == 0 ? "" : separator) + component
            if let itemData = item.data(using: .utf8) {
                if itemData.count > maxSize {
                    if index == 0 {
                        // Trim single component up to available size
                        let data = Data(itemData[0..<maxSize])
                        res = String(data: data, encoding: .utf8) ?? ""
                        break
                    } else {
                        // Use first letter from second component
                        let item = res + separator + String(component[component.startIndex])
                        if let itemData = item.data(using: .utf8) {
                            var data: Data!
                            if itemData.count > maxSize {
                                data = Data(itemData[0..<maxSize])
                            } else {
                                data = itemData
                            }
                            res = String(data: data, encoding: .utf8) ?? res
                            break
                        }
                    }
                } else {
                    // Remain component
                    res = item
                }
            }
        }

        return res
    }
}

extension String {
    func extractFirstItemMatchedBy(pattern: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let results = regex.matches(in: self,
                                        range: NSRange(startIndex..., in: self))

            guard let res = results.first else {
                return nil
            }

            return String(
                self[Range(res.range, in: self)!]
                    .dropLast()
                    .dropFirst()
            )
        } catch {
            print(error)
        }

        return nil
    }
}
