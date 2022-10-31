import Foundation

final class APIService {
    static let shared = APIService()
    private let decoder = FormattersCoders.jsonDecoder

    func getRequest<T: Decodable>(urlString: String) async throws -> T {
        print("🚀🚀🚀 Sending request with url: \(urlString)")
        guard let url = URL(string: urlString) else {
            throw APIError.failedToCreateUrl
        }

        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    print("❌❌❌", error)
                    continuation.resume(throwing: error)
                    return
                }

                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0

                guard (200...299).contains(statusCode) else {
                    let error = APIError.invalidResponse(code: statusCode)
                    print("❌❌❌", error)
                    continuation.resume(throwing: error)
                    return
                }

                guard let data = data else {
                    let error = APIError.dataNotAvailable
                    print("❌❌❌", error)
                    continuation.resume(throwing: error)
                    return
                }

                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    print("✅✅✅ Successfully decoded following data:")
                    debugPrint(decodedData, terminator: "\n\n")
                    continuation.resume(returning: decodedData)
                } catch {
                    print("❌❌❌", error)
                    continuation.resume(throwing: APIError.decodingError(error))
                }
            }
            .resume()
        }
    }
}
