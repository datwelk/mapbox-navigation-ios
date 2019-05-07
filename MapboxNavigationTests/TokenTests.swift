import XCTest
import MapboxMobileEvents
@testable import MapboxCoreNavigation
@testable import MapboxDirections
@testable import MapboxSpeech
#if canImport(MapboxGeocoder)
@testable import MapboxGeocoder
#endif


class TokenTests: XCTestCase {
    
    func testSpeechToken() {
        let originalToken = MBXSKUToken.navigationToken
        XCTAssertNotNil(originalToken)
        
        NavigationSettings.shared.skuToken = originalToken

        let speech = SpeechSynthesizer(accessToken: "foo")
        let speechURL = speech.url(forSynthesizing: SpeechOptions(text: "bar"))
        let components = URLComponents(url: speechURL, resolvingAgainstBaseURL: true)
        let queryItems = components?.queryItems
        let skuToken = queryItems?.filter { $0.name == "sku" }.first
        
        XCTAssertEqual(skuToken?.value, originalToken, "sku token should be equal to the original token")
        
        NavigationSettings.shared.skuToken = nil
        
        let unsetTokenURL = speech.url(forSynthesizing: SpeechOptions(text: "bar"))
        let unsetTokenComponents = URLComponents(url: unsetTokenURL, resolvingAgainstBaseURL: true)
        let unsetQueryItems = unsetTokenComponents?.queryItems
        
        XCTAssertEqual(unsetQueryItems?.filter { $0.name == "sku" }.count, 0, "sku token param should not exist")
    }
    
    func testDirectionsToken() {
        let originalToken = MBXSKUToken.navigationToken
        XCTAssertNotNil(originalToken)
        
        NavigationSettings.shared.skuToken = originalToken
        
        let options = RouteOptions(coordinates: [CLLocationCoordinate2D(latitude: 0, longitude: 1),
                                                 CLLocationCoordinate2D(latitude: 2, longitude: 3)])
        
        let directions = Directions(accessToken: "foo")
        
        let directionsURL = directions.url(forCalculating: options)
        let components = URLComponents(url: directionsURL, resolvingAgainstBaseURL: true)
        let queryItems = components?.queryItems
        let skuToken = queryItems?.filter { $0.name == "sku" }.first
        
        XCTAssertEqual(skuToken?.value, originalToken, "sku token should be equal to the original token")
        
        NavigationSettings.shared.skuToken = nil
        
        let unsetDirectionsURL = directions.url(forCalculating: options)
        let unsetComponents = URLComponents(url: unsetDirectionsURL, resolvingAgainstBaseURL: true)
        let unsetQueryItems = unsetComponents?.queryItems
        
        XCTAssertEqual(unsetQueryItems?.filter { $0.name == "sku" }.count, 0, "sku token query param should not exist")
    }
    
    #if canImport(MapboxGeocoder)
    func testGeocoderToken() {
        let originalToken = MBXSKUToken.navigationToken
        XCTAssertNotNil(originalToken)
        
        NavigationSettings.shared.skuToken = originalToken
        
        let options = ForwardGeocodeOptions(query: "bar")
        let geocoder = Geocoder(accessToken: "foo")
        
        let geocoderURL = geocoder.urlForGeocoding(options)
        let components = URLComponents(url: geocoderURL, resolvingAgainstBaseURL: true)
        let queryItems = components?.queryItems
        let skuToken = queryItems?.filter { $0.name == "sku" }.first
        
        XCTAssertEqual(skuToken?.value, originalToken, "sku token should be equal to the original token")
        
        NavigationSettings.shared.skuToken = nil
        
        let unsetGeocoderURL = geocoder.urlForGeocoding(options)
        let unsetComponents = URLComponents(url: unsetGeocoderURL, resolvingAgainstBaseURL: true)
        let unsetQueryItems = unsetComponents?.queryItems
        
        XCTAssertEqual(unsetQueryItems?.filter { $0.name == "sku" }.count, 0, "sku token query param should not exist")
    }
    #endif
}
