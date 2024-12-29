import Vapor

struct TaskController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tasks = routes.grouped("tasks")
        tasks.get(use: index)
        tasks.post(use: create)
        tasks.group(":taskID") { task in
            task.get(use: show)
            task.put(use: update)
            task.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[TaskDTO]> {
        return Task.query(on: req.db)
            .with(\.$user)
            .all()
            .flatMapThrowing { tasks in
                try tasks.map { task in
                    try TaskDTO(task: task, on: req.db)
                }
            }
    }

    func create(req: Request) throws -> EventLoopFuture<TaskDTO> {
        let taskDTO = try req.content.decode(TaskDTO.self)
        let newTask = Task(title: taskDTO.title, description: taskDTO.description, isCompleted: taskDTO.isCompleted, userId: taskDTO.userId)
        return newTask.save(on: req.db).flatMapThrowing {
            try TaskDTO(task: newTask, on: req.db)
        }
    }

    func show(req: Request) throws -> EventLoopFuture<TaskDTO> {
        return Task.find(req.parameters.get("taskID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { task in
                try TaskDTO(task: task, on: req.db)
            }
    }

    func update(req: Request) throws -> EventLoopFuture<TaskDTO> {
        let updatedTaskDTO = try req.content.decode(TaskDTO.self)
        
        return Task.find(req.parameters.get("taskID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { task in
                task.title = updatedTaskDTO.title
                task.description = updatedTaskDTO.description
                task.isCompleted = updatedTaskDTO.isCompleted
                task.$user.id = updatedTaskDTO.userId
                
                return task.save(on: req.db).flatMapThrowing {
                    try TaskDTO(task: task, on: req.db)
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Task.find(req.parameters.get("taskID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { task in
                task.delete(on: req.db).transform(to: .noContent)
            }
    }
}
