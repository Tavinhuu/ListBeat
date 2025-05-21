import SwiftUI

struct PerfilView: View {
    @StateObject private var viewModel = AvaliacoesViewModel()
    @State private var isLoading = true
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                if isLoading {
                    Image("logo")
                        .resizable()
                        .frame(width: 150, height: 150)
                } else {
                    ScrollView {
                        VStack {
                     
                            ZStack {
                                HStack {
                                    Button(action: {
                                        dismiss()
                                    }) {
                                        Image(systemName: "arrowshape.turn.up.backward")
                                            .foregroundStyle(.white)
                                            .padding(.leading)
                                    }
                                    Spacer()
                                }

                                Text("Meu Perfil")
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)

                            // Foto de perfil e nome
                            HStack {
                                AsyncImage(url: URL(string: "https://p2.trrsf.com/image/fget/cf/1200/1200/middle/images.terra.com/2024/09/23/1726614881-cachorro-adocao.jpg")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.customColor.primaryColor.opacity(0.5), lineWidth: 2))
                                            .padding(.top, 50)
                                            .padding(.bottom, 50)
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("Tavin")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 22))
                                        .bold()
                                        .padding(.horizontal)

                                    HStack {
                                        Text("0 seguidores")
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 15))
                                            .bold()
                                        Text("0 seguindo")
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 15))
                                            .bold()
                                    }
                                    .padding(.horizontal)
                                }
                            }

                            // Título da seção
                            Text("Favoritos")
                                .foregroundStyle(.white)
                                .font(.system(size: 15))
                                .bold()
                                .padding(.horizontal)

                            // Grid de músicas com avaliação 5
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                                ForEach(viewModel.avaliacoes.indices, id: \.self) { index in
                                    let avaliacao = viewModel.avaliacoes[index]

                                    if avaliacao.avaliacao == 5 {
                                        VStack {
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
                                        }
                                        .padding()
                                        .background(Color.white.opacity(0.05))
                                        .cornerRadius(12)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                viewModel.fetchAvaliacoes()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isLoading = false
                }
            }
        }
    }
}

struct Perfil_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}
