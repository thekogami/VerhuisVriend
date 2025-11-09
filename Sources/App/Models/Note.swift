import Fluent
import Vapor

final class Note: Model, Content, @unchecked Sendable {
    static let schema = "notes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @OptionalParent(key: "move_id")
    var move: Move?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "content")
    var content: String
    
    @Field(key: "category")
    var category: String // "general", "task", "reminder", "checklist"
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, userID: User.IDValue, moveID: Move.IDValue? = nil, title: String, content: String, category: String = "general") {
        self.id = id
        self.$user.id = userID
        if let moveID = moveID {
            self.$move.id = moveID
        }
        self.title = title
        self.content = content
        self.category = category
    }
}
