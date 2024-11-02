//
//  Move.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Vapor
import Fluent

final class Move: Model, Content {
    static let schema = "moves"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "moveDate")
    var moveDate: Date

    @Field(key: "fromLocation")
    var fromLocation: String

    @Field(key: "toLocation")
    var toLocation: String

    @Parent(key: "userId") // Assuming there's a userId foreign key
    var user: User

    init() { }

    init(id: UUID? = nil, moveDate: Date, fromLocation: String, toLocation: String, userId: UUID) {
        self.id = id
        self.moveDate = moveDate
        self.fromLocation = fromLocation
        self.toLocation = toLocation
        self.$user.id = userId // Associa o ID do usuário
    }
}
