//
//  Task.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Vapor
import Fluent

final class Task: Model, Content, @unchecked Sendable {
    static let schema = "tasks"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String?

    @Field(key: "is_completed")
    var isCompleted: Bool

    @Field(key: "due_date")
    var dueDate: Date?

    @Field(key: "priority")
    var priority: String? // low, medium, high

    @Parent(key: "user_id")
    var user: User

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() { }

    init(id: UUID? = nil, title: String, description: String? = nil, isCompleted: Bool = false, userId: UUID, dueDate: Date? = nil, priority: String? = "medium") {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.$user.id = userId
        self.dueDate = dueDate
        self.priority = priority
    }
}
