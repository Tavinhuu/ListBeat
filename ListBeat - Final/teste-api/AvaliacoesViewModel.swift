import Foundation
import Combine

class AvaliacoesViewModel: ObservableObject {
    @Published var avaliacoes: [Avaliacao] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func deletarAvaliacao(at offsets: IndexSet) {
            // Copiamos as avaliações a serem removidas
            let avaliacoesParaRemover = offsets.map { avaliacoes[$0] }

            for avaliacao in avaliacoesParaRemover {
                guard let url = URL(string: "http://192.168.128.90:1880/remover") else { continue }
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                do {
                    let jsonData = try JSONEncoder().encode(avaliacao)
                    request.httpBody = jsonData
                } catch {
                    print("❌ Erro ao codificar para deletar: \(error)")
                    continue
                }

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("❌ Erro ao deletar: \(error)")
                        return
                    }

                    DispatchQueue.main.async {
                        self.avaliacoes.removeAll { $0.id == avaliacao.id }
                    }

                }.resume()
            }
        }
    
    func fetchAvaliacoes() {
        guard let url = URL(string: "http://192.168.128.100:1880/leitura") else {
            errorMessage = "URL inválida"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Erro ao carregar dados: \(error)") // Detalhes do erro
                    self.errorMessage = "Erro ao carregar dados: \(error.localizedDescription)"
                }
                self.isLoading = false
            }, receiveValue: { data in
            
                
                // Tentar deserializar os dados
                do {
                    let avaliacoes = try JSONDecoder().decode([Avaliacao].self, from: data)
                    self.avaliacoes = avaliacoes
                } catch {
                    print("Erro ao tentar desserializar os dados: \(error)")
                    self.errorMessage = "Erro ao carregar dados. Verifique o formato da resposta."
                }
            })
            .store(in: &cancellables)
    }
}
