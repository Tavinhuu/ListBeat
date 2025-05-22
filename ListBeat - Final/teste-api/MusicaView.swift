import SwiftUI

struct MusicaView: View {
    @State var musica: Musica
    @ObservedObject var viewModel: MusicaViewModel
    
    @State private var rating: Int = 0
    @State private var comentario: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrowshape.turn.up.backward.fill")
                            .foregroundStyle(.white)
                            .padding(.leading)
                    }
                    .frame(width: 44, height: 44)
                    .padding(.top, 20)
                    .offset(y: 60)
                    Spacer()
                }
              
                
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
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0),
                        Color.black.opacity(1)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                
                VStack(spacing: 12) {
                    AsyncImage(url: URL(string: musica.foto)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .offset(y: -230)
                        }
                    }
                    .frame(width: 200, height: 200)
                    .zIndex(1)
                    
                    VStack {
                        Text(musica.nome)
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .bold))
                        
                        Text(musica.artista)
                            .foregroundStyle(.gray)
                            .font(.system(size: 20))
                            .bold()
                      
                        Text("Sua avaliação")
                            .foregroundStyle(.white)
                            .padding()
                            .opacity(0.7)
                            .offset(y: 30)
                        HStack(spacing: 2) {
                           
                            ForEach(1...5, id: \.self) { i in
                                Image(systemName: i <= musica.avaliacao ?? 3 ? "star.fill" : "star")
                                    .foregroundColor(i <= musica.avaliacao ?? 3 ? .white : .gray)
                                    .padding(.top)
                                    .font(.system(size: 20))
                            }
                        }
                        
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray.opacity(0.4))
                            
                            ZStack {
                                Color.gray.opacity(0.2)
                                    .cornerRadius(10)
                                
                                Text(musica.comentario ?? "Gostei muito, e um album excelente")
                                    .foregroundColor(.white)
                                    .opacity(0.8)
                                    .padding(8)
                                    .background(Color.clear)
                                    .cornerRadius(10)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(nil)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal)
                            .frame(minHeight: 60)
                        }
                        .offset(y: -35)
                        .padding(.top, 60)
                        .padding(.horizontal, 20)
                        
                        let link = URL(string: musica.linkspotify)!
                        
                        ShareLink("Compartilhar", item: link)
                            .foregroundStyle(.white)
                    }
                    .offset(y: -220)
                    
                }
                
                Rectangle()
                    .fill(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
        }
    }
}

#Preview {
    MusicaView(
        musica: Musica(
            _id: "1",
            nome: "Fake Plastic Trees",
            foto: "https://i.scdn.co/image/ab67616d0000b2732172b607853fa89cefa2beb4",
            artista: "Radiohead",
            ano: "1995",
            
            linkspotify: "www.com",
            linkapple: "sasad",
            linkdeezer: "sdfdsf",
            avaliacao: 8
        ),
        viewModel: MusicaViewModel()
    )
}
