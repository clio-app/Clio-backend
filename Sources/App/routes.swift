import Fluent
import Domain
import DataLayer
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: RoomController(
            createRoomUseCase: CreateRoomUseCase(
                repository: DefaultRoomRepository()
            )
        )
    )
}

