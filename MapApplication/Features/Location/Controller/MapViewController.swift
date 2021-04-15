//
//  MapViewController.swift
//  MapApplication
//
//  Created by Анастасия Корнеева on 15.04.21.
//

import MapKit
import SnapKit

class MapViewController: ViewController {

    //MARK: - gui variables

    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self

        return view
    }()

    override func initController() {
        super.initController()

        self.controllerTitle = "Map"

        self.view.addSubview(self.mapView)

        self.mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.createAnntation()

        LocationManager.sh.getUserLocation(  locationHandler: { [weak self] location in
            let annotetion = MapAnnotation(title: "1",
                                           subtitle: "first",
                                           coordinate: location.coordinate)
            self?.mapView.addAnnotation(annotetion)
            self?.mapView.setCenter(location.coordinate, animated: true)
        })
    }

    private func createAnntation() {
        let cordinate = CLLocationCoordinate2D(latitude: 53.88242, longitude: 27.54878)

let annotation = MapAnnotation(title: "Test title",
                               subtitle: "The best title",
                               coordinate: cordinate)

        self.mapView.addAnnotation(annotation)

        self.mapView.setCenter(cordinate, animated: false)
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        Swift.debugPrint(view.annotation?.coordinate)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation  = annotation as? MapAnnotation else { return nil }

        var annotationView: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: MapAnnotation.identifier) as? MKMarkerAnnotationView {
            annotationView = dequeuedView
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation,
                                                 reuseIdentifier: MapAnnotation.identifier)
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let controller = WebViewController(stringUrl: "https://google.com", title: "web view")

        self.navigationController?.pushViewController(controller, animated: true)
    }
}
