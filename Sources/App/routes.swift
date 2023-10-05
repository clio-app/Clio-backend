import Fluent
import Domain
import DataLayer
import Vapor

func routes(_ app: Application) throws {
    let userRepository = DefaultUserRepository()
    let roomRepository = DefaultRoomRepository()
    let gameSession = DefaultGameSession()
    
    try app.register(
        collection: RoomController(
            createRoomUseCase: CreateRoomUseCase(repository: roomRepository),
            registerUserInRoomUseCase: RegisterUserInRoomUseCase(repository: roomRepository),
            getAllRoomsUseCase: GetAllRoomsUseCase(repository: roomRepository),
            findRoomUseCase: FindRoomUseCase(repository: roomRepository)
        )
    )
    
    try app.register(
        collection: UserController(
            createUserUseCase: CreateUserUseCase(repository: userRepository)
        )
    )
    
    try app.register(
        collection: GameSystemController(
            registerUserInRoomUseCase: RegisterUserInRoomUseCase(repository: roomRepository),
            gameStartUseCase: GameStartUseCase(
                session: gameSession,
                roomRepository: roomRepository
            ),
            masterActUseCase: MasterActUseCase(session: gameSession)
        )
    )
}

