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
 * Dummy override to allow testing of concurrency methods.
 */
class DummyMarigold : Marigold {
    public var responseError: Error? = nil
    public var deviceId: String? = nil
    public var vars: [String: Any]? = nil
    
    public var calledFunctions: [String] = []
    public var parameters: [Any?] = []
    
    public override func deviceID(_ completion: @escaping (String?, Error?) -> Void) {
        calledFunctions.append(#function)
        completion(deviceId, responseError)
    }
    
    public override func setGeoIPTrackingEnabled(_ enabled: Bool, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(enabled)
        block?(responseError)
    }
    
    public override func setDevelopmentDeviceWithResponse(_ block: ((Error?) -> Void)?) {
        calledFunctions.append(#function)
        block?(responseError)
    }
}
