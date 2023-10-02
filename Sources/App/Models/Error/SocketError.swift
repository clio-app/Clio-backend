//
//  File.swift
//  
//
//  Created by Thiago Henrique on 02/10/23.
//

import Foundation

public enum SocketError: LocalizedError, Codable {
    case unableToStartInPort(UInt16)
    case unableToInitializeListener
    case serverInitializationFail(String?)
    case cantHandleClientMessage(String?)
    case unableToSendAMessageToUser
    case cantConnectWithClient
    case connectTimeWasTooLong
    case unableToEncodeMessage
    case unableToDecodeMessage
    
    public var errorDescription: String? {
        switch self {
        case .unableToStartInPort(let port):
            return "Não foi possível iniciar o servidor na porta: \(port)"
        case .unableToInitializeListener:
            return "Não foi possível iniciar a comunicação com o servidor"
        case .serverInitializationFail(let error):
            return "A inicialização do servidor falhou \(error ?? "")"
        case .cantHandleClientMessage(let error):
            return "Não foi possível processar a mensagem \(error != nil ? "error: \(error!)" : "" )"
        case .unableToSendAMessageToUser:
            return "Não foi possível enviar a mensagem para o usuário"
        case .cantConnectWithClient:
            return "A conexão com o cliente falhou"
        case .connectTimeWasTooLong:
            return "O tempo de espera foi muito longo"
        case .unableToEncodeMessage:
            return "O processo de preparar a mensagem para envio falhou"
        case .unableToDecodeMessage:
            return "Não foi possível processar a mensagem"
        }
    }
}
