import SwiftUI

struct Main: View {
    @StateObject private var viewModel = AvaliacoesViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Carregando avaliações...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.white)
                            .padding()
                    } else if viewModel.avaliacoes.isEmpty {
                        Text("Nenhuma avaliação encontrada.")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        List {
                            ForEach(viewModel.avaliacoes) { avaliacao in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(avaliacao.nome)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(avaliacao.artista)
                                        .font(.subheadline)
                                        .foregroundColor(Color.customColor.primaryColor)
                                    
                                    HStack(spacing: 2) {
                                        ForEach(1...5, id: \.self) { index in
                                            Image(systemName: index <= avaliacao.avaliacao ? "star.fill" : "star")
                                                .foregroundColor(index <= avaliacao.avaliacao ? .white : .gray)
                                                .padding(.top)
                                                .font(.system(size: 14))
                                        }
                                    }
                                    
                                    HStack(alignment: .top, spacing: 16) {
                                        AsyncImage(url: URL(string: avaliacao.foto)) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            } else if phase.error != nil {
                                                Color.red
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            } else {
                                                ProgressView()
                                                    .frame(width: 100, height: 100)
                                            }
                                        }
                                        
                                        Text(" \(avaliacao.comentario)")
                                            .font(.body)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.vertical, 8)
                                .listRowBackground(Color.black)
                            }
                            .onDelete(perform: viewModel.deletarAvaliacao)
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .onAppear {
                viewModel.fetchAvaliacoes()
            }
            .navigationBarTitle("Avaliações", displayMode: .inline)
         
        }
    }
}



struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
