//
//  Networking.swift
//  CompAmostra2024
//
//  Created by Matheus Henrique dos Santos on 19/05/24.
//

import Foundation

struct OpenAIService {
    
    let endpoint = Constants.API.baseURL + Constants.API.Endpoints.gptChat //Endereço para comunicação com o Chat-GPT
    
    func fetchResposta(configModelo: Body, completion: @escaping (String) -> Void) {
        
        guard let url = URL(string: endpoint) else { //Converte String para URL
            completion(Constants.MensagensErro.urlInvalida)
            return
        }
        
        var request = URLRequest(url: url) //Configura cabeçalho da requisição de pergunta
        request.httpMethod = "POST"
        request.addValue("Bearer \(Constants.Keys.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(configModelo) //Codifica objetos em JSON a partir do objeto Body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in //Inicia sessão para renviar pergunta e receber resposta
            guard let data = data, error == nil else {
                completion("\(Constants.MensagensErro.erroRespostaAPI) \(error?.localizedDescription ?? Constants.MensagensErro.erroDesconhecido)")
                return
            }
            
            if let chatresponse = try? JSONDecoder().decode(ChatResponse.self, from: data) { //Decodifica a resposta
                completion(chatresponse.choices?.first?.message?.content ?? Constants.MensagensErro.erroDecodificacao)
                
            } else {
                completion(Constants.MensagensErro.respostaInesperada) //Retorna resposta para erro de decodificação
            }
        }
        task.resume()
    }
}
