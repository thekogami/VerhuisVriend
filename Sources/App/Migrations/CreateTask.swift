//
//  CreateTask.swift
//  VerhuisVriend
//
//  Created by Felipe Mourão on 12/10/24.
//

import Fluent

struct CreateTask: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("tasks")
            .id()
            .field("title", .string, .required)
            .field("description", .string)
            .field("is_completed", .bool, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("tasks").delete()
    }
}
