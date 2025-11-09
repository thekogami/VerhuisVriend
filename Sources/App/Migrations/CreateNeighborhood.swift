import Fluent

struct CreateNeighborhood: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("neighborhoods")
            .id()
            .field("name", .string, .required)
            .field("city", .string, .required)
            .field("description", .string)
            .field("latitude", .double, .required)
            .field("longitude", .double, .required)
            .field("student_rating", .double)
            .field("average_rent", .double)
            .field("university_distance", .double)
            .field("transport_score", .int)
            .field("safety_rating", .double)
            .field("amenities", .string)
            .field("tags", .string)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("neighborhoods").delete()
    }
}
