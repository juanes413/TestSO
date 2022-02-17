//
//  CountriesViewModel.swift
//  TestSO
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//

import Foundation

class CountriesViewModel {
    
    var viewModelToViewBinding: ServicesViewModelToViewBinding?
    private var apiServices: APIService
    
    init(viewModelToViewBinding: ServicesViewModelToViewBinding, apiServices:APIService = APIService()) {
        self.viewModelToViewBinding = viewModelToViewBinding
        self.apiServices = apiServices
    }
    
    //Invocar servicio api para obtener todos los paises
    func getAllCountriesFromService() {
        apiServices.downloadCountries(completion: { [weak self] success, model in
            if success, let data = model {
                self?.viewModelToViewBinding?.serviceCountriesResult(results: data)
            } else {
                self?.viewModelToViewBinding?.serviceError()
            }
        })
    }
    
}
// MARK: - Protocols
protocol ServicesViewModelToViewBinding: AnyObject {
    func serviceCountriesResult(results: [Country])
    func serviceError()
}
//Extension para volver los metodos abstractos e invocar solo los necesarios para cada vista o experiencia
extension ServicesViewModelToViewBinding {
    func serviceCountriesResult(results: [Country]){}
    func serviceError(){}
}
