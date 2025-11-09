import Vapor
import Fluent

struct AuthController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        auth.post("register", use: register)
        auth.post("login", use: login)
        
        let protected = auth.grouped(UserToken.authenticator())
        protected.get("me", use: getCurrentUser)
        protected.post("logout", use: logout)
    }
    
    // POST /auth/register
    func register(req: Request) async throws -> User.AuthResponse {
        try User.Create.validate(content: req)
        let create = try req.content.decode(User.Create.self)
        
        // Check if email already exists
        if let _ = try await User.query(on: req.db)
            .filter(\.$email == create.email)
            .first() {
            throw Abort(.badRequest, reason: "Email already registered")
        }
        
        // Hash password
        let passwordHash = try Bcrypt.hash(create.password)
        
        // Create user
        let user = User(
            name: create.name,
            email: create.email,
            passwordHash: passwordHash,
            phone: create.phone
        )
        
        try await user.save(on: req.db)
        
        // Generate token
        let token = try UserToken.generate(for: user)
        try await token.save(on: req.db)
        
        // Return response
        return User.AuthResponse(user: user.asPublic(), token: token.value)
    }
    
    // POST /auth/login
    func login(req: Request) async throws -> User.AuthResponse {
        let credentials = try req.content.decode(User.Login.self)
        
        // Find user by email
        guard let user = try await User.query(on: req.db)
            .filter(\.$email == credentials.email)
            .first() else {
            throw Abort(.unauthorized, reason: "Invalid email or password")
        }
        
        // Verify password
        guard try Bcrypt.verify(credentials.password, created: user.passwordHash) else {
            throw Abort(.unauthorized, reason: "Invalid email or password")
        }
        
        // Check if user is active
        guard user.status else {
            throw Abort(.forbidden, reason: "Account is inactive")
        }
        
        // Delete old tokens
        try await UserToken.query(on: req.db)
            .filter(\.$user.$id == user.id!)
            .delete()
        
        // Generate new token
        let token = try UserToken.generate(for: user)
        try await token.save(on: req.db)
        
        // Return response
        return User.AuthResponse(user: user.asPublic(), token: token.value)
    }
    
    // GET /auth/me
    func getCurrentUser(req: Request) async throws -> User.Public {
        let user = try req.auth.require(User.self)
        return user.asPublic()
    }
    
    // POST /auth/logout
    func logout(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        
        try await UserToken.query(on: req.db)
            .filter(\.$user.$id == user.id!)
            .delete()
        
        return .noContent
    }
}

extension User.Create: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(6...))
    }
}
