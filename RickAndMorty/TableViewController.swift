//
//  TableViewController.swift
//  BackgroundContent
//
//  Created by Ángel González on 29/10/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var personajeSelected: Result?
    var personajes = [Result]()
    let ad = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view
        if ad.internetStatus {
            loadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        

        
        if ad.internetStatus == false {
            showAlert()
        }
        
    }
    
    func loadData(){
        if let url=URL(string: "https://rickandmortyapi.com/api/character/") {
                        do {
                            let bytes = try Data(contentsOf: url)
                            let rick = try JSONDecoder().decode(Rick.self, from: bytes)
                            personajes = rick.results
                        }
                        catch {
                        }
                    }
    }
    
    func showAlert(){
        let ac = UIAlertController(title:"Error", message:"Lo sentimos, pero al parecer no hay conexión a Internet", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Enterado", style: .default)
                    ac.addAction(action)
                    self.present(ac, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personajes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let personaje = personajes[indexPath.row]
        cell.textLabel?.text = personaje.name

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.personajeSelected = personajes[indexPath.row]
        if ad.internetStatus {
            performSegue(withIdentifier: "ShowPersonSegue", sender: Self.self)
        }else{
            showAlert()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let destination = segue.destination as! ViewController
        destination.imageUrl = self.personajeSelected?.image
        
    
    }
    

}
