//
//  CreateMove.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Fluent

struct CreateMove: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("moves")
            .id()
            .field("move_date", .date, .required)
            .field("from_location", .string, .required)
            .field("to_location", .string, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("moves").delete() 
    }
}
