//
//  File.swift
//  
//
//  Created by Thiago Henrique on 27/09/23.
//

import Foundation

public enum MessageState: Codable {
    case client(ClientMessages)
    case server(ServerMessages)
    
    public enum ClientMessages: Codable {
        case gameFlow(ClientGameFlow)
        
        public enum ClientGameFlow: String, Codable {
            case registerUser = "#registerUser"
            case gameStarted = "#gameStarted"
            case masterActed = "#masterActed"
            case userActed = "#userActed"
            case userVoted = "#userVoted"
            case playAgain = "#playAgain"
        }

    }
    
    public enum ServerMessages: Codable {
        case connection(ServerConnection)
        case gameFlow(ServerGameFlow)
        case error
        
        public enum ServerConnection: String, Codable {
            case playerConnected = "#playerConnected"
        }
        
        public enum ServerGameFlow: String, Codable {
            case masterActing = "#masterActing"
            case masterSharing = "#masterSharing"
            case userDidAct = "#userDidAct"
            case startVoting = "#startVoting"
            case userDidVote = "#userDidVote"
            case roundEnd = "#roundEnd"
        }
    }
}
