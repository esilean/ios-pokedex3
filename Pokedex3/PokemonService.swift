//
//  PokemonService.swift
//  Pokedex3
//
//  Created by Leandro Bevilaqua on 11/06/17.
//  Copyright © 2017 Leandro Bevilaqua. All rights reserved.
//

import Foundation
import AVFoundation

class PokemonService {
    
    static var pokeService = PokemonService()
    private init() {}
    
    private var _musicPlayer: AVAudioPlayer!
    private var _isPlaying: Bool!
    
    var isPlaying: Bool {
        return _isPlaying
    }
    
    func parsePokemonCSV() -> [Pokemon] {
        
        var pokemons = [Pokemon]()
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                
                pokemons.append(poke)
            }
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return pokemons
        
    }
    
    func initAudio(){
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            self._musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            self._musicPlayer.prepareToPlay()
            self._musicPlayer.numberOfLoops = -1
            self._musicPlayer.play()
            self._isPlaying = true
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func controlAudio(){
        if self._musicPlayer.isPlaying {
            self._musicPlayer.pause()
            self._isPlaying = false
        } else {
            self._musicPlayer.play()
            self._isPlaying = true
        }
    }
    
    
}
