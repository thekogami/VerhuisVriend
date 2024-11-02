//
//  TaskDTO.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Vapor
import Fluent

struct TaskDTO: Content {
    let id: UUID?
    let title: String
    let description: String?
    let isCompleted: Bool
    let userId: UUID // Para associar a tarefa ao usuário

    // Inicializador para criar um TaskDTO a partir de um Task
    init(task: Task, on db: Database) throws {
        self.id = task.id
        self.title = task.title
        self.description = task.description
        self.isCompleted = task.isCompleted

        // Aqui, obtemos o ID do usuário. É uma relação opcional, então precisamos verificar se existe.
        guard let user = try? task.$user.get(on: db).wait() else {
            throw Abort(.badRequest, reason: "User ID not found")
        }
        self.userId = try user.requireID()
    }

    // Inicializador para criar um TaskDTO a partir de dados recebidos
    init(title: String, description: String? = nil, isCompleted: Bool = false, userId: UUID) {
        self.id = nil
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.userId = userId
    }
}
