//
//  File.swift
//  
//
//  Created by Thiago Henrique on 11/10/23.
//

import Foundation
import FluentKit
import Vapor

final class SessionArtefact: Content {
    var id: UUID? = UUID()
    var description: String
    var picture: File?
    
//    init() { }
    
//    init(id: UUID = UUID(), content: String, media: String?) {
//        self.id = id
//        self.content = content
//        self.media = media
//    }
//    
//    init(form: Form, id: UUID = UUID()) {
//        self.id = id
//        self.content = form.content
//        if let media = form.media {
//            self.media = try? media.data.write(
//                to: URL(
//                    fileURLWithPath: DirectoryConfiguration.detect().publicDirectory
//                ),
//                contentType: media.contentType
//            )
//        }
//    }
}

//extension SessionArtefact: Content {}

//extension SessionImage: Content {
//    struct Form: Content {
//         var content: String
//         var media: File?
//     }
//}
//
//extension ByteBuffer {
//    
//    func write(to directory: URL, contentType: HTTPMediaType?) throws -> String {
//        var buffer = self
//        guard let file = buffer.readData(length: buffer.readableBytes) else {
//            throw Abort(.internalServerError)
//        }
//        let filename = SHA256.hash(data: Data(UUID().uuidString.utf8)).hexEncodedString().prefix(30)
//        let fileExtension = contentType?.description.components(separatedBy: "/").last ?? ""
//        let path = "media/" + filename + "." + fileExtension
//        let url = directory.appendingPathComponent(path)
//        try file.write(to: url)
//        return path
//    }
//    
//}
