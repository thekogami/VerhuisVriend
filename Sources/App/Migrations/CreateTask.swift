//
//  CreateTask.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Fluent

struct CreateTask: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("tasks")
            .id()
            .field("title", .string, .required)
            .field("description", .string)
            .field("is_completed", .bool, .required)
            .field("due_date", .date)
            .field("priority", .string)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("tasks").delete()
    }
}
