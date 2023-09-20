import Fluent
import Domain
import DataLayer
import Vapor

func routes(_ app: Application) throws {
    let roomRepository = DefaultRoomRepository()
    try app.register(collection: RoomController(
            createRoomUseCase: CreateRoomUseCase(repository: roomRepository),
            registerUserInRoomUseCase: RegisterUserInRoomUseCase(repository: roomRepository)
        )
    )
}

