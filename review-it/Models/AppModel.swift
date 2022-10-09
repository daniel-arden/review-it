import CoreData
import Foundation

final class AppModel: NSManagedObject, Identifiable {
    @NSManaged var appIconUrl: URL
    @NSManaged var appName: String
    @NSManaged var developerName: String
    @NSManaged var developerUrl: URL
    @NSManaged var rating: Float
    @NSManaged var id: Int
    @NSManaged var saveDate: Date
}

extension AppModel {
    static func sortDescriptors() -> [SortDescriptor<AppModel>] {
        [SortDescriptor(\.saveDate, order: .reverse)]
    }
}
