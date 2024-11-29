//
//  PreviewContent.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 29.11.24.
//

import Foundation
import SwiftUI

struct PreviewContent {
    static let zutatenSpaghettiBolognese = [
        Zutat(name: "Spaghetti"),
        Zutat(name: "Hackfleisch"),
        Zutat(name: "Tomatensauce"),
        Zutat(name: "Zwiebeln"),
        Zutat(name: "Knoblauch")
    ]
    
    static let zutatenCaesarSalad = [
        Zutat(name: "Römersalat"),
        Zutat(name: "Hähnchenbrust"),
        Zutat(name: "Croutons"),
        Zutat(name: "Parmesan"),
        Zutat(name: "Caesar Dressing")
    ]
    
    static let zutatenHähnchenCurry = [
        Zutat(name: "Hähnchenbrust"),
        Zutat(name: "Curry"),
        Zutat(name: "Kokosmilch"),
        Zutat(name: "Paprika"),
        Zutat(name: "Reis")
    ]
    
    static let zutatenGemüseLasagne = [
        Zutat(name: "Lasagneblätter"),
        Zutat(name: "Zucchini"),
        Zutat(name: "Auberginen"),
        Zutat(name: "Tomaten"),
        Zutat(name: "Béchamelsauce")
    ]
    
    static let zutatenLachsfilet = [
        Zutat(name: "Lachs"),
        Zutat(name: "Zitronensaft"),
        Zutat(name: "Kräuter"),
        Zutat(name: "Kartoffeln"),
        Zutat(name: "Brokkoli")
    ]
    
    static let zutatenPizzaMargherita = [
        Zutat(name: "Pizzateig"),
        Zutat(name: "Tomatensauce"),
        Zutat(name: "Mozzarella"),
        Zutat(name: "Basilikum")
    ]
    
    static let zutatenVegetarischerBurger = [
        Zutat(name: "Vegetarische Patties"),
        Zutat(name: "Burgerbrötchen"),
        Zutat(name: "Salat"),
        Zutat(name: "Tomaten"),
        Zutat(name: "Ketchup")
    ]
    
    static let zutatenTacos = [
        Zutat(name: "Taco-Schalen"),
        Zutat(name: "Hackfleisch"),
        Zutat(name: "Käse"),
        Zutat(name: "Tomaten"),
        Zutat(name: "Salat"),
        Zutat(name: "Salsa")
    ]
    
    static let zutatenBratenMitKnödeln = [
        Zutat(name: "Schweinebraten"),
        Zutat(name: "Kartoffeln"),
        Zutat(name: "Mehl"),
        Zutat(name: "Eier"),
        Zutat(name: "Sauerkraut")
    ]
    
    static let zutatenPfannkuchen = [
        Zutat(name: "Mehl"),
        Zutat(name: "Eier"),
        Zutat(name: "Milch"),
        Zutat(name: "Zucker"),
        Zutat(name: "Vanillezucker")
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
