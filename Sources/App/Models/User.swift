import Vapor
import Fluent

final class User: Model, Content, Authenticatable, @unchecked Sendable {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String

    @Field(key: "password_hash")
    var passwordHash: String

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
    
    @Children(for: \.$user)
    var notes: [Note]

    init() { }

    init(id: UUID? = nil, name: String, email: String, passwordHash: String, status: Bool = true, avatar: String? = nil, phone: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.status = status
        self.avatar = avatar
        self.phone = phone
    }
}

extension User {
    struct Create: Content {
        var name: String
        var email: String
        var password: String
        var phone: String?
    }
    
    struct Login: Content {
        var email: String
        var password: String
    }
    
    struct Public: Content {
        var id: UUID?
        var name: String
        var email: String
        var avatar: String?
        var phone: String?
        var createdAt: Date?
    }
    
    struct AuthResponse: Content {
        var user: Public
        var token: String
    }
    
    func asPublic() -> Public {
        Public(
            id: id,
            name: name,
            email: email,
            avatar: avatar,
            phone: phone,
            createdAt: createdAt
        )
    }
}
