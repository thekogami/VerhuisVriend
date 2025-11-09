import Fluent
import Vapor

func routes(_ app: Application) throws {
    // Rota padrão
    app.get { req async in
        "It works!"
    }

    // Rota de exemplo
    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    // Registrando os controladores
    let authController = AuthController()
    try app.register(collection: authController)
    
    let userController = UserController()
    try app.register(collection: userController)

    let taskController = TaskController()
    try app.register(collection: taskController)

    let moveController = MoveController()
    try app.register(collection: moveController)

    let companyController = CompanyController()
    try app.register(collection: companyController)

    let neighborhoodController = NeighborhoodController()
    try app.register(collection: neighborhoodController)
    
    let noteController = NoteController()
    try app.register(collection: noteController)
}
