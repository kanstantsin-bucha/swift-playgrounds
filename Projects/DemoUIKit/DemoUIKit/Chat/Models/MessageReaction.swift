//
//  MessageReaction.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-22.
//

import Foundation
import UIKit

enum ChatMessageFileType {
    case pdfDocument
    case txtDocument
    case music
    case archive
    case image
    case video
    case unowned
    
    var imageName: String {
        switch self {
            case .pdfDocument, .txtDocument:
                return "chat_message_file_doc"
            case .music:
                return "chat_message_file_music"
            case .archive:
                return "chat_message_file_archive"
            case .image:
                return "chat_message_file_image"
            case .video:
                return "chat_message_file_video"
            case .unowned:
                return "chat_message_file_doc"
        }
    }
}


struct ChatMessageFileViewItem {
    let type: ChatMessageFileType
    let fileName: String
    let fileSize: String
    let tintColor: UIColor
    let direction: ChatMessageLayout
}

struct ChatMessageReactionItem {
    let count: Int
    let reaction: ChatMessageReaction
}

enum ChatMessageReaction: String, Codable, CaseIterable {
    case like = "like"
    case fire = "fire"
    case smile = "smile"
    case question = "question"
    case dislike = "dislike"
}

struct MessageReaction: Codable {
    let id: String // message ID
    var userName: String
    var reactionId: String
    var isAdd: Bool
    
    init(dict: [String: Any], isAdd: Bool) {
        self.id = dict[ "id" ] as? String ?? ""
        self.reactionId = dict[ "reactionId" ] as? String ?? ""
        self.userName = dict[ "userName" ] as? String ?? ""
        self.isAdd = isAdd
    }
    
    init(dict: [String: Any], messageId: String) {
        self.id = messageId
        self.reactionId = dict[ "reactionId" ] as? String ?? ""
        self.userName = dict[ "userName" ] as? String ?? ""
        self.isAdd = true
    }
}

extension ChatMessageReaction {
    var imageName: String {
        switch self {
            case .like: return "reaction_like"
            case .dislike: return "reaction_dislike"
            case .fire: return "reaction_fire"
            case .smile: return "reaction_smile"
            case .question: return "reaction_question"
        }
    }
}

extension MessageReaction {
    
    var chatReaction: ChatMessageReaction? {
        return ChatMessageReaction(rawValue: reactionId)
    }
    
}

extension Array where Element == MessageReaction {
    
    // MARK: - Update
    func updateCount(by reaction: MessageReaction) -> [MessageReaction] {
        var reactions = self
        let reactionsFromUser = reactions.filter({ $0.reactionId == reaction.reactionId && $0.userName == reaction.userName })
        if reaction.isAdd && reactionsFromUser.isEmpty {
            reactions.append(reaction)
        } else if reaction.isAdd == false, let index = reactions.firstIndex (where: { $0.reactionId == reaction.reactionId && $0.userName == reaction.userName }) {
            reactions.remove(at: index)
        }
        return reactions
    }
    
    // MARK: - Calculation
    var fireCount: Int {
        return filter({ $0.chatReaction == .fire }).count
    }
    
    var likeCount: Int {
        return filter({ $0.chatReaction == .like }).count
    }
    
    var dislikeCount: Int {
        return filter({ $0.chatReaction == .dislike }).count
    }
    
    var questionCount: Int {
        return filter({ $0.chatReaction == .question }).count
    }
    
    var smileCount: Int {
        return filter({ $0.chatReaction == .smile }).count
    }
}

