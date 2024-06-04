//
//  ContentView.swift
//  CompAmostra2024
//
//  Created by Matheus Henrique dos Santos on 19/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel //@ObservedObject notifica mudanças na VM
    @State private var pergunta = "" //@State permite manipular o valor em uma struct
    
    var body: some View {
        VStack { //StackView Vertical
            MensagensListView(mensagens: viewModel.mensagens) //Lista de mensagens rolável
            HStack { //StackView Horizontal
                TextField(Constants.TextosGerais.digitePergunta, text: $pergunta) //Entrada da pergunta
                    .padding(.horizontal)
                Button(action: enviarPergunta) { //Botão de envio
                    Text(Constants.TextosGerais.perguntar)
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
    }
    
    func enviarPergunta() {
        guard !pergunta.isEmpty else { return } // Não envia a requisição sem um texto
        viewModel.enviarPergunta(pergunta)
        pergunta = "" // Limpa o campo de texto da tela
    }
}

struct MensagensListView: View {
    var mensagens: [Message] //Utilizada localmente para montar a lista com o histórico
    
    var body: some View {
        List(mensagens) { mensagem in
            MensagemRow(mensagem: mensagem) //Exibe cada mensagem individualmente, em loop (mensagem in)
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
}

struct MensagemRow: View {
    var mensagem: Message
    
    //Configura o balão de mensagem de usuário e assistente
    var body: some View {
        HStack {
            if mensagem.role == .user {
                Spacer()
                Text(mensagem.content)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                Image(systemName: "figure.roll")
                    .font(.system(size: 28))
            } else { //Checa se é usuário ou assistant
                Image(systemName: "waveform.circle")
                    .font(.system(size: 32))
                Text(mensagem.content)
                    .padding()
                    .background(Color.verdeGPT)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
