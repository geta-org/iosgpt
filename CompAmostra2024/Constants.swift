//
//  Constants.swift
//  CompAmostra2024
//
//  Created by Matheus Henrique dos Santos on 19/05/24.
//

import Foundation

struct Constants {
    
    struct API {
        static let baseURL = "https://api.openai.com/" //Endereço para comunicação com o Chat-GPT
        
        struct Endpoints {
            static let gptChat = "v1/chat/completions"
        }
    }
    
    struct Keys {
        static let apiKey = "" //Chave privada para OpenAI
    }
    
    struct MensagensErro {
        static let urlInvalida = "URL inválida"
        static let erroRespostaAPI = "Erro ao obter resposta:"
        static let erroDesconhecido = "Erro desconhecido"
        static let erroDecodificacao = "Erro ao decodificar mensagem"
        static let respostaInesperada = "Resposta inesperada do servidor"
        
    }
    
    struct ConfigGPT {
        static let model = "gpt-3.5-turbo" //Monta o body com o modelo de GPT treinado
        static let temperatura = 1.0 //Grau de aleatoriedade
        static let tokens = 100 //Quantidade de tokens máximo para resposta (otimização)
        static let amostragem = 1 //Diversidade da amostragem de probabilidade
    }
    
    struct TextosGerais {
        static let digitePergunta = "Digite sua pergunta"
        static let perguntar = "Perguntar"
    }
}
