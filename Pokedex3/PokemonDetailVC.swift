//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Leandro Bevilaqua on 11/06/17.
//  Copyright © 2017 Leandro Bevilaqua. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var viewEvolution: UIView!
    
    @IBOutlet weak var evoStack: UIStackView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.startAnimating()
        
        pokemon.downloadPokemonDetail{
            
            self.updateUI()
            
            if self.descriptionLbl.text != ""{
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                self.mainStack.isHidden = false
                self.evoStack.isHidden = false
                self.viewEvolution.isHidden = false
            }
        }
    }
    
    func updateUI() {
        
        nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        pokedexIDLbl.text = "\(pokemon.pokedexId)"
        
        descriptionLbl.text = pokemon.description
        baseAttackLbl.text = pokemon.baseAttack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            
            let nextEvolTxt = "Next Evolution: \(pokemon.nextEvolutionName) - Level \(pokemon.nextEvolutionLevel)"
            evoLbl.text = nextEvolTxt
        }
    }


    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
