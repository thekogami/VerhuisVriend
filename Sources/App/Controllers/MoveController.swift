import Vapor

struct MoveController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let moves = routes.grouped("moves")
        moves.get(use: index)
        moves.post(use: create)
        moves.group(":moveID") { move in
            move.get(use: show)
            move.put(use: update)
            move.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[MoveDTO]> {
        return Move.query(on: req.db)
            .with(\.$user)
            .all()
            .flatMapThrowing { moves in
                try moves.map { try MoveDTO(move: $0) }
            }
    }

    func create(req: Request) throws -> EventLoopFuture<MoveDTO> {
        let moveDTO = try req.content.decode(MoveDTO.self)
        let newMove = Move(moveDate: moveDTO.moveDate, fromLocation: moveDTO.fromLocation, toLocation: moveDTO.toLocation, userId: moveDTO.userId)

        return newMove.save(on: req.db).flatMapThrowing {
            try MoveDTO(move: newMove)
        }
    }

    func show(req: Request) throws -> EventLoopFuture<MoveDTO> {
        return Move.find(req.parameters.get("moveID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { move in
                try MoveDTO(move: move)
            }
    }

    func update(req: Request) throws -> EventLoopFuture<MoveDTO> {
        let updatedMoveDTO = try req.content.decode(MoveDTO.self)
        
        return Move.find(req.parameters.get("moveID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { move in
                move.moveDate = updatedMoveDTO.moveDate
                move.fromLocation = updatedMoveDTO.fromLocation
                move.toLocation = updatedMoveDTO.toLocation
                move.$user.id = updatedMoveDTO.userId
                
                return move.save(on: req.db).flatMapThrowing {
                    try MoveDTO(move: move)
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Move.find(req.parameters.get("moveID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { move in
                move.delete(on: req.db).transform(to: .noContent)
            }
    }
}
