//
//  SailthruMobile+Concurrency.swift
//  SailthruMobileSwift
//
//  Created by Ian Stewart on 2/03/22.
//

import SailthruMobile

/**
 * Extensions to allow asynchronous functionality to be used with Swift Concurrency.
 */
extension SailthruMobile {
    
    
    // MARK: Attributes
    
    /**
     *  Asyncronously sets a STMAttributes object with Sailthru Mobile.
     *
     *  - Parameter attributes: An STMAttributes object with the desired attributes set.
     *  - Throws: Error when call fails.
     */
    public func set(attributes: STMAttributes) async throws {
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
    public func removeAttribute(with key: String) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            removeAttribute(withKey: key, withResponse: ClosureBuilder.voidErrorClosure(continuation))
        })
    }
    
    
    // MARK: Device
    
    /**
     *  Asyncronously clears any of the Attribute, Message Stream, or Event data from the device.
     *
     *  Use this method to clear the device attributes after user logout.
     *
     *  - Parameter types: A bitwise OR collection of STMDeviceDataType dictating which sets of data to clear.
     *  - Throws: Error when call fails.
     **/
    public func clearDeviceData(for types: STMDeviceDataType) async throws {
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
                    return continuation.resume(throwing: SailthruMobileError.nilValue)
                }
                guard !deviceId.isEmpty else {
                    return continuation.resume(throwing: SailthruMobileError.emptyValue)
                }
                
                continuation.resume(returning: deviceId)
            }
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
    
    
    // MARK: Recommendations
    
    /**
     *  Returns: the output from a Site Personalisation Manager section, an array of recommendations for the given user.
     *
     *  It is suggested you use this in conjunction with setEmail: to identify the user to Sailthru.
     *
     *  - Parameter sectionId: An SPM section ID. The section must be set up to use JSON as the output format.
     *  - Returns: Array of STMContentItems representing recommendations.
     *  - Throws: Error when call fails.
     **/
    public func recommendations(with sectionId: String) async throws -> [STMContentItem] {
        return try await withCheckedThrowingContinuation({ continuation in
            recommendations(withSection: sectionId) { contentItems, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                guard let contentItems = contentItems else {
                    return continuation.resume(throwing: SailthruMobileError.nilValue)
                }
                
                continuation.resume(returning: contentItems)
            }
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
                    return continuation.resume(throwing: SailthruMobileError.nilValue)
                }
                
                return continuation.resume(returning: profileVars)
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
    
    
    // MARK: Purchases
    
    /**
     *  Logs a purchase with Sailthru platform. This can be used for mobile purchase attribution.
     *
     *  - Parameter purchase: The purchase to log with the platform.
     *  - Throws: Error when call fails.
     **/
    public func log(purchase: STMPurchase) async throws {
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
    public func log(abandonedCart: STMPurchase) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            logAbandonedCart(abandonedCart, withResponse: ClosureBuilder.voidErrorClosure(continuation))
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
