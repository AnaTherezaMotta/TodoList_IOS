//
//  ViewController.swift
//  TodoList
//
//  Created by COTEMIG on 17/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listaDeTarefas: [String] = []
    //let listaKey = "chaveLista"
    let listKey: String = "todolist"
    let tipoQualquer = Any?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        if let list = UserDefaults.standard.value(forKey: listKey) as? [String] {
            listaDeTarefas.append(contentsOf: list)
        }
        
    }

    @IBAction func addTassk(_ sender: Any) {
        let alert = UIAlertController(title: "Adicionar tarefa",
                                      message: "Qual o nomeda tarefa?",
                                      preferredStyle:  .alert)
        
        let acaoSalvar = UIAlertAction(title: "Salvar",
                                       style: .default){(action) in
            if let textField = alert.textFields?.first, let textoDigitado = textField.text{
                                self.listaDeTarefas.append(textoDigitado)
                                self.tableView.reloadData()
                                UserDefaults.standard.set(self.listaDeTarefas, forKey: self.listKey)
                
                            }
                                        
        }
        
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        
        alert.addAction(acaoSalvar)
        alert.addAction(acaoCancelar)
        //alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addTextField()
        present(alert, animated: true)

    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeTarefas.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaDeTarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listaDeTarefas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.listaDeTarefas, forKey: self.listKey)
        }
    }
    
}


