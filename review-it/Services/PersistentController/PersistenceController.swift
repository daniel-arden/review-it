import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    var moc: NSManagedObjectContext { container.viewContext }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: Constants.persistentContainerName)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(
                fileURLWithPath: Constants.persistentContainerPath
            )
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to load Core Data persistence container: \(error), \(error.userInfo)")
            }
        }
    }

    func reset() throws {
        let uniqueNames = container.managedObjectModel.entities.compactMap({ $0.name })

        try uniqueNames.forEach { (name) in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try container.viewContext.execute(batchDeleteRequest)
            } catch {
                throw PersistenceControllerError.failedToResetStorage
            }
        }
    }
}
