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

import Marigold

/**
 * Extensions to allow asynchronous functionality to be used with Swift Concurrency.
 */
extension Marigold {
    
    // MARK: Device
    
    /**
     *  Asyncronously clears any of the Message Stream or Event data from the device.
     *
     *  Use this method to clear the device attributes after user logout.
     *
     *  - Parameter types: A bitwise OR collection of STMDeviceDataType dictating which sets of data to clear.
     *  - Throws: Error when call fails.
     **/
    public func clearDeviceData(for types: MARDeviceDataType) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            clear(types, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Returns: the current device's ID as a String.
     *
     *  - Returns: String containing the device ID.
     *  - Throws: Error when call fails.
     **/
    public func deviceId() async throws -> String {
        return try await withCheckedThrowingContinuation({ continuation in
            deviceID { deviceId, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                guard let deviceId = deviceId else {
                    return continuation.resume(throwing: MarigoldError.nilValue)
                }
                guard !deviceId.isEmpty else {
                    return continuation.resume(throwing: MarigoldError.emptyValue)
                }
                
                continuation.resume(returning: deviceId)
            }
        })
    }
    
    // MARK: Location
    
    /**
     *  Enabled location tracking based on IP Address. Tracking location tracking is enabled by default.
     *
     *  Use this method for users who may not want to have their location tracked at all.
     *
     *  - Parameter geoIpTrackingEnabled: A boolean value indicating whether or not to disable location based on IP Address.
     *  - Throws: Error when call fails.
     **/
    public func set(geoIpTrackingEnabled: Bool) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            setGeoIPTrackingEnabled(geoIpTrackingEnabled, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    
    // MARK: Development
    
#if DEBUG
    
    /**
     *  Marks this device as a development device on the platform. This will instruct the platform to send push notifications to the development APNS server for this device.\
     *
     *  - Warning: This method should not be called in builds that will point to the APNS production environment, use only in debug or test builds.
     *  - Throws: Error when call fails.
     **/
    public func setDevelopmentDevice() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            setDevelopmentDeviceWithResponse(ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
#endif
}
