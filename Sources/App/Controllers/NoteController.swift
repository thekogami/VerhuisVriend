import Vapor
import Fluent

struct NoteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let notes = routes.grouped("notes")
        let protected = notes.grouped(UserToken.authenticator())
        
        protected.get(use: index)
        protected.post(use: create)
        protected.get(":noteID", use: show)
        protected.put(":noteID", use: update)
        protected.delete(":noteID", use: delete)
        protected.get("move", ":moveID", use: getByMove)
        protected.get("category", ":category", use: getByCategory)
    }
    
    // GET /notes
    func index(req: Request) async throws -> [Note] {
        let user = try req.auth.require(User.self)
        return try await Note.query(on: req.db)
            .filter(\.$user.$id == user.requireID())
            .sort(\.$createdAt, .descending)
            .all()
    }
    
    // POST /notes
    func create(req: Request) async throws -> Note {
        let user = try req.auth.require(User.self)
        
        struct CreateNote: Content {
            var moveID: UUID?
            var title: String
            var content: String
            var category: String?
        }
        
        let input = try req.content.decode(CreateNote.self)
        
        let note = Note(
            userID: try user.requireID(),
            moveID: input.moveID,
            title: input.title,
            content: input.content,
            category: input.category ?? "general"
        )
        
        try await note.save(on: req.db)
        return note
    }
    
    // GET /notes/:noteID
    func show(req: Request) async throws -> Note {
        let user = try req.auth.require(User.self)
        
        guard let note = try await Note.find(req.parameters.get("noteID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        guard try note.$user.id == user.requireID() else {
            throw Abort(.forbidden)
        }
        
        return note
    }
    
    // PUT /notes/:noteID
    func update(req: Request) async throws -> Note {
        let user = try req.auth.require(User.self)
        
        guard let note = try await Note.find(req.parameters.get("noteID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        guard try note.$user.id == user.requireID() else {
            throw Abort(.forbidden)
        }
        
        struct UpdateNote: Content {
            var title: String?
            var content: String?
            var category: String?
        }
        
        let input = try req.content.decode(UpdateNote.self)
        
        if let title = input.title {
            note.title = title
        }
        if let content = input.content {
            note.content = content
        }
        if let category = input.category {
            note.category = category
        }
        
        try await note.save(on: req.db)
        return note
    }
    
    // DELETE /notes/:noteID
    func delete(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        
        guard let note = try await Note.find(req.parameters.get("noteID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        guard try note.$user.id == user.requireID() else {
            throw Abort(.forbidden)
        }
        
        try await note.delete(on: req.db)
        return .noContent
    }
    
    // GET /notes/move/:moveID
    func getByMove(req: Request) async throws -> [Note] {
        let user = try req.auth.require(User.self)
        
        guard let moveID = req.parameters.get("moveID", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return try await Note.query(on: req.db)
            .filter(\.$user.$id == user.requireID())
            .filter(\.$move.$id == moveID)
            .sort(\.$createdAt, .descending)
            .all()
    }
    
    // GET /notes/category/:category
    func getByCategory(req: Request) async throws -> [Note] {
        let user = try req.auth.require(User.self)
        
        guard let category = req.parameters.get("category") else {
            throw Abort(.badRequest)
        }
        
        return try await Note.query(on: req.db)
            .filter(\.$user.$id == user.requireID())
            .filter(\.$category == category)
            .sort(\.$createdAt, .descending)
            .all()
    }
}
