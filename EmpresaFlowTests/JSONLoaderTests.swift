import Foundation
import Testing
@testable import EmpresaFlow

/// Tres pruebas de regresión sin usar red ni interfaz.
struct JSONLoaderTests {
    @Test("El JSON del Bundle contiene 10 proyectos")
    func projectsDelBundle() throws {
        let projects = try ProjectDataLoader.loadProjects()
        #expect(projects.count == 10)
        #expect(Set(projects.map(\.id)).count == 10)
    }

    @Test("Decodifica fecha ISO 8601 y direcciones URL")
    func fechaYURL() throws {
        let sample = #"""
        [{
          "id":"5B08A78E-49C3-417B-BF74-FAD99B3B18B2",
          "title":"Proyecto de prueba",
          "description":"Ejemplo sin conexión",
          "category":"Reformas",
          "location":"Murcia",
          "status":"Pendiente",
          "estimatedCost":1500.0,
          "workedHours":7.5,
          "employeeCount":2,
          "createdAt":"2026-03-15T10:30:00Z",
          "tags":["prueba"],
          "mainImageURL":"https://images.unsplash.com/photo-test",
          "imageURL":["https://images.unsplash.com/photo-test"],
          "webURL":"https://unsplash.com/",
          "latitude":37.9838,
          "longitude":-1.1280,
          "notes":[]
        }]
        """#
        let decoded = try ProjectDataLoader.decodeProjects(from: Data(sample.utf8))
        let project = try #require(decoded.first)
        let expectedDate = ISO8601DateFormatter().date(from: "2026-03-15T10:30:00Z")
        #expect(project.createdAt == expectedDate)
        #expect(project.mainImageURL.scheme == "https")
        #expect(project.webURL.host == "unsplash.com")
    }

    @Test("Un JSON mal formado produce un error")
    func jsonInvalido() {
        let wrongData = Data(#"[{ "title": 42 }]"#.utf8)
        #expect(throws: DecodingError.self) {
            try ProjectDataLoader.decodeProjects(from: wrongData)
        }
    }
}
