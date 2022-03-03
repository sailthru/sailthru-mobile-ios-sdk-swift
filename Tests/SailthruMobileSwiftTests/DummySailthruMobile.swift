//
//  DummySailthruMobile.swift
//  
//
//  Created by Ian Stewart on 3/03/22.
//

import SailthruMobile

/**
 * Dummy override to allow testing of concurrency methods.
 */
class DummySailthruMobile : SailthruMobile {
    public var responseError: Error? = nil
    public var deviceId: String? = nil
    public var recommendations: [STMContentItem]? = nil
    public var vars: [String: Any]? = nil
    
    public var calledFunctions: [String] = []
    public var parameters: [Any?] = []
    
    public override func setAttributes(_ attributes: STMAttributes, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(attributes)
        block?(responseError)
    }
    
    public override func removeAttribute(withKey key: String, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(key)
        block?(responseError)
    }
    
    public override func clear(_ types: STMDeviceDataType, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(types)
        block?(responseError)
    }
    
    public override func deviceID(_ completion: @escaping (String?, Error?) -> Void) {
        calledFunctions.append(#function)
        completion(deviceId, responseError)
    }
    
    public override func setUserId(_ userId: String?, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(userId)
        block?(responseError)
    }
    
    public override func setUserEmail(_ userEmail: String?, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(userEmail)
        block?(responseError)
    }
    
    public override func recommendations(withSection sectionID: String, withResponse block: (([STMContentItem]?, Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(sectionID)
        block?(recommendations, responseError)
    }
    
    public override func trackPageview(with url: URL, andTags tags: [String], andResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(url)
        parameters.append(tags)
        block?(responseError)
    }
    
    public override func trackPageview(with url: URL, andResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(url)
        block?(responseError)
    }
    
    public override func trackImpression(withSection sectionID: String, andUrls urls: [URL], andResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(sectionID)
        parameters.append(urls)
        block?(responseError)
    }
    
    public override func trackImpression(withSection sectionID: String, andResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(sectionID)
        block?(responseError)
    }
    
    public override func trackClick(withSection sectionID: String, andUrl url: URL, andResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(sectionID)
        parameters.append(url)
        block?(responseError)
    }
    
    public override func setProfileVars(_ vars: [String : Any], withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(vars)
        block?(responseError)
    }
    
    public override func getProfileVars(response block: (([String : Any]?, Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        block?(vars, responseError)
    }
    
    public override func setGeoIPTrackingEnabled(_ enabled: Bool, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(enabled)
        block?(responseError)
    }
    
    public override func logPurchase(_ purchase: STMPurchase, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(purchase)
        block?(responseError)
    }
    
    public override func logAbandonedCart(_ purchase: STMPurchase, withResponse block: ((Error?) -> Void)? = nil) {
        calledFunctions.append(#function)
        parameters.append(purchase)
        block?(responseError)
    }
    
    public override func setDevelopmentDeviceWithResponse(_ block: ((Error?) -> Void)?) {
        calledFunctions.append(#function)
        block?(responseError)
    }
}
