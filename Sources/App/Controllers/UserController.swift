import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: index)
        users.post(use: create)
        users.group(":userID") { user in
            user.get(use: show)
            user.put(use: update)
            user.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[UserDTO]> {
        return User.query(on: req.db).all().map { users in
            users.map { UserDTO(user: $0) }
        }
    }

    func create(req: Request) throws -> EventLoopFuture<UserDTO> {
        let userDTO = try req.content.decode(UserDTO.self)
        let newUser = User(name: userDTO.name, email: userDTO.email, password: userDTO.password, status: userDTO.status, avatar: userDTO.avatar, phone: userDTO.phone)

        return newUser.save(on: req.db).map {
            UserDTO(user: newUser)
        }
    }

    func show(req: Request) throws -> EventLoopFuture<UserDTO> {
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { UserDTO(user: $0) }
    }

    func update(req: Request) throws -> EventLoopFuture<UserDTO> {
        let updatedUserDTO = try req.content.decode(UserDTO.self)
        
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.name = updatedUserDTO.name
                user.email = updatedUserDTO.email
                user.password = updatedUserDTO.password
                user.status = updatedUserDTO.status
                user.avatar = updatedUserDTO.avatar
                user.phone = updatedUserDTO.phone
                
                return user.save(on: req.db).map {
                    UserDTO(user: user)
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.delete(on: req.db).transform(to: .noContent)
            }
    }
}
