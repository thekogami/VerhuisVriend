import Fluent
import Vapor

final class UserToken: Model, @unchecked Sendable {
    static let schema = "user_tokens"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "value")
    var value: String
    
    @Parent(key: "user_id")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "expires_at", on: .none)
    var expiresAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, value: String, userID: User.IDValue, expiresAt: Date? = nil) {
        self.id = id
        self.value = value
        self.$user.id = userID
        self.expiresAt = expiresAt
    }
    
    static func generate(for user: User) throws -> UserToken {
        let random = [UInt8].random(count: 32).base64
        let expiresAt = Date().addingTimeInterval(60 * 60 * 24 * 30) // 30 days
        return try UserToken(value: random, userID: user.requireID(), expiresAt: expiresAt)
    }
}

extension UserToken: ModelTokenAuthenticatable {
    static let valueKey = \UserToken.$value
    static let userKey = \UserToken.$user
    
    var isValid: Bool {
        guard let expiresAt = expiresAt else {
            return true
        }
        return expiresAt > Date()
    }
}
