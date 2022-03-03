//
//  File.swift
//  
//
//  Created by Ian Stewart on 3/03/22.
//

import SailthruMobile

class DummySTMMessageStream : STMMessageStream {
    public var responseError: Error? = nil
    public var count: UInt = 0
    public var messages: [STMMessage]? = nil
    
    public var calledFunctions: [String] = []
    public var parameters: [Any?] = []
    
    public override func unreadCount(_ handler: @escaping (UInt, Error?) -> Void) {
        calledFunctions.append(#function)
        handler(count, responseError)
    }
    
    public override func markMessages(asRead messages: [STMMessage], withResponse handler: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(messages)
        handler?(responseError)
    }
    
    public override func messages(_ block: @escaping ([STMMessage]?, Error?) -> Void) {
        calledFunctions.append(#function)
        block(messages, responseError)
    }
    
    public override func remove(_ message: STMMessage, withResponse handler: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(message)
        handler?(responseError)
    }
    
}
