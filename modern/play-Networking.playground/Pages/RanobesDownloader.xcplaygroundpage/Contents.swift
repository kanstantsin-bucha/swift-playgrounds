//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import SwiftSoup

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true

NSSetUncaughtExceptionHandler { exception in
    print("💥 Exception thrown: \(exception)")
}

struct Article {
    let chapter: UInt
    let index: UInt
}

struct Ranobe {
    static let greatMageReturns = Ranobe(
        title: "TheGreatMageReturnsAfter4000_Book_1",
        firstArticle: Article(chapter: 201, index: 1395059),
        lastArticle: Article(chapter: 239, index: 1395097)
    )
    static let darkMagicianTransmigrates = Ranobe(
        title: "TheDarkMagicianTransmigratesAfter66666Years",
        firstArticle: Article(chapter: 101, index: 1621218),
        lastArticle: Article(chapter: 200, index: 1621317)
    )
    static let swallowedStar = Ranobe(
        title: "SwallowedStar",
        firstArticle: Article(chapter: 51, index: 52258),
        lastArticle: Article(chapter: 150, index: 52408)
    )
    static let aPowerInTheShadows = Ranobe(
        title: "ToBeaPowerInTheShadows",
        firstArticle: Article(chapter: 1, index: 926257),
        lastArticle: Article(chapter: 203, index: 926459)
    )

    let title: String
    let firstArticle: Article
    let lastArticle: Article
}

typealias GatherContentsCompletion = (Result<String, Error>) -> Void
enum GatherError: Error {
    case invalidUrl
    case noData
    case invalidStringData
    case invalidHTML
    case invalidTextMarkup(description: String)
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
            throw GatherError.invalidTextMarkup(description: "No headline")
        }
        return headline.ownText()
    }
    
    private func parseArticle(body: Element) throws -> String {
        // Do not change "arrticle" - this is the way it the site has this tag
        guard let article = try body.getElementById("arrticle") else {
            print(body)
            throw GatherError.invalidTextMarkup(description: "No article")
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
            
let ranobe = Ranobe.aPowerInTheShadows
let session = URLSession(configuration: .default)
var contents = ""

var article = ranobe.firstArticle.index
var chapterIndex = ranobe.firstArticle.chapter
while article <= ranobe.lastArticle.index {
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
            contents += "\n\nChapter \(chapterIndex)\n"
            contents += articleText
            let iterationsTotal = Double(ranobe.lastArticle.index - ranobe.firstArticle.index + 1)
            let iterationsPassed = Double(article - ranobe.firstArticle.index + 1)
            let progress = iterationsPassed / iterationsTotal
            print("Loaded: \(contents.lengthOfBytes(using: .utf8)) Bytes. Progress: \(Int(progress * 100))%")
            
        case let .failure(error):
            print("Got error \(error) for the Article: \(article)")
        }
        print("Pushback interval started for Article: \(article)")
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            print("Pushback interval finished for Article: \(article)")
            group.leave()
        }
    }
    print("Started downloading Article: \(article)")
    group.wait()
    article += 1
    chapterIndex += 1
}

let fileName = "\(ranobe.title)-(\(ranobe.firstArticle.chapter)-\(ranobe.lastArticle.chapter)).txt"
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
print("to convert into modi use https://ebook.online-convert.com/convert-to-mobi")
page.finishExecution()

//: [Next](@next)
