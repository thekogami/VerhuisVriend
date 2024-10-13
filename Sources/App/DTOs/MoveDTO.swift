//
//  MoveDTO.swift
//  VerhuisVriend
//
//  Created by Felipe Mourão on 12/10/24.
//
import Vapor

struct MoveDTO: Content {
    let id: UUID?
    let moveDate: Date
    let fromLocation: String
    let toLocation: String
    let userId: UUID // Para associar a mudança ao usuário

    // Inicializador para criar um MoveDTO a partir de um Move
    init(move: Move) throws {
        self.id = move.id
        self.moveDate = move.moveDate
        self.fromLocation = move.fromLocation
        self.toLocation = move.toLocation

        // Aqui, obtemos o ID do usuário
        guard let userId = try? move.$user.id else {
            throw Abort(.badRequest, reason: "User ID not found")
        }
        self.userId = userId
    }

    // Inicializador para criar um MoveDTO a partir de dados recebidos
    init(moveDate: Date, fromLocation: String, toLocation: String, userId: UUID) {
        self.id = nil
        self.moveDate = moveDate
        self.fromLocation = fromLocation
        self.toLocation = toLocation
        self.userId = userId
    }
}
