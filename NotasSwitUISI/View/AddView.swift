//
//  AddView.swift
//  NotasSwitUISI
//
//  Created by Ricardo Roman Landeros on 25/05/22.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var model: ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.updateitem != nil ? "Editar Nota" : "Agregar Nota")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.nota)
            Divider()
            DatePicker("Seleccionar Fecha", selection: $model.fecha)
            Spacer()
            Button {
                if model.updateitem != nil {
                    model.editData(context: context)
                } else {
                    model.saveData(context: context)
                }
               
            } label: {
                Label {
                    Text("Guardar")
                        .foregroundColor(.white)
                        .bold()
                } icon: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }

            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 30)
            .background(.blue)
            .cornerRadius(10)
            .disabled(model.nota == "" ? true : false)

        }.padding()
        
    }
}


