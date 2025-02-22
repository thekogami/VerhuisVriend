import Fluent

struct CreateCompany: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("companies")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("phone", .string)
            .field("address", .string)
            .field("service_area", .string)
            .field("services_offered", .string)
            .field("languages_spoken", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("companies").delete()
    }
}
