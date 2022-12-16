//
//  ChatChannelItem.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-23.
//

import Foundation
import UIKit

struct ChatChannelItem: Equatable {
    let index: Int
    let title: String
    let iconName: String
}

extension ChatChannelItem {
    static var room: ChatChannelItem {
        ChatChannelItem(index: 0, title: "Room", iconName: "chat_room_icon")
    }
    
    static var staff: ChatChannelItem {
        ChatChannelItem(index: 1, title: "Staff", iconName: "chat_staff_icon")
    }
    
    static var table: ChatChannelItem {
        ChatChannelItem(index: 2, title: "Table", iconName: "chat_table_icon")
    }
    
    static var starred: ChatChannelItem {
        ChatChannelItem(index: 3, title: "Starred", iconName: "chat_starred_icon")
    }
    
    func countText(_ count: Int) -> String {
        var text = "No participants"
        if index == ChatChannelItem.room.index ||
            index == ChatChannelItem.staff.index ||
            index == ChatChannelItem.table.index {
            if count == 1 {
                text = "1 participant"
            }
            if count > 1 {
                text = "\(count) participants"
            }
        }
        return text
    }
}

extension ChatChannelItem {
    var color: UIColor {
        switch index {
            case 0: return Colors.ColorCoding.colorCodingEmerald // room
            case 1: return Colors.ColorCoding.colorCodingBlue // staff
            case 2: return Colors.ColorCoding.colorCodingPink // table
            default : return .clear
        }
    }
}
