//
//  TaskController.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Vapor

struct TaskController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tasks = routes.grouped("tasks")
        tasks.get(use: index)
        tasks.post(use: create)
    }

    func index(req: Request) throws -> EventLoopFuture<[TaskDTO]> {
        return Task.query(on: req.db).with(\.$user).all().flatMapThrowing { tasks in
            try tasks.map { task in
                try TaskDTO(task: task, on: req.db)
            }
        }
    }


    func create(req: Request) throws -> EventLoopFuture<TaskDTO> {
        let taskDTO = try req.content.decode(TaskDTO.self) // Decodificando o DTO
        let newTask = Task(title: taskDTO.title, description: taskDTO.description, isCompleted: taskDTO.isCompleted, userId: taskDTO.userId) // Criando o modelo Task
        return newTask.save(on: req.db).flatMapThrowing {
            try TaskDTO(task: newTask, on: req.db)
        }
    }
}
