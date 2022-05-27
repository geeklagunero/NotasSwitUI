//
//  Home.swift
//  NotasSwitUISI
//
//  Created by Ricardo Roman Landeros on 25/05/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    //peticion para recuperar todos los elementos de la base de datos
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results: FetchedResults<Notas>
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(results) {item in
                    VStack(alignment: .leading) {
                        Text(item.nota ?? "Sin Nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }
                    .contextMenu{
                        Button {
                            model.sendData(item: item)
                        } label: {
                            Label {
                                Text("Editar")
                            } icon: {
                                Image(systemName: "pencil")
                            }

                        }//fon del boton editar
                        
                        Button {
                            model.deleteData(item: item, context: context)
                        } label: {
                            Label {
                                Text("Elimnar")
                            } icon: {
                                Image(systemName: "trash")
                            }

                        }

                    }//fin del contextMenu

                }//fin del forrech
            }
            .navigationTitle("Notas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        model.show.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }//fon del ToolBarItem
                

            }.sheet(isPresented: $model.show) { //cuando show es true se abre la ventana
                AddView(model: model)
            }
        }//fin del navigationView
        

    }
}

