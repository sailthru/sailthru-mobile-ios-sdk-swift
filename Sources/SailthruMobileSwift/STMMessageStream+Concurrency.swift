// Copyright (c) 2022 Sailthru
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
// (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

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
