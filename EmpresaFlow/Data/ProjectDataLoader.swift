import Foundation

/// Carga y decodificación local para el primer entregable.
/// Es un punto de integración: Persona 3 puede reemplazarlo por su JSONLoader.
enum ProjectDataLoader {
    enum LoaderError: LocalizedError {
        case fileNotFound(String)

        var errorDescription: String? {
            switch self {
            case .fileNotFound(let name):
                return "No se encontró \(name).json dentro de la app."
            }
        }
    }

    static func decodeProjects(from data: Data) throws -> [Project] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([Project].self, from: data)
    }

    static func loadProjects(fileName: String = "projects", bundle: Bundle = .main) throws -> [Project] {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw LoaderError.fileNotFound(fileName)
        }
        do {
            let data = try Data(contentsOf: url)
            return try decodeProjects(from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("JSON: falta la clave \(key.stringValue), \(context.debugDescription)")
            throw DecodingError.keyNotFound(key, context)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("JSON: tipo incorrecto para \(type), \(context.debugDescription)")
            throw DecodingError.typeMismatch(type, context)
        } catch {
            print("JSON: error leyendo/decodificando \(fileName).json: \(error)")
            throw error
        }
    }
}
