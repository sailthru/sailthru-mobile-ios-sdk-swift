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
extension EngageBySailthru {
    
    // MARK: Attributes
    
    /**
     *  Asyncronously sets a MARAttributes object with Sailthru Mobile.
     *
     *  - Parameter attributes: An MARAttributes object with the desired attributes set.
     *  - Throws: Error when call fails.
     */
    @available(*, deprecated, message: "use setprofileVars: instead")
    public func set(attributes: MARAttributes) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            setAttributes(attributes, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Asyncronously removes a value for a given key.
     *
     *  - Parameter key: The string value of the key.
     *  - Throws: Error when call fails.
     **/
    @available(*, deprecated, message: "use setprofileVars: instead")
    public func removeAttribute(with key: String) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            removeAttribute(withKey: key, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Asyncronously clears the Attribute data from the device.
     *
     *  Use this method to clear the device attributes after user logout.
     *
     *  - Parameter types: A bitwise OR collection of MARDeviceDataType dictating which sets of data to clear.
     *  - Throws: Error when call fails.
     **/
    @available(*, deprecated, message: "use setprofileVars: instead")
    public func clearAttributes() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            clearAttributes(response: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Sets a user ID for the device.
     *
     *  - Parameter userId: The ID of the user to be set.
     *  - Throws: Error when call fails
     **/
    public func set(userId: String?) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            setUserId(userId, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Sets a user email for the device.
     *
     *  - Parameter userEmail: The email of the user to be set.
     *  - Throws: Error when call fails.
     **/
    public func set(userEmail: String?) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            setUserEmail(userEmail, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    // MARK: Events
    
    /**
     * Clear the custom events from the device data.
     */
    public func clearEvents() async throws {
        try await withCheckedThrowingContinuation({ continuation in
            clearEvents(response: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Registers that the given pageview with Sailthru SPM.
     *
     *  - Parameters:
     *     - url: The URL of the content we're tracking a view of. Must be a valid URL with protocol http:// or https:// -
     *          this generally should correspond to the web link of the content being tracked, and the stored URL in the Sailthru content collection.
     *     - tags:  Tags for this content.
     *  - Throws: Error when call fails.
     **/
    public func trackPageview(with url: URL, tags: [String]? = nil) async throws {
        return try await withCheckedThrowingContinuation({ continuation in
            let response = ClosureBuilder.voidErrorClosure(continuation)
            if let tags = tags {
                trackPageview(with: url, andTags: tags, andResponse: response)
            } else {
                trackPageview(with: url, andResponse: response)
            }
        })
    }
    
    /**
     *  Registers an impression - a reasonable expectation that a user has seen a piece of content - with Sailthru SPM.
     *
     *  - Parameters:
     *     - sectionId: the Section ID on Sailthru SPM corresponding to the section being viewed
     *     - urls: a List of the URLs of the items contained within this section. Useful if multiple items
     *             of content are contained within a section, otherwise just pass a single-item array.
     *  - Throws: Error when call fails.
     **/
    public func trackImpression(with sectionId: String, urls: [URL]? = nil) async throws {
        return try await withCheckedThrowingContinuation({ continuation in
            let response = ClosureBuilder.voidErrorClosure(continuation)
            if let urls = urls {
                trackImpression(withSection: sectionId, andUrls: urls, andResponse: response)
            } else {
                trackImpression(withSection: sectionId, andResponse: response)
            }
        })
    }
    
    /**
     *  Tracks with Sailthru SPM that a section has been tapped on, transitioning the user to a detail view
     *
     *  - Parameters:
     *     - sectionId: the Section ID on Sailthru SPM corresponding to the section being tapped
     *     - url: the URL of the detail being transitioned to
     *  - Throws: Error when call fails.
     **/
    public func trackClick(with sectionId: String, url: URL) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            trackClick(withSection: sectionId, andUrl: url, andResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    
    // MARK: Profile Vars
    
    /**
     *  Sets the profile vars on the server.
     *
     *  - Parameter profileVars: the vars to set on the server.
     *  - Throws: Error when call fails.
     **/
    public func set(profileVars: Dictionary<String, Any>) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            setProfileVars(profileVars, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Retrieves the profile vars from the server.
     *
     *  - Returns: Dictionary<String,Any> containing vars.
     *  - Throws: Error when call fails.
     **/
    public func profileVars() async throws -> Dictionary<String, Any> {
        return try await withCheckedThrowingContinuation({ continuation in
            getProfileVars { profileVars, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                guard let profileVars = profileVars else {
                    return continuation.resume(throwing: MarigoldError.nilValue)
                }
                
                return continuation.resume(returning: profileVars)
            }
        })
    }
    
    // MARK: Purchases
    
    /**
     *  Logs a purchase with Sailthru platform. This can be used for mobile purchase attribution.
     *
     *  - Parameter purchase: The purchase to log with the platform.
     *  - Throws: Error when call fails.
     **/
    public func log(purchase: MARPurchase) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            logPurchase(purchase, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    /**
     *  Logs a cart abandonment with the Sailthru platform. Use this to initiate cart abandoned flows.
     *
     *  - Parameter abandonedCart: The abandoned purchase to log with the platform.
     *  - Throws: Error when call fails.
     **/
    public func log(abandonedCart: MARPurchase) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            logAbandonedCart(abandonedCart, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
}
