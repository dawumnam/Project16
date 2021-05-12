//
//  ViewController.swift
//  Project16
//
//  Created by Dawum Nam on 5/11/21.
//

import MapKit
import UIKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate {


    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),info: "Hoem to the 2021 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75),info: "Founded over a thousand  years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508),info: "Often called the City of Light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5),info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington,_D.C.", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667),info: "Named after George himself")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(mapTypeTapped))

        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            annotationView?.annotation = annotation
        }
        guard let av = annotationView as? MKPinAnnotationView else { return nil }
        av.pinTintColor = UIColor.darkGray
        return av
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let wv = WebViewController()
        let url = URL(string:"https://en.m.wikipedia.org/wiki/\(placeName!)")
        wv.url = URLRequest(url: url!)
        self.navigationController?.pushViewController(wv, animated: true)
        

        
    }
    
    @objc func mapTypeTapped() {
        let ac = UIAlertController(title:"change map style", message: "", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "hybrid", style: .default) { [weak self] _ in self?.mapView.mapType = .hybrid })
        ac.addAction(UIAlertAction(title: "hybrid flyover", style: .default) { [weak self] _ in self?.mapView.mapType = .hybridFlyover })
        ac.addAction(UIAlertAction(title: "muted standard", style: .default) { [weak self] _ in self?.mapView.mapType = .mutedStandard })
        ac.addAction(UIAlertAction(title: "satellite", style: .default) { [weak self] _ in self?.mapView.mapType = .satellite })
        ac.addAction(UIAlertAction(title: "satellite flyover", style: .default) { [weak self] _ in self?.mapView.mapType = .satelliteFlyover })
        ac.addAction(UIAlertAction(title: "standard", style: .default) { [weak self] _ in self?.mapView.mapType = .standard })
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        present(ac, animated: true)
    }

}

