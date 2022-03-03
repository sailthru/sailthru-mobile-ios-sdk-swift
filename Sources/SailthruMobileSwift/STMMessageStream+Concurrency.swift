//
//  STMMessageStream+Concurrency.swift
//  SailthruMobileSwift
//
//  Created by Ian Stewart on 2/03/22.
//

import SailthruMobile

/**
 * Extensions to allow asynchronous functionality to be used with Swift Concurrency.
 */
extension STMMessageStream {
    
    /**
     *  Asynchronously returns the total number of unread messages in the message stream.
     *
     *  - Returns: UInt representing the unread messages count.
     *  - Throws: Error when call fails.
     **/
    public func unreadCount() async throws -> UInt {
        return try await withCheckedThrowingContinuation({ continuation in
            unreadCount { count, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                
                continuation.resume(returning: count)
            }
        })
    }
    
    /**
     *  Asynchronously marks a given message as read.
     *
     *  - Parameter message: Message to mark as read.
     *  - Throws: Error when call fails.
     **/
    public func mark(asRead message: STMMessage) async throws {
        try await mark(asRead: [message])
    }
    
    /**
     *  Asynchronously marks a given array of messages as read.
     *
     *  - Parameter messages: Array of messages to mark as read.
     *  - Throws: Error when call fails.
     **/
    public func mark(asRead messages: [STMMessage]) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            markMessages(asRead: messages, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Returns an array of STMMessages for the device.
     *
     *  - Returns: Array of STMMessage objects.
     *  - Throws: Error when call fails.
     **/
    public func messages() async throws -> [STMMessage] {
        return try await withCheckedThrowingContinuation({ continuation in
            messages { messages, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                guard let messages = messages else {
                    return continuation.resume(throwing: SailthruMobileError.nilValue)
                }
                
                continuation.resume(returning: messages)
            }
        })
    }
    
    /**
     *  Removes the message with the given messageID from the Message Stream
     *
     *  - Parameter message: The message to be removed.
     *  - Throws: Error when call fails.
     **/
    public func remove(message: STMMessage) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            remove(message, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
}
