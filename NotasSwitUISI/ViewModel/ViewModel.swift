//
//  ViewModel.swift
//  NotasSwitUISI
//
//  Created by Ricardo Roman Landeros on 25/05/22.
//

import Foundation
import CoreData
import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    //agregamos una nueva propiedad para actulizar un elemtno
    @Published var updateitem: Notas!
    
    
    //CoreData
    func saveData(context: NSManagedObjectContext){
        //Con este context es como la conneccion ala base de datos
        //y creamos un nuevo objeto de la clase Notas que creamos
        let newNota = Notas(context: context)
        //llenamos la nuena nota ocn los datos que traemos desde el @Published
        newNota.nota = self.nota
        newNota.fecha = self.fecha
        
        do {
            try context.save() //guardamos lo que traemos en la coneccion
            print("se guardo ") //aqui podmeos hacer una alerta para avisar que si guardo
            self.show.toggle()
        } catch let error as NSError {
            //aqui tambien una alerta para aviasar al usuario porque no guardo
            print("No Guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notas, context: NSManagedObjectContext){
        context.delete(item)
        do {
            try context.save() //guardamos lo que traemos en la coneccion
            print("Se elimino ") //aqui podmeos hacer una alerta para avisar que si guardo
        } catch let error as NSError {
            //aqui tambien una alerta para aviasar al usuario porque no guardo
            print("No Elimino", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas){
        //esta funcion lo que hace esque hace un reguardo de los datos que quermeos actulizar y ala ves nos muestras los datos en la pantalla de AddView
        updateitem = item //este item es al que le dimos clik en el menu contextual
        self.nota = item.nota ?? ""
        self.fecha = item.fecha ?? Date()
        //y abrimos la addView para ver estos datos que traemos
        self.show.toggle()
    }
    
    func editData(context: NSManagedObjectContext){
        updateitem.fecha = self.fecha
        updateitem.nota = self.nota
        do {
            try context.save() //guardamos lo que traemos en la coneccion
            print("Se edito ") //aqui podmeos hacer una alerta para avisar que si guardo
            self.show.toggle()
        } catch let error as NSError {
            //aqui tambien una alerta para aviasar al usuario porque no guardo
            print("No edito", error.localizedDescription)
        }
    }
}
