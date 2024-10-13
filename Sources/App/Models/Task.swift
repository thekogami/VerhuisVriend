//
//  Task.swift
//  VerhuisVriend
//
//  Created by Felipe Mourão on 12/10/24.
//

import Vapor
import Fluent

final class Task: Model, Content {
    static let schema = "tasks"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String?

    @Field(key: "is_completed")
    var isCompleted: Bool

    @Parent(key: "user_id")
    var user: User // Assumindo que uma tarefa pertence a um usuário

    init() { }

    init(id: UUID? = nil, title: String, description: String? = nil, isCompleted: Bool = false, userId: UUID) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.$user.id = userId
    }
}
