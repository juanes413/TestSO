//
//  MapKitViewControllerTests.swift
//  TestSOTests
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//

import XCTest
@testable import TestSO

class MapKitViewControllerTests: XCTestCase {

    private var sut: MapKitViewController!

    override func setUp() {
        super.setUp()
        
        sut = MapKitViewController()
        sut.lat = 4.0
        sut.lng = -72.0
        sut.loadViewIfNeeded()
    }
    
    func test_openMap() {
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
