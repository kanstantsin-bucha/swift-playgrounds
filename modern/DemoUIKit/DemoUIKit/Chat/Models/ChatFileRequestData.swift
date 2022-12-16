//
//  ChatFileRequestData.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-23.
//

import Foundation

struct ChatFileRequestData: Codable {
    let id: String
    let type: String
    let roomId: String
    let userName: String
    let encryptedFileLocation: String
}

struct ChatFileResponse: Codable {
    let ok: Bool
    let fileLocation: String
}

extension ChatFileRequestData {
    static var mockDict: [String: Any] {
        return ["id": "111111111",
                "type": "",
                "roomId": "3333333",
                "userName": "Andrei",
                "encryptedFileLocation": "asdadkaskdhakjshdjkahsd"]
    }
}

extension ChatFileResponse {
    static var mockDictSuccess: [String: Any] {
        return ["ok": 1,
                "encryptedFileLocation": "http://fileUrl.com"]
    }
}
