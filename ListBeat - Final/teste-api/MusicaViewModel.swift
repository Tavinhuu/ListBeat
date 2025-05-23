import Foundation

class MusicaViewModel: ObservableObject {
    @Published var musica: Musica?

    func buscarMusicaAleatoria() {
        guard let url = URL(string: "http://192.168.128.90:1880/leitura") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let musicas = try JSONDecoder().decode([Musica].self, from: data)
                    DispatchQueue.main.async {
                        self.musica = musicas.randomElement()
                    }
                } catch {
                    print("❌ Erro ao decodificar músicas: \(error)")
                }
            } else if let error = error {
                print("❌ Erro na requisição: \(error)")
            }
        }.resume()
    }

    func salvarAvaliacao(musica: Musica) {
        guard let url = URL(string: "http://192.168.128.100:1880/atualizar") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(musica)
            request.httpBody = jsonData
        } catch {
            print("❌ Erro ao codificar música: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Erro na requisição PUT: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Resposta inválida")
                return
            }

            DispatchQueue.main.async {
                if httpResponse.statusCode == 200 {
                    print("✅ Avaliação salva com sucesso.")
                    self.musica = musica // atualiza localmente
                } else {
                    print("⚠️ Erro ao salvar avaliação: código \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
}

