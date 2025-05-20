import Foundation

struct Avaliacao: Identifiable, Codable {
    var id: String
    var nome: String
    var artista: String
    var ano: String
    var avaliacao: Int
    var comentario: String
    var foto: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nome
        case artista
        case ano
        case avaliacao
        case comentario
        case foto
    }

    // Custom decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let anoString = try? container.decode(String.self, forKey: .ano) {
            self.ano = anoString
        } else {
            let anoInt = try container.decode(Int.self, forKey: .ano)
            self.ano = String(anoInt)
        }

        self.id = try container.decode(String.self, forKey: .id)
        self.nome = try container.decode(String.self, forKey: .nome)
        self.artista = try container.decode(String.self, forKey: .artista)
        self.avaliacao = try container.decode(Int.self, forKey: .avaliacao)
        self.comentario = try container.decode(String.self, forKey: .comentario)
        self.foto = try container.decode(String.self, forKey: .foto)
    }

    // Custom encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(nome, forKey: .nome)
        try container.encode(artista, forKey: .artista)
        try container.encode(ano, forKey: .ano)
        try container.encode(avaliacao, forKey: .avaliacao)
        try container.encode(comentario, forKey: .comentario)
        try container.encode(foto, forKey: .foto)
    }
}

