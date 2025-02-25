import Vapor
import Fluent

final class User: Model, Content {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String

    @Field(key: "password")
    var password: String

    @Field(key: "status")
    var status: Bool

    @Field(key: "avatar")
    var avatar: String?

    @Field(key: "phone")
    var phone: String?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() { }

    init(id: UUID? = nil, name: String, email: String, password: String, status: Bool = true, avatar: String? = nil, phone: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.status = status
        self.avatar = avatar
        self.phone = phone
    }
}
