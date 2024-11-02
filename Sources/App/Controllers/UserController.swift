//
//  UserController.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: index)
        users.post(use: create)
    }

    func index(req: Request) throws -> EventLoopFuture<[UserDTO]> {
        return User.query(on: req.db).all().map { users in
            users.map { UserDTO(user: $0) }
        }
    }

    func create(req: Request) throws -> EventLoopFuture<UserDTO> {
        let user = try req.content.decode(UserDTO.self)
        let newUser = User(name: user.name, email: user.email)

        return newUser.save(on: req.db).map {
            UserDTO(user: newUser)
        }
    }
}
