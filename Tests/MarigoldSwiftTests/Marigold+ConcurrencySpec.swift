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
@testable import Marigold
@testable import MarigoldSwift

enum TestErrors : Error {
    case testError
}

final class MarigoldConcurrencyTests: XCTestCase {
    var subject = DummyMarigold()
    
    override func setUp() {
        subject = DummyMarigold()
    }

    // MARK: Device
    
    func test_deviceId_callsCorrectMethod() async throws {
        subject.deviceId = "1234"
        let deviceId = try await subject.deviceId()
        
        checkMethodCalled(with: "deviceID")
        XCTAssertEqual(subject.deviceId, deviceId)
    }
    
    func test_deviceId_throwsOnNilId() async throws {
        do {
            _ = try await subject.deviceId()
            XCTFail("Should throw provided error")
        } catch MarigoldError.nilValue {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_deviceId_throwsOnEmptyId() async throws {
        subject.deviceId = ""
        do {
            _ = try await subject.deviceId()
            XCTFail("Should throw provided error")
        } catch MarigoldError.emptyValue {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_deviceId_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            _ = try await subject.deviceId()
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    // MARK: Location
    
    func test_setGeoIpTrackingEnabled_callsCorrectMethod() async throws {
        try await subject.set(geoIpTrackingEnabled: false)
        
        checkMethodCalled(with: "setGeoIPTrackingEnabled")
        XCTAssertEqual(false, subject.parameters.first as? Bool)
    }
    
    func test_setGeoIpTrackingEnabled_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            try await subject.set(geoIpTrackingEnabled: false)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_setDevelopmentDevice_callsCorrectMethod() async throws {
        try await subject.setDevelopmentDevice()
        
        checkMethodCalled(with: "setDevelopmentDeviceWithResponse")
    }
    
    func test_setDevelopmentDevice_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            try await subject.setDevelopmentDevice()
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
