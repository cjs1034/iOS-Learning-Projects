//
//  ConnectionDetailView.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//

import SwiftUI

struct ConnectionDetailView: View {
    @ObservedObject var viewModel: ConnectionDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                if viewModel.isEditing {
                    TextField("Name", text: $viewModel.editedName)
                } else {
                    Text(viewModel.connection.name ?? "Unknown")
                }
            }

            Section(header: Text("Details")) {
                if viewModel.isEditing {
                    ForEach(viewModel.editedDetails.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        HStack {
                            Text(key)
                                .font(.caption)
                            Spacer()
                            Text(value)
                                .font(.caption)
                            Button(action: {
                                viewModel.deleteDetail(key: key)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    AddDetailView(addDetailAction: viewModel.addDetail)
                } else {
                    ForEach(viewModel.connection.details?.sorted(by: { $0.key < $1.key }) ?? [], id: \.key) { key, value in
                        HStack {
                            Text(key).font(.caption)
                            Spacer()
                            Text(value).font(.caption)
                        }
                    }
                }
            }

            Section(header: Text("Last Contacted")) {
                Text(viewModel.connection.formattedLastContacted)
            }

            Section {
                Button("Mark as Contacted") {
                    viewModel.markAsContacted()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle(viewModel.connection.name ?? "Connection Details")
        .navigationBarItems(trailing: Button(viewModel.isEditing ? "Done" : "Edit") {
            if viewModel.isEditing {
                viewModel.saveChanges()
            }
            viewModel.isEditing.toggle()
        })
    }
}
