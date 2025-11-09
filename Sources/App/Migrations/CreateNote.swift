import Fluent

struct CreateNote: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("notes")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("move_id", .uuid, .references("moves", "id", onDelete: .cascade))
            .field("title", .string, .required)
            .field("content", .string, .required)
            .field("category", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("notes").delete()
    }
}
