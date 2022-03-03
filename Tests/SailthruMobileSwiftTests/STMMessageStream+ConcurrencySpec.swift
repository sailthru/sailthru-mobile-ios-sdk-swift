//
//  STMMessageStream+ConcurrencySpec.swift
//  
//
//  Created by Ian Stewart on 3/03/22.
//

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


