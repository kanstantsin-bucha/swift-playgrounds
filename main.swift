import Foundation

var url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
url.deleteLastPathComponent()
print(url)
