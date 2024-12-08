//
//  ContentView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var viewModel: WochenplanViewModel
    @State private var isShowingAddGericht = false
    @State private var selectedGericht: Gericht?
    @State private var selectedWochentag: Wochentag?
    @State private var showEinkaufsliste = false

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.wochentage.values.allSatisfy({ $0.isEmpty }) {
                    EmptyWochenplanView()
                } else {
                    List {
                        ForEach(Wochentag.allCases, id: \.self) { tag in
                            if let gerichte = viewModel.wochentage[tag], !gerichte.isEmpty {
                                Section(header: Text(tag.rawValue)) {
                                    ForEach(gerichte) { gericht in
                                        NavigationLink(
                                            destination: GerichtDetailView(
                                                gericht: gericht,
                                                wochentag: tag
                                            )
                                        ) {
                                            Image(systemName: "fork.knife")
                                            Text(gericht.name)
                                        }
                                        .listRowBackground(Color.primary)
                                        .foregroundColor(Color.white)
                                    }
                                    .onMove { indices, newOffset in
                                        viewModel.moveGericht(
                                            within: tag,
                                            from: indices,
                                            to: newOffset
                                        )
                                    }
                                    .onDelete { indices in
                                        viewModel.deleteGericht(
                                            at: indices,
                                            from: tag
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Dein Wochenplan")
                    .scrollContentBackground(.hidden)
                }

                VStack {
                    Spacer()
                    HStack {
                        ActionButton {
                            self.isShowingAddGericht = true
                        }
                    }
                }
                .sheet(isPresented: $isShowingAddGericht) {
                    AddGerichtView(viewModel: viewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            viewModel.deleteAllGerichte()
                        }) {
                            Label("Alle Gerichte löschen", systemImage: "trash.fill")
                                .foregroundColor(.red)
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

#Preview("Mit Inhalt") {
    ContentView()
        .environmentObject(PreviewContent.previewViewModelWithContent)
}

#Preview("Ohne Inhalt") {
    ContentView()
        .environmentObject(PreviewContent.previewViewModelEmpty)
}

