//
//  CountriesTableViewControllerTests.swift
//  TestSOTests
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//

import XCTest
@testable import TestSO

class CountriesTableViewControllerTests: XCTestCase {

    private var sut: CountriesTableViewController!
    private var viewModel: MockCountriesViewModel!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "contriesTableViewController") as? CountriesTableViewController else {
            XCTFail("Could not instantiate viewController as SearchViewController")
            return
        }
        sut = viewController
        sut.loadViewIfNeeded()
        
        viewModel = MockCountriesViewModel(viewModelToViewBinding: sut)
        
        sut.viewModel = viewModel
    }
    
    func test_errorServices() {
        viewModel.getAllCountriesFromService()
    }
    
    func test_newSearchError() {
        let countryCO = Country(name: "Colombia", capital: "Bogota", subregion: "", region: "America", population: 400000, latlng: [4.0, -72.0])
        viewModel.countries = [countryCO]
        viewModel.getAllCountriesFromService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
