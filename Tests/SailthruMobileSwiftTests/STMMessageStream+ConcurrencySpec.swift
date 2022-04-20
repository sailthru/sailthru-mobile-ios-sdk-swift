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

import XCTest
@testable import SailthruMobile
@testable import SailthruMobileSwift

final class STMMessageStreamConcurrencySpec: XCTestCase {
    var subject = DummySTMMessageStream()
    
    override func setUp() {
        subject = DummySTMMessageStream()
    }
    
    func test_unreadCount_callsCorrectMethod() async throws {
        subject.count = 45
        let unreadCount = try await subject.unreadCount()
        
        checkMethodCalled(with: "unreadCount")
        XCTAssertEqual(45, unreadCount)
    }
    
    func test_setAttributes_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            _ = try await subject.unreadCount()
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_markAsReadMessage_callsCorrectMethod() async throws {
        let message = STMMessage()
        try await subject.mark(asRead: message)
        
        checkMethodCalled(with: "markMessages")
        XCTAssertEqual([message], subject.parameters.first as? [STMMessage])
    }
    
    func test_markAsReadMessage_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let message = STMMessage()
        do {
            try await subject.mark(asRead: message)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_markAsReadMessages_callsCorrectMethod() async throws {
        let messages = [
            STMMessage(),
            STMMessage(),
            STMMessage(),
        ]
        try await subject.mark(asRead: messages)
        
        checkMethodCalled(with: "markMessages")
        XCTAssertEqual(messages, subject.parameters.first as? [STMMessage])
    }
    
    func test_markAsReadMessages_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let messages = [
            STMMessage(),
            STMMessage(),
            STMMessage(),
        ]
        do {
            try await subject.mark(asRead: messages)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_messages_callsCorrectMethod() async throws {
        subject.messages = [
            STMMessage(),
            STMMessage(),
            STMMessage(),
        ]
        let messages = try await subject.messages()
        
        checkMethodCalled(with: "messages")
        XCTAssertEqual(subject.messages, messages)
    }
    
    func test_messages_throwsOnNilMessages() async throws {
        do {
            _ = try await subject.messages()
            XCTFail("Should throw provided error")
        } catch SailthruMobileError.nilValue {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_messages_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            _ = try await subject.messages()
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_removeMessage_callsCorrectMethod() async throws {
        let message = STMMessage()
        try await subject.remove(message: message)
        
        checkMethodCalled(with: "remove")
        XCTAssertEqual(message, subject.parameters.first as? STMMessage)
    }
    
    func test_removeMessage_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let message = STMMessage()
        do {
            try await subject.remove(message: message)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    
    // MARK: Helpers
    
    func checkMethodCalled(with name: String) {
        XCTAssertEqual(1, subject.calledFunctions.count)
        XCTAssertTrue(subject.calledFunctions.first?.contains(name) ?? false, "\(name) not found in called function list")
    }
}


