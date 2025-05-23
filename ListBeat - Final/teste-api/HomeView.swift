import SwiftUI
import AVKit

struct ContentView: View {
    @StateObject private var viewModel = MusicaViewModel()
    
    @State private var isLoading = true
    
    @State private var showBackground = false
    @State private var showLogoLetring = false
    @State private var showFotoMusica = false
    @State private var showTexts = false
    @State private var showButtons = false
    @State private var player = AVPlayer()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if isLoading {
                    VideoPlayer(player: player)
                        .ignoresSafeArea()
                        .onAppear {
                            if let url = Bundle.main.url(forResource: "ANIMAÇÃO LISTBEAT", withExtension: "mp4") {
                                player.replaceCurrentItem(with: AVPlayerItem(url: url))
                                player.isMuted = true
                                player.play()
                            }
                        }
                        .frame(height: 200)
                } else {
                    if let musica = viewModel.musica {
                        VStack(spacing: 0) {
                            AsyncImage(url: URL(string: musica.foto)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .blur(radius: 10)
                                        .opacity(showBackground ? 0.6 : 0)
                                        .animation(.easeOut(duration: 0.8), value: showBackground)
                                } else {
                                    Color.gray
                                        .opacity(showBackground ? 0.6 : 0)
                                        .animation(.easeOut(duration: 0.8), value: showBackground)
                                }
                            }
                            .frame(height: 150)
                            .ignoresSafeArea(edges: .top)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(showBackground ? 0 : 0),
                                    Color.black.opacity(showBackground ? 1 : 0)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 200)
                            .animation(.easeOut(duration: 0.8), value: showBackground)
                            
                            Rectangle()
                                .fill(.black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                        AsyncImage(url: URL(string: "https://i.ibb.co/G4WF943x/Logo-Letring.png")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .opacity(showLogoLetring ? 1 : 0)
                                    .offset(y: showLogoLetring ? -350 : -370)
                                    .animation(.easeOut(duration: 0.8), value: showLogoLetring)
                            }
                        }
                        .frame(width: 10, height: 32.5)
                        .zIndex(1)
                        
                        AsyncImage(url: URL(string: musica.foto)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(15) 
                                    .opacity(showFotoMusica ? 1 : 0)
                                    .offset(y: showFotoMusica ? -200 : -220)
                                    .animation(.easeOut(duration: 0.8), value: showFotoMusica)
                            }
                        }
                        .frame(width: 160, height: 160)
                        .zIndex(1)

                        
                        VStack {
                            Text(musica.nome)
                                .foregroundStyle(.white)
                                .font(.system(size: 20, weight: .bold))
                            
                            Text(musica.artista)
                                .foregroundStyle(.gray)
                                .font(.system(size: 20))
                                .bold()
                            
                            Text(musica.ano)
                                .foregroundStyle(.gray)
                                .font(.system(size: 15))
                        }
                        .opacity(showTexts ? 1 : 0)
                        .offset(y: showTexts ? -60 : -80)
                        .animation(.easeOut(duration: 0.8), value: showTexts)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 30) {
                            HStack {
                                AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Spotify_logo_with_text.svg/800px-Spotify_logo_with_text.svg.png")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .frame(width: 80, height: 26)
                                            .opacity(showButtons ? 1 : 0)
                                            .offset(x: showButtons ? 0 : -30)
                                            .animation(.easeOut(duration: 0.8).delay(0), value: showButtons)
                                    }
                                }
                                Spacer()
                                Link(destination: URL(string: musica.linkspotify)!) {
                                    Label("Play", systemImage: "play.fill")
                                        .padding(.horizontal, 8)
                                        .frame(width: 80, height: 36)
                                        .background(RoundedRectangle(cornerRadius: 60)
                                            .fill(Color.customColor.primaryColor))
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                }
                                .opacity(showButtons ? 1 : 0)
                                .offset(x: showButtons ? 0 : 30)
                                .animation(.easeOut(duration: 0.8).delay(0), value: showButtons)
                            }
                            Divider()
                                .frame(minHeight: 1.5)
                                .background(Color.gray)
                                .opacity(0.5)
                                .opacity(showButtons ? 1 : 0)
                                .animation(.easeOut(duration: 0.8).delay(0), value: showButtons)
                            
                            HStack {
                                AsyncImage(url: URL(string: "https://jeremysassoon.com/wp-content/uploads/2018/06/itunes-logo-png-transparent2-300x117.png")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .frame(width: 80, height: 28)
                                            .opacity(showButtons ? 1 : 0)
                                            .offset(x: showButtons ? 0 : -30)
                                            .animation(.easeOut(duration: 0.8).delay(0.15), value: showButtons)
                                    }
                                }
                                Spacer()
                                Link(destination: URL(string: musica.linkapple)!) {
                                    Label("Play", systemImage: "play.fill")
                                        .padding(.horizontal, 8)
                                        .frame(width: 80, height: 36)
                                        .background(RoundedRectangle(cornerRadius: 60)
                                            .fill(Color.customColor.primaryColor))
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                }
                                .opacity(showButtons ? 1 : 0)
                                .offset(x: showButtons ? 0 : 30)
                                .animation(.easeOut(duration: 0.8).delay(0.15), value: showButtons)
                            }
                            Divider()
                                .frame(minHeight: 1.5)
                                .background(Color.gray)
                                .opacity(0.5)
                                .opacity(showButtons ? 1 : 0)
                                .animation(.easeOut(duration: 0.8).delay(0.15), value: showButtons)
                            
                            HStack {
                                AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_RaxzS2HDc8O5VR0Cd9niyRLdPeTwC_8W2w&s")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .frame(width: 80, height: 16)
                                            .opacity(showButtons ? 1 : 0)
                                            .offset(x: showButtons ? 0 : -30)
                                            .animation(.easeOut(duration: 0.8).delay(0.3), value: showButtons)
                                    }
                                }
                                Spacer()
                                Link(destination: URL(string: musica.linkdeezer)!) {
                                    Label("Play", systemImage: "play.fill")
                                        .padding(.horizontal, 8)
                                        .frame(width: 80, height: 36)
                                        .background(RoundedRectangle(cornerRadius: 60)
                                            .fill(Color.customColor.primaryColor))
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                }
                                .opacity(showButtons ? 1 : 0)
                                .offset(x: showButtons ? 0 : 30)
                                .animation(.easeOut(duration: 0.8).delay(0.3), value: showButtons)
                            }
                            
                            HStack(spacing: 20) {
                                NavigationLink(destination: AvaliacaoView(musica: musica, viewModel: viewModel)) {
                                    Text("Avaliar")
                                        .font(.system(size: 18))
                                        .padding(.horizontal, 35)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule()
                                                .fill(Color.customColor.primaryColor)
                                        )
                                        .foregroundColor(.black)
                                }
                                
                                Button {
                                    carregarNovaMusica()
                                } label: {
                                    Text("Próximo")
                                        .font(.system(size: 18))
                                        .foregroundStyle(.gray)
                                        .background(Color.black)
                                        .bold()
                                        .padding(.horizontal, 35)
                                        .padding(.vertical, 8)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.gray, lineWidth: 2)
                                        )
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 26)
                            .opacity(showButtons ? 1 : 0)
                            .offset(y: showButtons ? 0 : 30)
                            .animation(.easeOut(duration: 0.8).delay(0.5), value: showButtons)
                            
                            NavigationLink(destination: Main().navigationBarBackButtonHidden()) {
                                Text("Agora não")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                                    .underline()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .opacity(showButtons ? 1 : 0)
                            .offset(y: showButtons ? 0 : 30)
                            .animation(.easeOut(duration: 0.8).delay(0.6), value: showButtons)
                        }
                        .padding(.top, 350)
                        .padding(.horizontal, 40)
                    }
                }
            }
            .onAppear {
                carregarNovaMusica()
            }
        }
    }
    
    func carregarNovaMusica() {
        withAnimation {
            isLoading = true
            showBackground = false
            showLogoLetring = false
            showFotoMusica = false
            showTexts = false
            showButtons = false
        }
        
        viewModel.buscarMusicaAleatoria()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut(duration: 0.5)) {
                isLoading = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation { showBackground = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation { showLogoLetring = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                withAnimation { showFotoMusica = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation { showTexts = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation { showButtons = true }
            }
        }
    }
}

#Preview {
    ContentView()
}
