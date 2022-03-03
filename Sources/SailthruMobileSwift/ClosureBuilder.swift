//
//  ClosureBuilder.swift
//  SailthruMobileSwift
//
//  Created by Ian Stewart on 2/03/22.
//

import Foundation

class ClosureBuilder {
    /**
     * Build closure to handle callbacks with for type Result<Void,Error>
     */
    class func voidErrorClosure(_ continuation: CheckedContinuation<Void, Error>) -> (Error?) -> Void {
        return { error in
            if let error = error {
                return continuation.resume(throwing: error)
            }
            return continuation.resume()
        }
    }
}
