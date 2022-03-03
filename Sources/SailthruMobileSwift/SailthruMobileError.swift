//
//  SailthruMobileError.swift
//  SailthruMobileSwift
//
//  Created by Ian Stewart on 2/03/22.
//

import Foundation

public enum SailthruMobileError: Error {
    /// Value is unexpectedly nil
    case nilValue
    /// Value is unexpectedly empty
    case emptyValue
}
