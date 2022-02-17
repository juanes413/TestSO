//
//  ViewController.swift
//  TestSO
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    private var countries = [Country]()
    private var countriesFiltered = [Country]()
    
    lazy var viewModel = {
        CountriesViewModel(viewModelToViewBinding: self)
    }()
    
    private enum ReuseIdentifiers: String {
        case countryItemUITableViewCell
    }
    
    private let openMapExternalAPP = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Se inicializan los componentes UI
        configureSearchBar()
        configureTableView()
        
        viewModel.getAllCountriesFromService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - ModelToViewBinding
extension CountriesTableViewController: ServicesViewModelToViewBinding {
    
    func serviceCountriesResult(results: [Country]) {
        self.countries = results
        self.countriesFiltered = results
        self.reloadData()
    }
    
    func serviceError() {
        self.countries.removeAll()
        self.countriesFiltered.removeAll()
        self.reloadData()
    }
    
}
// MARK: - UITableView
extension CountriesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if countriesFiltered.count == 0 {
            tableView.setEmptyMessage("No hay información que mostrar")
        } else {
            tableView.restore()
        }
        
        return countriesFiltered.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.countryItemUITableViewCell.rawValue, for: indexPath) as? CountryItemUITableViewCell else {
            return UITableViewCell()
        }
        
        let item = countriesFiltered[indexPath.row]
        cell.labelName.text = item.name.uppercased()
        cell.labelCapital.text = item.capital
        cell.labelRegion.text = item.region.uppercased()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = countriesFiltered[indexPath.row]
        
        if let latlng = item.latlng, latlng.count == 2 {
            let lat = latlng[0]
            let lng = latlng[1]
            
            //Abrir map con una aplicacion externa (Apple map o google map)
            if (openMapExternalAPP) {
                OpenMapCountry.present(in: self, lat: lat, lng: lng)
            } else {
                //Abrir maps de apple en una nueva vista
                let mapViewController = MapKitViewController()
                mapViewController.lat = lat
                mapViewController.lng = lng
                self.navigationController?.pushViewController(mapViewController, animated: true)
            }
        }
    }
    
}
// MARK: - SearchResult
extension CountriesTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty {
            countriesFiltered = countries.filter {
                item in return (item.name.lowercased().contains(searchText))
            }
        } else {
            countriesFiltered = countries
        }
        self.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        countriesFiltered = countries
        self.reloadData()
    }
    
}
// MARK: - UI
extension CountriesTableViewController {
    
    //Configuracion UI, se agrega un searchcontroller para el buscador
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.setNewcolor(color: UIColor.black)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationItem.searchController?.searchBar.delegate = self
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.definesPresentationContext = true
    }
    
    //Configuracion de la tableView
    private func configureTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsMultipleSelection = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //Refrescar informacion
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

