//
//  CoreDataStack.swift
//  DocShop
//
//  Created by Johann Kerr on 3/16/17.
//  Copyright © 2017 Johann Kerr. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataStack {
    private init (){}
    static let store = CoreDataStack()
    var patients = [Patient]()
    var families = [Family]()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DocModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func createPatient(name: String, balance: Double, condition: String) -> Patient {
        let context = persistentContainer.viewContext
        let patient = Patient(context: context)
        patient.name = name
        patient.balance = balance
        patient.condition = condition
        saveContext()
        
        return patient
    }
    
    func addPatientToFamily(patient: Patient, family: Family) {
        family.addToPatients(patient)
        
    }
    
    func addFamilyToPatient(patient: Patient , family:Family) {
        patient.family = family
        
    }
    
    func getFamilyFor(_ patient: Patient) -> Family? {
        guard let family = patient.family else { return nil }
        return family
    }
    
    func getPatientsFor(_ family: Family) -> [Patient]? {
        guard let patient = family.patients else { return nil }
        return patient.allObjects as? [Patient]
    }
    
    
    
    func fetchPatient() {
        let context = persistentContainer.viewContext
    
        let fetchRequest: NSFetchRequest<Patient> = Patient.fetchRequest()
        if let patients = try? context.fetch(fetchRequest) {
            self.patients = patients
        }
    }
    
    func createFamily(name: String, balance: Double) -> Family {
        
        let context = persistentContainer.viewContext
        let family = Family(context: context)
        family.balance = balance
        family.name = name
        saveContext()
        return family
    }
    
    func fetchFamily() {
        let context = persistentContainer.viewContext
        
        
        let fetchRequest: NSFetchRequest<Family> = Family.fetchRequest()
        if let families = try? context.fetch(fetchRequest) {
            self.families = families
        }
    }

    
    

    
    
}


