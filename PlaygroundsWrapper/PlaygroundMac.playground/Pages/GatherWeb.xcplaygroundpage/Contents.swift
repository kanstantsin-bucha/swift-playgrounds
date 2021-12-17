//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import SwiftSoup

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true

NSSetUncaughtExceptionHandler { exception in
    print("💥 Exception thrown: \(exception)")
}


typealias GatherContentsCompletion = (Result<String, Error>) -> Void
enum GatherError: Error {
    case invalidUrl
    case noData
    case invalidStringData
    case invalidHTML
    case invalidTextMarkup
}

struct PageParser {
    func parse(pageData: Data) throws -> String {
        guard let html = String(data: pageData, encoding: .utf8) else {
            throw GatherError.invalidStringData
        }
        let document = try SwiftSoup.parse(html)
        guard let body = document.body() else {
            throw GatherError.invalidHTML
        }
        let title = try parseHeadline(body: body)
        let chapterText = try parseArticle(body: body)
        return "\n\n" + title + "\n\n" + chapterText
    }
    
    // MARK: - Private methods
    
    private func parseHeadline(body: Element) throws -> String {
        guard let headline = try body.getElementsByAttributeValueContaining("itemprop", "headline").first() else {
            throw GatherError.invalidTextMarkup
        }
        return headline.ownText()
    }
    
    private func parseArticle(body: Element) throws -> String {
        guard let article = try body.getElementById("arrticle") else {
            throw GatherError.invalidTextMarkup
        }
        return try article.text(trimAndNormaliseWhitespace: false)
    }
}

func gather(webPage: String, parser: PageParser, session: URLSession, completion: @escaping GatherContentsCompletion) {
    guard let url = URL(string: webPage) else {
        completion(.failure(GatherError.invalidUrl))
        return
    }
    let urlRequest = URLRequest(url: url)
    let task = session.dataTask(with: urlRequest) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let pageData = data else {
            completion(.failure(GatherError.noData))
            return
        }
        do {
            completion(.success(try parser.parse(pageData: pageData)))
        } catch {
            completion(.failure(error))
        }
        completion
    }
    task.resume()
}
            
let session = URLSession(configuration: .default)
var contents = ""
let firstArticle = 226901
let lastArticle = 226987

var article = firstArticle
while article <= lastArticle {
    let group = DispatchGroup()
    group.enter()
    gather(
        webPage: "https://ranobes.net/read-\(article).html",
        parser: PageParser(),
        session: session
    ) { result in
        switch result {
        case let .success(articleText):
            print("Finished downloading Article: \(article)")
            contents += articleText
            let progress = Double(article - firstArticle + 1) / Double(lastArticle - firstArticle + 1)
            print("Loaded: \(contents.lengthOfBytes(using: .utf8)) Bytes. Progress: \(Int(progress * 100))%")
            
        case let .failure(error):
            print("Got error \(error) for the Article: \(article)")
        }
        print("Pushback interval started for Article: \(article)")
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(10)) {
            print("Pushback interval finished for Article: \(article)")
            group.leave()
        }
    }
    print("Started downloading Article: \(article)")
    group.wait()
    article += 1
}

let fileName = "SealedDivineThrone\(firstArticle)-\(lastArticle).txt"
let directory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
let fileUrl = directory.appendingPathComponent(fileName, isDirectory: false)
print("Loaded total: \(contents.lengthOfBytes(using: .utf8)) Bytes")
print("Will be saved to the file: \(fileUrl)")
do {
    try contents.write(to: fileUrl, atomically: true, encoding: .utf8)
} catch {
    print("Failed write contents to the file: \(error)")
}
print("All Done. Go fun!")
page.finishExecution()

//: [Next](@next)
