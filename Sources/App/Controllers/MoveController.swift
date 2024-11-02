//
//  MoveController.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Vapor

struct MoveController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let moves = routes.grouped("moves")
        moves.get(use: index)
        moves.post(use: create)
    }

    func index(req: Request) throws -> EventLoopFuture<[MoveDTO]> {
        return Move.query(on: req.db) // Garante que estamos usando o banco de dados corretamente
            .with(\.$user) // Carrega a relação com o usuário
            .all()
            .map { moves in
                moves.map { try! MoveDTO(move: $0) } // Usamos `try!` para transformar Move em MoveDTO
            }
    }

    func create(req: Request) throws -> EventLoopFuture<MoveDTO> {
        let moveDTO = try req.content.decode(MoveDTO.self)
        let newMove = Move(moveDate: moveDTO.moveDate, fromLocation: moveDTO.fromLocation, toLocation: moveDTO.toLocation, userId: moveDTO.userId)

        return newMove.save(on: req.db).map {
            try! MoveDTO(move: newMove) // Retornando o DTO
        }
    }
}
