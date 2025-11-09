import Fluent

struct CreateCompany: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("companies")
            .id()
            .field("name", .string, .required)
            .field("email", .string)
            .field("phone", .string)
            .field("address", .string)
            .field("service_area", .string)
            .field("services_offered", .string)
            .field("languages_spoken", .string)
            .field("rating", .double)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("companies").delete()
    }
}
