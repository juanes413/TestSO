//
//  MockCountriesViewModel.swift
//  Test TestSO
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//

import Foundation
@testable import TestSO

class MockCountriesViewModel: CountriesViewModel {
    
    var countries: [Country]?
    
    override init(viewModelToViewBinding: ServicesViewModelToViewBinding, apiServices: APIService = APIService()) {
        super.init(viewModelToViewBinding: viewModelToViewBinding)
    }
    
    override func getAllCountriesFromService() {
        if let countries = countries {
            viewModelToViewBinding?.serviceCountriesResult(results: countries)
        } else {
            viewModelToViewBinding?.serviceError()
        }
    }
    
}
