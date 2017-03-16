//
//  ViewController.swift
//  DocShop
//
//  Created by Johann Kerr on 3/16/17.
//  Copyright © 2017 Johann Kerr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let store = CoreDataStack.store

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTestData()
        
        store.fetchFamily()
        store.fetchPatient()
        
        
//        if let firstFam = store.families.first {
//            if let patients = firstFam.patients {
//                dump(patients)
//                for patient in patients {
//                    print(patient)
//                    
//                    patient.
//                }
//                
//            }
//        }

        
    }
    
    func generateTestData() {
        
        let jim = store.createPatient(name: "Jim", balance: 100000.0, condition: "Flu")
        
        
        
        let may = store.createPatient(name: "May", balance: 10, condition: "cold")
        let campagno = store.createFamily(name: "Campagno", balance: 100000.0)
        let cheung = store.createFamily(name: "Cheung", balance: 10)
        
        let johann = store.createPatient(name: "johann", balance: 0, condition: "healthy")
        
      //  store.addPatientToFamily(patient: jim, family: campagno)
        store.addPatientToFamily(patient: may, family: cheung)
        store.addPatientToFamily(patient: johann, family: campagno)
        
        
        
        
        
        
    }

   
}
