
//
//  FirstVC.swift
//  WriteReviewOnGoogle
//
//  Created by Kondya on 07/03/19.
//  Copyright © 2019 Kondya. All rights reserved.
//

import UIKit

import GooglePlaces

class FirstVC: UIViewController,ViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func areaLocationBtnclicked(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    @IBAction func ation(_ sender: UIButton) {
        
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        {
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func getViewControllerResultSuccess() {
        
        self.showAlertButtonTapped(message: "Google Review Submited Successfully")
        
    }
    
    func showAlertButtonTapped(message:String) {
        
        // create the alert
        //"Google Review Submited Successfully"
        let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}



extension FirstVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        print("Place name: \(place.name)")
//        print("Place address: \(String(describing: place.formattedAddress))")
//        print("Place attributions: \(String(describing: place.attributions))")
//        print("Place latitiude: \(place.coordinate.longitude)")
//        print("Place logitude: \(place.coordinate.latitude)")
        print("Place ID: \(place.placeID ?? "Place id not found")")
        
//        if let pID = place.placeID {
//            
////            self.placeUrl = "https://search.google.com/local/writereview?placeid=\(pID)"
//            
//        }
        
        dismiss(animated: true, completion: nil)
       
        
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
