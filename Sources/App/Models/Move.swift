//
//  Move.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Vapor
import Fluent

final class Move: Model, Content, @unchecked Sendable {
    static let schema = "moves"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "moveDate")
    var moveDate: Date

    @Field(key: "fromLocation")
    var fromLocation: String

    @Field(key: "toLocation")
    var toLocation: String

    @Parent(key: "user_id")
    var user: User

    @Field(key: "status")
    var status: String? // pending, in-progress, completed

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() { }

    init(id: UUID? = nil, moveDate: Date, fromLocation: String, toLocation: String, userId: UUID, status: String? = "pending") {
        self.id = id
        self.moveDate = moveDate
        self.fromLocation = fromLocation
        self.toLocation = toLocation
        self.$user.id = userId
        self.status = status
    }
}
