import Vapor

struct UserDTO: Content {
    let id: UUID?
    let name: String
    let email: String
    let password: String
    let status: Bool
    let avatar: String?
    let phone: String?
    let createdAt: Date?
    let updatedAt: Date?

    // Inicializador para criar um UserDTO a partir de um User
    init(user: User) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        self.password = user.password
        self.status = user.status
        self.avatar = user.avatar
        self.phone = user.phone
        self.createdAt = user.createdAt
        self.updatedAt = user.updatedAt
    }

    // Inicializador para criar um UserDTO a partir de dados recebidos
    init(name: String, email: String, password: String, status: Bool = true, avatar: String? = nil, phone: String? = nil) {
        self.id = nil
        self.name = name
        self.email = email
        self.password = password
        self.status = status
        self.avatar = avatar
        self.phone = phone
        self.createdAt = nil
        self.updatedAt = nil
    }
}
