
import SwiftUI

struct TesteView: View {
    
    
    
    @StateObject private var viewModel = MusicaViewModel()
    
    @State private var isLoading = true
    
    @State private var showBackground = false
    @State private var showLogoLetring = false
    @State private var showFotoMusica = false
    @State private var showTexts = false
    @State private var showButtons = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
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
                                    .offset(y: showLogoLetring ? -280 : -370)
                                    .animation(.easeOut(duration: 0.8), value: showLogoLetring)
                            }
                        }
                        .frame(width: 10, height: 32.5)
                        .zIndex(1)
                        VStack {
                            Text("Curtiu?")
                                .foregroundStyle(Color.customColor.primaryColor)
                                .font(.system(size: 40, weight: .bold))
                        }
                        .opacity(showTexts ? 1 : 0)
                        .offset(y: showTexts ? -60 : -80)
                        .animation(.easeOut(duration: 0.8), value: showTexts)
                        
                        Spacer()
                        
                    }
                }
            }
            .onAppear {
                carregarNovaMusica()
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
    TesteView()
}
