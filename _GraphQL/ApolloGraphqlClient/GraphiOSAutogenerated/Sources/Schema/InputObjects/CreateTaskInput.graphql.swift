// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CreateTaskInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    name: String,
    completed: Bool,
    userId: ID
  ) {
    __data = InputDict([
      "name": name,
      "completed": completed,
      "userId": userId
    ])
  }

  public var name: String {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  public var completed: Bool {
    get { __data["completed"] }
    set { __data["completed"] = newValue }
  }

  public var userId: ID {
    get { __data["userId"] }
    set { __data["userId"] = newValue }
  }
}
