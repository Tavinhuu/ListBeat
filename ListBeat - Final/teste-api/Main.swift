import SwiftUI

func replaceRootView<Content: View>(with view: Content) {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        window.rootViewController = UIHostingController(rootView: view)
        window.makeKeyAndVisible()
    }
}


struct Main: View {
    @StateObject private var viewModel = AvaliacoesViewModel()
    
    @State private var isLoading = true
    @State private var showTitle = false
    @State private var showDivider = false
    @State private var showAvaliacoes = false

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if isLoading {
                    Image("logo")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .transition(.opacity)
                } else {
                    Button(action: {
                        replaceRootView(with: ContentView())
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(Color.customColor.primaryColor)
                            .font(.system(size: 50))
                    }
                    .offset(x: 130, y: 350)
                    .zIndex(1)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            HStack {
                                Text("My")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color.customColor.primaryColor)
                                    .offset(x:66, y: 10)
                                    .bold()
                                    .opacity(showTitle ? 1 : 0)
                                    .offset(y: showTitle ? 0 : -10)
                                    .animation(.easeOut(duration: 0.6), value: showTitle)
                                
                                Image("logoletreiro")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 42)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .opacity(showTitle ? 1 : 0)
                                    .offset(y: showTitle ? 0 : -10)
                                    .animation(.easeOut(duration: 0.6).delay(0.2), value: showTitle)
                            }
                            
                            Divider()
                                .frame(minHeight: 1.5)
                                .background(Color.customColor.primaryColor)
                                .opacity(showDivider ? 1 : 0)
                                .animation(.easeOut(duration: 0.6).delay(0.4), value: showDivider)
                            
                            // Imagem e botões redimensionados
                            HStack(spacing: 30) {
                                AsyncImage(url: URL(string: "https://p2.trrsf.com/image/fget/cf/1200/1200/middle/images.terra.com/2024/09/23/1726614881-cachorro-adocao.jpg")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.customColor.primaryColor.opacity(0.5), lineWidth: 2))
                                    } else {
                                        Circle()
                                            .fill(Color.gray)
                                            .frame(width: 60, height: 60)
                                    }
                                }
                                
                                
                                NavigationLink(destination: PerfilView().navigationBarBackButtonHidden()) {
                                    Text("Meu perfil")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 4)
                                        .background(Color.black)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.customColor.primaryColor, lineWidth: 1)
                                        )
                                }
                                NavigationLink(destination: ConfigView().navigationBarBackButtonHidden()) {
                                    Text("Configurações")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 4)
                                        .background(Color.black)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.customColor.primaryColor, lineWidth: 1)
                                        )
                                }
                                
                                
                                
                                
                                
                            }
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                                ForEach(viewModel.avaliacoes.indices, id: \.self) { index in
                                    let avaliacao = viewModel.avaliacoes[index]
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(avaliacao.nome)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Text(avaliacao.artista)
                                            .font(.subheadline)
                                            .foregroundColor(Color.customColor.primaryColor)
                                        
                                        HStack(spacing: 2) {
                                            ForEach(1...5, id: \.self) { i in
                                                Image(systemName: i <= avaliacao.avaliacao ? "star.fill" : "star")
                                                    .foregroundColor(i <= avaliacao.avaliacao ? .white : .gray)
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
                                    .padding()
                                    .cornerRadius(12)
                                    .opacity(showAvaliacoes ? 1 : 0)
                                    .offset(y: showAvaliacoes ? 0 : 20)
                                    .animation(.easeOut(duration: 0.6).delay(0.5 + Double(index) * 0.2), value: showAvaliacoes)
                                    
                                    Divider()
                                        .frame(minHeight: 1.5)
                                        .background(Color.gray)
                                        .opacity(0.3)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchAvaliacoes()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        isLoading = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showTitle = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        showDivider = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        showAvaliacoes = true
                    }
                }
            }
        }
    }


struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
