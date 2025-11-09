//
//  CreateMove.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Fluent

struct CreateMove: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("moves")
            .id()
            .field("moveDate", .date, .required)
            .field("fromLocation", .string, .required)
            .field("toLocation", .string, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("status", .string)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("moves").delete() 
    }
}
