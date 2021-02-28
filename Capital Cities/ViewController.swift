//
//  ViewController.swift
//  Capital Cities
//
//  Created by Gökberk Köksoy on 28.02.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275))
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75))
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508))
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5))
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
        title = "Capital Cities (Only 5 of Them)"
        
    }
    
    @objc func editPressed() {
        let alert = UIAlertController(title: "Change the Map Type", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { _ in
            self.mapView.mapType = .hybrid
        }))
        alert.addAction(UIAlertAction(title: "Standard", style: .default, handler: { _ in
            self.mapView.mapType = .standard
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil}
        let identifier = "Capital"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = .red
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let vc = WebViewController()
        vc.city = placeName
        navigationController?.pushViewController(vc, animated: true)
        
    }


}

