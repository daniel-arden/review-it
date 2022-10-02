import Foundation

final class APIService {
    static let shared = APIService()
    private lazy var decoder = JSONDecoder()

    func getRequest<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.failedToCreateUrl
        }

        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0

                guard (200...299).contains(statusCode) else {
                    continuation.resume(throwing: APIError.invalidResponse(code: statusCode))
                    return
                }

                guard let data = data else {
                    continuation.resume(throwing: APIError.dataNotAvailable)
                    return
                }

                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    continuation.resume(returning: decodedData)
                } catch {
                    print(error)
                    continuation.resume(throwing: APIError.decodingError(error))
                }
            }
            .resume()
        }
    }
}
