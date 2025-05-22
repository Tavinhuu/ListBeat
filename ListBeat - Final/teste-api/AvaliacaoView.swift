import SwiftUI

struct AvaliacaoView: View {
    @State var musica: Musica
    @ObservedObject var viewModel: MusicaViewModel
    
    @State private var rating: Int = 0
    @State private var comentario: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Imagem de fundo borrada
                AsyncImage(url: URL(string: musica.foto)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 10)
                            .opacity(0.6)
                    } else {
                        Color.gray.opacity(0.6)
                    }
                }
                .frame(height: 150)
                .ignoresSafeArea(edges: .top)
                
                // Gradiente escurecendo o fundo
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0),
                        Color.black.opacity(1)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                
                // Logo e título
                VStack(spacing: 12) {
                    AsyncImage(url: URL(string: "https://i.ibb.co/G4WF943x/Logo-Letring.png")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 40)
                                .offset(y: -230)
                        }
                    }
                }
                
                Rectangle()
                    .fill(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Conteúdo principal
                VStack(spacing: 20) {
                    Text("Qual sua nota?")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                    
                    // Estrelas
                    HStack {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: "star.fill") // sempre preenchida
                                .foregroundColor(star <= rating ? .yellow : .gray.opacity(0.4)) // amarelo se selecionada, cinza com opacidade caso contrário
                                .font(.system(size: 25))
                                .onTapGesture {
                                    rating = star
                                }
                        }
                    }
                    
                    // Campo de comentário (com placeholder)
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray.opacity(0.4))
                        ZStack {
                            Color.gray.opacity(0.2)
                                .cornerRadius(10)
                            
                            TextField("Deixe seu comentário aqui", text: $comentario)
                                .foregroundColor(.white) // Texto branco
                                .padding(8)
                                .background(Color.clear) // Fundo transparente no TextField
                                .cornerRadius(10)
                        }
                        .frame(height: 40)
                        .padding(.horizontal)
                    }
                    .padding(.top, 60)
                    .padding(.horizontal, 20)
                    
                    // Substituindo o botão Avaliar por uma imagem
                    if let logoImage = UIImage(named: "beatbutton") {
                        Button(action: {
                            guard rating > 0 else { return }
                                
                            musica.avaliacao = rating
                            musica.comentario = comentario
                            viewModel.salvarAvaliacao(musica: musica)
                            dismiss()
                        }) {
                            Image(uiImage: logoImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150) // Ajuste o tamanho conforme necessário
                                .padding(.top, 40)
                        }
                        .disabled(rating == 0)
                    }
                    
                    Spacer()
                    
                    // Botão de Cancelar
                    Button(action: {
                        dismiss() // Fecha a tela e volta para a anterior
                    }) {
                        Text("Cancelar")
                            .font(.system(size: 10))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                          
                         
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 30) // Espaçamento inferior
                }
                .offset(y: -20) // <--- aqui ajustei de 40 para 10
            }
        }
    }
}

#Preview {
    AvaliacaoView(
        musica: Musica(
            _id: "1",
            nome: "Fake Plastic Trees",
            foto: "https://i.scdn.co/image/ab67616d0000b2732172b607853fa89cefa2beb4",
            artista: "Radiohead",
            ano: "1995",
            linkspotify: "www.com",
            linkapple: "sasad",
            linkdeezer: "sdfdsf"
        ),
        viewModel: MusicaViewModel()
    )
}
