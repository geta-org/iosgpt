//
//  ViewModel.swift
//  CompAmostra2024
//
//  Created by Matheus Henrique dos Santos on 19/05/24.
//

import Foundation

final class ViewModel: ObservableObject { //Classe final impede herança
    
    @Published var mensagens: [Message] = [] // istórico do chat observado pelo SwiftUI
    
    init() {}
    
     func enviarPergunta(_ pergunta: String) {
        
        let mensagemUsuario = Message(role: .user, content: pergunta) //
        mensagens.append(mensagemUsuario) //Adiciona ao histórico do chat
        
        let openAIService = OpenAIService() //Configura a camada de Networking
        
        //Monta o body com o modelo de GPT treinado
        let configModelo = Body(model: Constants.ConfigGPT.model,
                                messages: [mensagemUsuario], //Pergunta
                                temperature: Constants.ConfigGPT.temperatura, //Grau de aleatoriedade
                                max_tokens:  Constants.ConfigGPT.tokens, //Quantidade de tokens máximo para resposta
                                top_p:  Constants.ConfigGPT.amostragem) //Diversidade da amostragem de probabilidade
        
        openAIService.fetchResposta(configModelo: configModelo) { [weak self] resposta in
            self?.concatenarRespostaRecebida(Message(role: .assistant, content: resposta)) // Cria uma mensagem do sistema
        }
    }
    
    private func concatenarRespostaRecebida(_ resposta: Message) {
        DispatchQueue.main.async { // Garante que a concatenação da resposta seja executada na thread principal
            self.mensagens.append(resposta) //Adiciona ao histórico do chat
        }
    }
}
