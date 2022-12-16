//
//  ChatMessageModel.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-22.
//

import Foundation

let currentUserEmail = "currentUserEmail@test.com"

fileprivate let dateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    return formatter
}()

struct ChatMessageModel {
    var id: String
    var roomId: String
    var userName: String // To Name
    var authorName: String // Name
    
    var target: ChatMessageTarget // Message Text
    
    var type: String // Content
    var subType: String // Content
    
    var fileInfo: ChatMessageFile?
    
    var text: String
    var anonymous: Bool
    var photo: String
    var vtgId: Int
    var when: String
    var lastEdited: String
    var reactions: [MessageReaction] // Reactions
    var threadInfo: ChatMessageThreadInfo // 
    
    var edited: Bool
    var file: Bool
    var stars: [String]
    
    // custom properties
    var isRead: Bool = false
    
    init(dict: [String: Any]) {
        let idString = dict[ "id" ] as? String ?? ""
        self.id = idString
        self.roomId = dict[ "roomId" ] as? String ?? ""
        self.userName = dict[ "userName" ] as? String ?? ""
        self.authorName = dict[ "authorName" ] as? String ?? ""
        self.target = ChatMessageTarget(dict: dict)
        
        self.type = dict[ "type" ] as? String ?? ""
        self.subType = dict[ "subType" ] as? String ?? ""
        
        self.text = dict[ "text" ] as? String ?? ""
        self.anonymous = dict[ "isAnonymous" ] as? Bool ?? false
        
        self.photo = dict[ "photo" ] as? String ?? ""
        self.vtgId = dict[ "vtgId" ] as? Int ?? 0
        self.when = dict[ "when" ] as? String ?? ""
        self.lastEdited = dict[ "lastEdited" ] as? String ?? ""
        
        self.file = dict[ "file" ] as? Bool ?? false
        self.fileInfo = ChatMessageFile(dict: dict)
        
        self.edited = dict[ "edited" ] as? Bool ?? false
        
        let threadInfoDict: [String: Any] = dict["threadInfo"] as? [String: Any] ?? [:]
        self.threadInfo = ChatMessageThreadInfo(dict: threadInfoDict)
        self.stars = []
        
        let reactionsArray: [[String: Any]] = dict["reactions"] as? [[String: Any]] ?? []
        self.reactions = reactionsArray.map({ MessageReaction(dict: $0, messageId: idString) })
    }
    
    internal init(id: String, roomId: String, userName: String, authorName: String, target: ChatMessageTarget, type: String, subType: String, fileInfo: ChatMessageFile? = nil, text: String, anonymous: Bool, photo: String, vtgId: Int, when: String, lastEdited: String, reactions: [MessageReaction], threadInfo: ChatMessageThreadInfo, edited: Bool, file: Bool, stars: [String], isRead: Bool = false) {
        self.id = id
        self.roomId = roomId
        self.userName = userName
        self.authorName = authorName
        self.target = target
        self.type = type
        self.subType = subType
        self.fileInfo = fileInfo
        self.text = text
        self.anonymous = anonymous
        self.photo = photo
        self.vtgId = vtgId
        self.when = when
        self.lastEdited = lastEdited
        self.reactions = reactions
        self.threadInfo = threadInfo
        self.edited = edited
        self.file = file
        self.stars = stars
        self.isRead = isRead
    }
}

extension ChatMessageModel {
    var fromModel: LabelUIModel {
        LabelUIModel(
            text: authorName,
            backgroundColor: .green,
            textColor: .black,
            edgeInsets: .init(top: 4, left: 8, bottom: 4, right: 8),
            cornerRadius: 2
        )
    }
    
    var toModel: LabelUIModel {
        LabelUIModel(
            text: target.name,
            backgroundColor: .yellow,
            textColor: .black,
            edgeInsets: .init(top: 4, left: 8, bottom: 4, right: 8),
            cornerRadius: 2
        )
    }
    
    var fileItem: ChatMessageFileViewItem {
        ChatMessageFileViewItem(
            type: .archive,
            fileName: "filename",
            fileSize: "23k",
            tintColor: .blue,
            direction: .leading
        )
    }
    
    var reactionItems: [ChatMessageReactionItem] {
        [
            ChatMessageReactionItem(count: 1, reaction: .dislike),
            ChatMessageReactionItem(count: 4, reaction: .question),
            ChatMessageReactionItem(count: 8, reaction: .smile),
            ChatMessageReactionItem(count: 12, reaction: .fire),
            ChatMessageReactionItem(count: 24, reaction: .like),
        ]
    }
}

extension ChatMessageModel {
    
    var whenDate: Date? {
        guard when.isEmpty == false else {
            return nil
        }
        return dateFormatter.date(from: when)
    }
    
    var lastEditedDate: Date? {
        guard lastEdited.isEmpty == false else {
            return nil
        }
        return dateFormatter.date(from: lastEdited)
    }
}

extension ChatMessageModel {
    static private let incomingMessageDateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM dd yyyy HH:mm:ss Z"
        return dateformatter
    }()
    
    var isTypeStaff: Bool {
        return type.lowercased().contains("staff")
    }
    
    var isTypeTable: Bool {
        return type == "vtg"
    }
    
    var isTypeRoom: Bool {
        return type == "room"
    }
    
    var isTypeStarred: Bool {
        return type == "starred"
    }
    
    var isTypePrivate: Bool {
        return type == "private"
    }
    
    var isMessageToMe: Bool {
        return target.user == currentUserEmail
    }
    
    var isMessageMy: Bool {
        return userName == currentUserEmail
    }
    
    var fileRequestData: ChatFileRequestData {
        return ChatFileRequestData(id: id,
                                   type: "file",
                                   roomId: "1",
                                   userName: userName,
                                   encryptedFileLocation: fileInfo?.fileUrl ?? "")
    }
    
    var pictureUrl: String? {
        return ""
    }
    
    var to: ChatChannelItem? {
        if isTypeTable {
            return ChatChannelItem.table
        }
        if isTypeRoom {
            return ChatChannelItem.room
        }
        if isTypeStaff || isTypePrivate {
            return ChatChannelItem.staff
        }
        return nil
    }
    
    var contentType: ChatMessageContentType {
        if replyText != nil {
            return .reply
        }
        if file {
            return .file
        }
        return .text
    }
    
    var replyText: String? {
        "Some reply body"
    }
}

struct ChatMessageTarget {
    var name: String
    var user: String
    var roomId: String
    
    init(dict: [String: Any]) {
        self.roomId = dict[ "targetRoomId" ] as? String ?? ""
        self.name = dict[ "targetName" ] as? String ?? ""
        self.user = dict[ "targetUser" ] as? String ?? ""
    }
    
    internal init(name: String, user: String, roomId: String) {
        self.name = name
        self.user = user
        self.roomId = roomId
    }
}

struct ChatMessageFile {
    let fileUrl: String
    let fileSize: Int
    let fileOriginalName: String
    
    init(dict: [String: Any]) {
        self.fileUrl = dict[ "encryptedFileLocation" ] as? String ?? ""
        self.fileSize = dict[ "fileSize" ] as? Int ?? 0
        self.fileOriginalName = dict[ "fileOriginalName" ] as? String ?? ""
    }
}

struct ChatMessageThreadInfo {
    var parentId: String?
    var isAnonymous: Bool

    init(dict: [String: Any]) {
        self.parentId = dict[ "parentId" ] as? String ?? nil
        self.isAnonymous = dict[ "isAnonymous" ] as? Bool ?? false
    }
    
    internal init(parentId: String? = nil, isAnonymous: Bool) {
        self.parentId = parentId
        self.isAnonymous = isAnonymous
    }
}

enum ChatMessageContentType {
    case text
    case reply
    case file
}
