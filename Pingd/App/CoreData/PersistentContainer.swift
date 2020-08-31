//
//  PersistentContainer.swift
//  Pingd
//
//  Created by David Acevedo on 8/26/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import Foundation
import CoreData
import os

class PersistentContainer: NSPersistentContainer {
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    func saveOverview(_ newOverview: OverviewResponse) {
        // Gets the entity class
        let overview = getOverview() ?? Overview(context: viewContext)
        
        // Sets the overview variables
        overview.amountSpent = newOverview.amountSpent
        overview.daysLeft = Int16(newOverview.daysLeft)
        overview.header = newOverview.header
        overview.monthlyIncome = newOverview.monthlyIncome
        overview.showInfo = newOverview.showInfo
        overview.showTransactions = newOverview.showTransactions
        overview.totalPercentage = Int16(newOverview.totalPercentage)
        
        // Sets the settings
        let needs = getSetting(id: 1) ?? Setting(context: viewContext)
        let wants = getSetting(id: 2) ?? Setting(context: viewContext)
        let savings = getSetting(id: 3) ?? Setting(context: viewContext)
        
        // Sets the Settings values
        needs.id = 1
        needs.spent = newOverview.settings.needs.spent
        needs.allowed = newOverview.settings.needs.allowed
        needs.percentage = Int16(newOverview.settings.needs.percentage)
        
        wants.id = 2
        wants.spent = newOverview.settings.wants.spent
        wants.allowed = newOverview.settings.wants.allowed
        wants.percentage = Int16(newOverview.settings.wants.percentage)
        
        savings.id = 3
        savings.spent = newOverview.settings.savings.spent
        savings.allowed = newOverview.settings.savings.allowed
        savings.percentage = Int16(newOverview.settings.savings.percentage)
        
        // Adds the settings to the relationship
        let overviewSettings = overview.settings ?? NSSet()
        if overviewSettings.count < 1 {
            overview.settings = NSSet(array: [needs, wants, savings])
        }
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getOverview() -> Overview? {
        let fetchRequest = NSFetchRequest<Overview>(entityName: "Overview")
        
        do {
            let overviews = try viewContext.fetch(fetchRequest)
            switch overviews.count {
            case 0:
                return nil
            case 1:
                return overviews[0]
            default:
                throw CoreDataError.TooManyEntries
            }
        } catch let error as NSError {
            os_log("error getting overview: %{public}s", log: Log.data, type: .error, error)
        } catch CoreDataError.TooManyEntries {
            os_log("More than entry found", log: Log.data, type: .error)
        }
        
        return nil
    }
    
    private func getSetting(id settingId: Int) -> Setting? {
        let fetchRequest = NSFetchRequest<Setting>(entityName: "Setting")
        fetchRequest.predicate = NSPredicate(format: "id == " + settingId.description)
        
        do {
            let settings = try viewContext.fetch(fetchRequest)
            switch settings.count {
            case 0:
                return nil
            case 1:
                return settings[0]
            default:
                throw CoreDataError.TooManyEntries
            }
        } catch let error as NSError {
            os_log("error getting setting: %{public}s", log: Log.data, type: .error, error)
        } catch CoreDataError.TooManyEntries {
            os_log("More than entry found", log: Log.data, type: .error)
        }
        
        return nil
    }
}
