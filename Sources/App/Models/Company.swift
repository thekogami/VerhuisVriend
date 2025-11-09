import Vapor
import Fluent

final class Company: Model, Content, @unchecked Sendable {
    static let schema = "companies"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String?

    @Field(key: "phone")
    var phone: String?

    @Field(key: "address")
    var address: String?

    @Field(key: "service_area")
    var serviceArea: String?

    @Field(key: "services_offered")
    var servicesOffered: String?

    @Field(key: "languages_spoken")
    var languagesSpoken: String?

    @Field(key: "rating")
    var rating: Double?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() { }

    init(id: UUID? = nil, name: String, email: String? = nil, phone: String? = nil, address: String? = nil, serviceArea: String? = nil, servicesOffered: String? = nil, languagesSpoken: String? = nil, rating: Double? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.serviceArea = serviceArea
        self.servicesOffered = servicesOffered
        self.languagesSpoken = languagesSpoken
        self.rating = rating
    }
}
