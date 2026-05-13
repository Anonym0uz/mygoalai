//
//  FileManager+Extension.swift
//  LifeManager
//
//  Created by Alexander Orlov on 28.08.2025.
//

import Foundation
import UIKit

public extension FileManager {
    // MARK: Get documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    // MARK: Get bundle directory
    func getBundleDirectory() -> URL {
        Bundle.main.bundleURL
    }
    // MARK: Get directory size
    func directorySize(_ dir: URL) -> Int? { // in MB (remove / 1000000 for see in bytes)
        if let enumerator = self.enumerator(at: getDocumentsDirectory(), includingPropertiesForKeys: [.totalFileAllocatedSizeKey, .fileAllocatedSizeKey], options: [], errorHandler: { (_, error) -> Bool in
            print(error)
            return false
        }) {
            var bytes = 0
            for case let url as URL in enumerator {
                bytes += url.fileSize ?? 0
            }
            return bytes / 1000000
        } else {
            return nil
        }
    }
    // MARK: Get object
    func getObject<T: Codable>(_ atPath: URL, _ object: T.Type) -> T? {
        guard let data = try? Data(contentsOf: atPath) else { return nil }
        do {
            let prints: String = String(data: data, encoding: .utf8) ?? ""
            print(prints)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            return nil
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

public extension URL {
    var fileSize: Int? { // in bytes
        do {
            let val = try self.resourceValues(forKeys: [.totalFileAllocatedSizeKey, .fileAllocatedSizeKey])
            return val.totalFileAllocatedSize ?? val.fileAllocatedSize
        } catch {
            print(error)
            return nil
        }
    }
}
