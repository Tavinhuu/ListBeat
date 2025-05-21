import Foundation
import Combine

class AvaliacoesViewModel: ObservableObject {
    @Published var avaliacoes: [Avaliacao] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAvaliacoes() {
        guard let url = URL(string: "http://192.168.128.81:1880/leitura") else {
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
