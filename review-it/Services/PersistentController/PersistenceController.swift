import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

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
}
