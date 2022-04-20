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
@testable import SailthruMobile
@testable import SailthruMobileSwift

enum TestErrors : Error {
    case testError
}

final class SailthruMobileConcurrencyTests: XCTestCase {
    var subject = DummySailthruMobile()
    
    override func setUp() {
        subject = DummySailthruMobile()
    }
    
    
    // MARK: Attributes
    
    func test_setAttributes_callsCorrectMethod() async throws {
        let attributes = STMAttributes()
        attributes.setString("yo", forKey: "hi")
        try await subject.set(attributes: attributes)
        
        checkMethodCalled(with: "setAttributes")
        XCTAssertEqual(attributes, subject.parameters.first as? STMAttributes)
    }
    
    func test_setAttributes_throwsOnError() async throws {
        let attributes = STMAttributes()
        attributes.setString("yo", forKey: "hi")
        
        subject.responseError = TestErrors.testError
        do {
            try await subject.set(attributes: attributes)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_removeAttributeWithKey_callsCorrectMethod() async throws {
        let attributeKey = "something"
        try await subject.removeAttribute(with: attributeKey)
        
        checkMethodCalled(with: "removeAttribute")
        XCTAssertEqual(attributeKey, subject.parameters.first as? String)
    }
    
    func test_removeAttributeWithKey_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            try await subject.removeAttribute(with: "something")
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    
    // MARK: Device
    
    func test_clearDeviceDataForTypes_callsCorrectMethod() async throws {
        try await subject.clearDeviceData(for: .attributes)
        
        checkMethodCalled(with: "clear")
        XCTAssertEqual(STMDeviceDataType.attributes, subject.parameters.first as? STMDeviceDataType)
    }
    
    func test_clearDeviceDataForTypes_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            try await subject.removeAttribute(with: "something")
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
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
        } catch SailthruMobileError.nilValue {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_deviceId_throwsOnEmptyId() async throws {
        subject.deviceId = ""
        do {
            _ = try await subject.deviceId()
            XCTFail("Should throw provided error")
        } catch SailthruMobileError.emptyValue {
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
    
    func test_setUserId_callsCorrectMethod() async throws {
        let userId = "whoozit"
        try await subject.set(userId: userId)
        
        checkMethodCalled(with: "setUserId")
        XCTAssertEqual(userId, subject.parameters.first as? String)
    }
    
    func test_setUserId_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            try await subject.set(userId: "whoozit")
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_setUserEmail_callsCorrectMethod() async throws {
        let userEmail = "whoozit@whatsit.com"
        try await subject.set(userEmail: userEmail)
        
        checkMethodCalled(with: "setUserEmail")
        XCTAssertEqual(userEmail, subject.parameters.first as? String)
    }
    
    func test_setUserEmail_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            try await subject.set(userEmail: "whoozit@whatsit.com")
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    
    // MARK: Recommendations
    
    func test_recommendationsWithSection_callsCorrectMethod() async throws {
        subject.recommendations = [
            STMContentItem()
        ]
        let sectionId = "the-best-section"
        
        let recommendations = try await subject.recommendations(with: sectionId)
        
        checkMethodCalled(with: "recommendations")
        XCTAssertEqual(sectionId, subject.parameters.first as? String)
        XCTAssertEqual(subject.recommendations, recommendations)
    }
    
    func test_recommendationsWithSection_throwsOnNilRecommendations() async throws {
        do {
            _ = try await subject.recommendations(with: "the-best-section")
            XCTFail("Should throw provided error")
        } catch SailthruMobileError.nilValue {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_recommendationsWithSection_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        do {
            _ = try await subject.recommendations(with: "the-best-section")
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_trackPageviewWithUrlTags_callsCorrectMethod() async throws {
        let url = URL.init(string: "www.something.com")!
        let tags = ["tag1", "tag2", "tag3"]
        try await subject.trackPageview(with: url, tags: tags)
        
        checkMethodCalled(with: "trackPageview")
        checkMethodCalled(with: "andTags")
        XCTAssertEqual(url, subject.parameters.first as? URL)
        XCTAssertEqual(tags, subject.parameters[1] as? [String])
    }
    
    func test_trackPageviewWithUrlTags_noTags_callsCorrectMethod() async throws {
        let url = URL.init(string: "www.something.com")!
        try await subject.trackPageview(with: url)
        
        checkMethodCalled(with: "trackPageview")
        XCTAssertEqual(url, subject.parameters.first as? URL)
        XCTAssertEqual(1, subject.parameters.count)
    }
    
    func test_trackPageviewWithUrlTags_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let url = URL.init(string: "www.something.com")!
        let tags = ["tag1", "tag2", "tag3"]
        do {
            try await subject.trackPageview(with: url, tags: tags)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_trackPageviewWithUrlTags_noTags_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let url = URL.init(string: "www.something.com")!
        do {
            try await subject.trackPageview(with: url)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_impressionWithSectionIdUrls_callsCorrectMethod() async throws {
        let sectionId = "the-best-section"
        let urls = [
            URL.init(string: "www.something1.com")!,
            URL.init(string: "www.something2.com")!,
            URL.init(string: "www.something3.com")!,
        ]
        try await subject.trackImpression(with: sectionId, urls: urls)
        
        checkMethodCalled(with: "trackImpression")
        checkMethodCalled(with: "andUrls")
        XCTAssertEqual(sectionId, subject.parameters.first as? String)
        XCTAssertEqual(urls, subject.parameters[1] as? [URL])
    }
    
    func test_impressionWithSectionIdUrls_noUrls_callsCorrectMethod() async throws {
        let sectionId = "the-best-section"
        try await subject.trackImpression(with: sectionId)
        
        checkMethodCalled(with: "trackImpression")
        XCTAssertEqual(sectionId, subject.parameters.first as? String)
        XCTAssertEqual(1, subject.parameters.count)
    }
    
    func test_impressionWithSectionIdUrls_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let sectionId = "the-best-section"
        let urls = [
            URL.init(string: "www.something1.com")!,
            URL.init(string: "www.something2.com")!,
            URL.init(string: "www.something3.com")!,
        ]
        do {
            try await subject.trackImpression(with: sectionId, urls: urls)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_impressionWithSectionIdUrls_noUrls_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let sectionId = "the-best-section"
        do {
            try await subject.trackImpression(with: sectionId)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_trackClick_callsCorrectMethod() async throws {
        let sectionId = "the-best-section"
        let url = URL.init(string: "www.something.com")!
        try await subject.trackClick(with: sectionId, url: url)
        
        checkMethodCalled(with: "trackClick")
        XCTAssertEqual(sectionId, subject.parameters.first as? String)
        XCTAssertEqual(url, subject.parameters[1] as? URL)
    }
    
    func test_trackClick_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let sectionId = "the-best-section"
        let url = URL.init(string: "www.something.com")!
        do {
            try await subject.trackClick(with: sectionId, url: url)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    
    // MARK: Profile Vars
    
    func test_setProfileVars_callsCorrectMethod() async throws {
        let vars = [
            "varKey": "varVal",
            "numKey": 123,
        ] as [String : Any]
        try await subject.set(profileVars: vars)
        
        checkMethodCalled(with: "setProfileVars")
        let methodVars = subject.parameters.first as? [String: Any]
        XCTAssertEqual("varVal", methodVars?["varKey"] as? String)
        XCTAssertEqual(123, methodVars?["numKey"] as? Int)
    }
    
    func test_setProfileVars_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let vars = [
            "varKey": "varVal",
            "numKey": 123,
        ] as [String : Any]
        do {
            try await subject.set(profileVars: vars)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_profileVars_callsCorrectMethod() async throws {
        subject.vars = [
            "varKey": "varVal",
            "numKey": 123,
        ] as [String : Any]
        let vars = try await subject.profileVars()
        
        checkMethodCalled(with: "getProfileVars")
        XCTAssertEqual("varVal", vars["varKey"] as? String)
        XCTAssertEqual(123, vars["numKey"] as? Int)
    }
    
    func test_profileVars_throwsOnNilVars() async throws {
        do {
            _ = try await subject.profileVars()
            XCTFail("Should throw provided error")
        } catch SailthruMobileError.nilValue {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_profileVars_throwsOnError() async throws {
        subject.vars = [
            "varKey": "varVal",
            "numKey": 123,
        ] as [String : Any]
        subject.responseError = TestErrors.testError
        do {
            _ = try await subject.profileVars()
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
    
    
    // MARK: Purchases
    
    func test_logPurchase_callsCorrectMethod() async throws {
        let purchaseItems = [
            STMPurchaseItem(quantity: 1, title: "item", price: 123, itemId: "1234", itemUrl: URL.init(string: "www.something.com/item1")!)!
        ]
        let purchase = STMPurchase(purchaseItems: purchaseItems)!
        try await subject.log(purchase: purchase)
        
        checkMethodCalled(with: "logPurchase")
        XCTAssertEqual(purchase, subject.parameters.first as? STMPurchase)
    }
    
    func test_logPurchase_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let purchase = STMPurchase(purchaseItems: [])!
        do {
            try await subject.log(purchase: purchase)
            XCTFail("Should throw provided error")
        } catch TestErrors.testError {
        } catch {
            XCTFail("Incorrect error thrown: \(error)")
        }
    }
    
    func test_logAbandonedCart_callsCorrectMethod() async throws {
        let purchaseItems = [
            STMPurchaseItem(quantity: 1, title: "item", price: 123, itemId: "1234", itemUrl: URL.init(string: "www.something.com/item1")!)!
        ]
        let purchase = STMPurchase(purchaseItems: purchaseItems)!
        try await subject.log(abandonedCart: purchase)
        
        checkMethodCalled(with: "logAbandonedCart")
        XCTAssertEqual(purchase, subject.parameters.first as? STMPurchase)
    }
    
    func test_logAbandonedCart_throwsOnError() async throws {
        subject.responseError = TestErrors.testError
        let purchase = STMPurchase(purchaseItems: [])!
        do {
            try await subject.log(abandonedCart: purchase)
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
