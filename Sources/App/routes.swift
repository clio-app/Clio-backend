import Fluent
import Domain
import Data
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: RoomController(
            createRoomUseCase: CreateRoomUseCase(
                repository: DefaultRoomRepository()
            )
        )
    )
}

