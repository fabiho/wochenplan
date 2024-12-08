//
//  PreviewContent.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 29.11.24.
//

import Foundation
import SwiftUI

struct PreviewContent {
    
//    static let standardKategorien = [
//        Kategorie(name: "Obst & Gemüse"),
//        Kategorie(name: "Kühltheke"),
//        Kategorie(name: "Dosen")
//    ]
    
    static let zutatenSpaghettiBolognese = [
        Zutat(name: "Spaghetti", erledigt: false, kategorie: .Dosen),
            Zutat(name: "Hackfleisch", erledigt: false, kategorie: .Dosen),
            Zutat(name: "Tomatensauce", erledigt: false, kategorie: .Dosen),
            Zutat(name: "Zwiebeln", erledigt: false, kategorie: .Obst),
            Zutat(name: "Knoblauch", erledigt: false, kategorie: .Obst)
        ]

        static let zutatenCaesarSalad = [
            Zutat(name: "Römersalat", erledigt: false, kategorie: .Obst),
            Zutat(name: "Hähnchenbrust", erledigt: false, kategorie: .Dosen),
            Zutat(name: "Croutons", erledigt: false, kategorie: nil),
            Zutat(name: "Parmesan", erledigt: false, kategorie: .Dosen),
            Zutat(name: "Caesar Dressing", erledigt: false, kategorie: .Dosen)
        ]

        static let zutatenHähnchenCurry = [
            Zutat(name: "Hähnchenbrust", erledigt: false, kategorie: .Dosen),
            Zutat(name: "Curry", erledigt: false, kategorie: nil),
            Zutat(name: "Kokosmilch", erledigt: false, kategorie: .Dosen),
            Zutat(name: "Paprika", erledigt: false, kategorie: .Obst),
            Zutat(name: "Reis", erledigt: false, kategorie: .Dosen)
        ]
    
    static let zutatenGemüseLasagne = [
        Zutat(name: "Lasagneblätter", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Zucchini", erledigt: false, kategorie: .Obst),
        Zutat(name: "Auberginen", erledigt: false, kategorie: .Obst),
        Zutat(name: "Tomaten", erledigt: false, kategorie: .Obst),
        Zutat(name: "Béchamelsauce", erledigt: false, kategorie: .Dosen)
    ]

    static let zutatenLachsfilet = [
        Zutat(name: "Lachs", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Zitronensaft", erledigt: false, kategorie: nil),
        Zutat(name: "Kräuter", erledigt: false, kategorie: nil),
        Zutat(name: "Kartoffeln", erledigt: false, kategorie: .Obst),
        Zutat(name: "Brokkoli", erledigt: false, kategorie: .Obst)
    ]

    static let zutatenPizzaMargherita = [
        Zutat(name: "Pizzateig", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Tomatensauce", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Mozzarella", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Basilikum", erledigt: false, kategorie: .Obst)
    ]

    static let zutatenVegetarischerBurger = [
        Zutat(name: "Vegetarische Patties", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Burgerbrötchen", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Salat", erledigt: false, kategorie: .Obst),
        Zutat(name: "Tomaten", erledigt: false, kategorie: .Obst),
        Zutat(name: "Ketchup", erledigt: false, kategorie: .Dosen)
    ]

    static let zutatenTacos = [
        Zutat(name: "Taco-Schalen", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Hackfleisch", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Käse", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Tomaten", erledigt: false, kategorie: .Obst),
        Zutat(name: "Salat", erledigt: false, kategorie: .Obst),
        Zutat(name: "Salsa", erledigt: false, kategorie: .Dosen)
    ]

    static let zutatenBratenMitKnödeln = [
        Zutat(name: "Schweinebraten", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Kartoffeln", erledigt: false, kategorie: .Obst),
        Zutat(name: "Mehl", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Eier", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Sauerkraut", erledigt: false, kategorie: .Obst)
    ]

    static let zutatenPfannkuchen = [
        Zutat(name: "Mehl", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Eier", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Milch", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Zucker", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Vanillezucker", erledigt: false, kategorie: .Dosen)
    ]

    
    static let exampleGerichteMontag = [
        Gericht(name: "Spaghetti Bolognese", zutaten: zutatenSpaghettiBolognese),
        Gericht(name: "Caesar Salad", zutaten: zutatenCaesarSalad)
    ]
    
    static let exampleGerichteDienstag = [
        Gericht(name: "Hähnchen Curry", zutaten: zutatenHähnchenCurry)
    ]
    
    static let exampleGerichteMittwoch = [
        Gericht(name: "Lachsfilet", zutaten: zutatenLachsfilet)
    ]
    static let exampleGerichteDonnerstag = [
        Gericht(name: "Pizza Margherita", zutaten: zutatenPizzaMargherita)
    ]
    
    static let exampleGerichteFreitag = [
        Gericht(name: "Vegetarischer Burger", zutaten: zutatenVegetarischerBurger)
    ]
    
    static let exampleGerichteSamstag = [
        Gericht(name: "Tacos", zutaten: zutatenTacos)
    ]
    
    static let exampleGerichteSonntag = [
        Gericht(name: "Braten mit Knödeln", zutaten: zutatenBratenMitKnödeln),
        Gericht(name: "Pfannkuchen", zutaten: zutatenPfannkuchen)
    ]
    
    static let exampleWochentage = [
        Wochentag(name: "Montag", gerichte: exampleGerichteMontag),
        Wochentag(name: "Dienstag", gerichte: exampleGerichteDienstag),
        Wochentag(name: "Mittwoch", gerichte: exampleGerichteMittwoch),
        Wochentag(name: "Donnerstag", gerichte: exampleGerichteDonnerstag),
        Wochentag(name: "Freitag", gerichte: exampleGerichteFreitag),
        Wochentag(name: "Samstag", gerichte: exampleGerichteSamstag),
        Wochentag(name: "Sonntag", gerichte: exampleGerichteSonntag)
    ]
    
    static let exampleEmptyGericht: [Gericht] = []
    
    static let exampleEmptyWochentage: [Wochentag] = [
            Wochentag(name: "Montag", gerichte: exampleEmptyGericht),
            Wochentag(name: "Dienstag", gerichte: exampleEmptyGericht),
            Wochentag(name: "Mittwoch", gerichte: exampleEmptyGericht),
            Wochentag(name: "Donnerstag", gerichte: exampleEmptyGericht),
            Wochentag(name: "Freitag", gerichte: exampleEmptyGericht),
            Wochentag(name: "Samstag", gerichte: exampleEmptyGericht),
            Wochentag(name: "Sonntag", gerichte: exampleEmptyGericht)
        ]
    
    static let previewViewModelWithContent = WochenplanViewModel(previewData: exampleWochentage)
    
    static let previewViewModelEmpty = WochenplanViewModel(previewData: exampleEmptyWochentage)
}
