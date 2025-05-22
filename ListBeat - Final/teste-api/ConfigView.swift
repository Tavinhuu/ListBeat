import SwiftUI

struct ConfigView: View {
    @State private var selectedTheme: String = "Light"
    @State private var fontSize: CGFloat = 16
    @State private var isNotificationsEnabled: Bool = true
    @State private var selectedLanguage: String = "Português"
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Título da tela
                    Text("Configurações")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                    
                    // Tema
                    HStack {
                        Text("Tema")
                            .font(.system(size: fontSize))
                            .foregroundStyle(.white)
                        Spacer()
                        Picker("Tema", selection: $selectedTheme) {
                            Text("Light").tag("Light")
                            Text("Dark").tag("Dark")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200)
                    }
                    
                    // Tamanho da fonte
                    HStack {
                        Text("Tamanho da fonte")
                            .font(.system(size: fontSize))
                            .foregroundStyle(.white)
                        Spacer()
                        Slider(value: $fontSize, in: 12...24, step: 1) {
                            Text("Font Size")
                        }
                        .accentColor(Color.customColor.primaryColor)
                        .frame(width: 200)
                    }
                    
                    // Notificações
                    HStack {
                        Text("Notificações")
                            .font(.system(size: fontSize))
                            .foregroundStyle(.white)
                        Spacer()
                        Toggle(isOn: $isNotificationsEnabled) {
                            Text(isNotificationsEnabled ? "Ativado" : "Desativado")
                                .font(.system(size: fontSize))
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color.customColor.primaryColor))
                        .frame(width: 200)
                    }
                    
                    // Linguagem
                    HStack {
                        Text("Idioma")
                            .font(.system(size: fontSize))
                            .foregroundStyle(.white)
                        Spacer()
                        Picker("Idioma", selection: $selectedLanguage) {
                            Text("Português").tag("Português")
                            Text("Inglês").tag("Inglês")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200)
                    }
                    
                    Spacer()
                    
                    // Botão de salvar
                    Button(action: {
                        // Simula o salvamento das configurações
                        dismiss()
                    }) {
                        Text("Salvar Configurações")
                            .font(.system(size: 18))
                            .padding(.horizontal, 35)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 60)
                                .fill(Color.customColor.primaryColor))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.top, 80)
                .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    ConfigView()
}
