// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateTaskMutation: GraphQLMutation {
  public static let operationName: String = "CreateTask"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      mutation CreateTask($input: createTaskInput!) {
        createTask(input: $input) {
          __typename
          id
        }
      }
      """#
    ))

  public var input: CreateTaskInput

  public init(input: CreateTaskInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: GraphiOSAutogenerated.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { GraphiOSAutogenerated.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createTask", CreateTask?.self, arguments: ["input": .variable("input")]),
    ] }

    public var createTask: CreateTask? { __data["createTask"] }

    /// CreateTask
    ///
    /// Parent Type: `Task`
    public struct CreateTask: GraphiOSAutogenerated.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { GraphiOSAutogenerated.Objects.Task }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("id", GraphiOSAutogenerated.ID.self),
      ] }

      public var id: GraphiOSAutogenerated.ID { __data["id"] }
    }
  }
}
