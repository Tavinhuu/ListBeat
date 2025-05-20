struct Musica: Identifiable, Codable {
    var id: String { _id }
    var _id: String
    var nome: String
    var foto: String
    var artista: String
    var ano: String

    // Campos adicionais para avaliação
    var avaliacao: Int? = nil
    var comentario: String? = nil
}

