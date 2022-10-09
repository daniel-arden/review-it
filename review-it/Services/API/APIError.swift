import Foundation

enum APIError: LocalizedError {
    case failedToCreateUrl
    case invalidResponse(code: Int)
    case dataNotAvailable
    case decodingError(Error)
}
