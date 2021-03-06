//
//  PathViewController.swift
//  Kml
//
//  Created by Koki Ibukuro on 8/18/15.
//  Copyright (c) 2015 asus4. All rights reserved.
//

import UIKit
import MapKit

// Path to MKPolylineRenderer
// Polygon to MKPolygonRenderer
class PathViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadKml("sample")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func loadKml(path: String) {
        let url = NSBundle.mainBundle().URLForResource(path, withExtension: "kml")
        KMLDocument.parse(url!, callback:
            { [unowned self] (KMLDocument kml) in
                // Add overlays
                self.mapView.addOverlays(kml.overlays)
                // Add annotations
                self.mapView.showAnnotations(kml.annotations, animated: true)
            }
        )
    }
}

extension PathViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if let overlayPolyline = overlay as? KMLOverlayPolyline {
            // return MKPolylineRenderer
            return overlayPolyline.renderer()
        }
        if let overlayPolygon = overlay as? KMLOverlayPolygon {
            // return MKPolygonRenderer
            return overlayPolygon.renderer()
        }
        else {
            return nil
        }
    }
}