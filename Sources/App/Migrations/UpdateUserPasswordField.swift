import Fluent

struct UpdateUserPasswordField: AsyncMigration {
    func prepare(on database: Database) async throws {
        // Rename password to password_hash
        try await database.schema("users")
            .deleteField("password")
            .field("password_hash", .string, .required)
            .update()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users")
            .deleteField("password_hash")
            .field("password", .string, .required)
            .update()
    }
}
