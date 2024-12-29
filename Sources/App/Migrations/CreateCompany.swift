//
//  CreateCompany.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Fluent

struct CreateCompany: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("companies")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("phone", .string)
            .field("address", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("companies").delete()
    }
}
