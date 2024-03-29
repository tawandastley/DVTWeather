//
//  MapViewController.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/19.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var favPlaces = [MyPlaces]()
    
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        checkLocation()
        loadPlaces()
        setUpDelegates()
        setupLocationManager()
        super.viewDidLoad()
    }
    
    func setUpDelegates() {
        mapView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: COREDATA METHODS
    func savePlace() {
        do {
            try context.save()
        }
        catch{
            print(error)
        }
        self.tableView.reloadData()
    }
    
    func loadPlaces(){
        let request : NSFetchRequest<MyPlaces> = MyPlaces.fetchRequest()
        do {
            favPlaces = try context.fetch(request)
        }catch {
            print(error)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func favTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "New Favourite Place", message: "", preferredStyle: .alert)
        let action = UIAlertAction(
            title: "Add",
            style: .default) { (alert) in
            let newPlace = MyPlaces(context: self.context)
            newPlace.title = textField.text
            newPlace.longitude = self.longitude
            newPlace.latitude = self.latitude
            let currentPlace = FavouritePlaces(
                coordinate: CLLocationCoordinate2D(
                    latitude: self.latitude,
                    longitude: self.longitude),
                title: newPlace.title ?? "favourite place")
            self.mapView.addAnnotation(currentPlace)
            self.favPlaces.append(newPlace)
            self.savePlace()
        }
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel) { ( _ ) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "add favourite place"
            textField = alertTextfield
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: TABLEVIEW DELEGATE METHODS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "favPlace", for: indexPath)
        cell.textLabel?.text = favPlaces[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let latitude = favPlaces[indexPath.row].latitude
        let longitude = favPlaces[indexPath.row].longitude
        let title = favPlaces[indexPath.row].title
        let annotation = FavouritePlaces(
            coordinate: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude),
            title: title ?? "favourite")
        mapView.addAnnotation(annotation)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourcerView, completionHandler) in
            self.context.delete(self.favPlaces[indexPath.row])
            self.favPlaces.remove(at: indexPath.row)
            self.savePlace()
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        self.tableView.reloadData()
        return swipeConfig
    }
}


//MARK: MAPVIEW DELEGATE METHODS

extension MapViewController : CLLocationManagerDelegate,MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            let center = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 4000, longitudinalMeters: 4000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func centerUserLocation() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocation () {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorisation()
        } else {
            
        }
    }
    
    func checkLocationAuthorisation(){
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            centerUserLocation()
            break
        case .denied:
            break
        case .notDetermined:
            break
        case .restricted:
            break
        case .authorizedAlways :
            break
        @unknown default:
            fatalError()
        }
    }
    
}

extension MapViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<MyPlaces> = MyPlaces.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        let decriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [decriptor]
        
        
    }
    
}
