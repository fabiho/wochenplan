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
        Zutat(name: "Spaghetti", erledigt: false, kategorie: .Nudeln),
        Zutat(name: "Hackfleisch", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Tomatensauce", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Zwiebeln", erledigt: false, kategorie: .Obst),
        Zutat(name: "Knoblauch", erledigt: false, kategorie: .Obst)
    ]
    
    static let zutatenCaesarSalad = [
        Zutat(name: "Römersalat", erledigt: false, kategorie: .Obst),
        Zutat(name: "Hähnchenbrust", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Croutons", erledigt: false, kategorie: .Brot),
        Zutat(name: "Parmesan", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Caesar Dressing", erledigt: false, kategorie: .Dosen)
    ]
    
    static let zutatenHähnchenCurry = [
        Zutat(name: "Hähnchenbrust", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Curry", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Kokosmilch", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Paprika", erledigt: false, kategorie: .Obst),
        Zutat(name: "Reis", erledigt: false, kategorie: .Nudeln)
    ]
    
    static let zutatenGemüseLasagne = [
        Zutat(name: "Lasagneblätter", erledigt: false, kategorie: .Nudeln),
        Zutat(name: "Zucchini", erledigt: false, kategorie: .Obst),
        Zutat(name: "Auberginen", erledigt: false, kategorie: .Obst),
        Zutat(name: "Tomaten", erledigt: false, kategorie: .Obst),
        Zutat(name: "Béchamelsauce", erledigt: false, kategorie: .Dosen)
    ]
    
    static let zutatenLachsfilet = [
        Zutat(name: "Lachs", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Zitronensaft", erledigt: false, kategorie: .Getränke),
        Zutat(name: "Kräuter", erledigt: false, kategorie: .Obst),
        Zutat(name: "Kartoffeln", erledigt: false, kategorie: .Obst),
        Zutat(name: "Brokkoli", erledigt: false, kategorie: .Obst)
    ]
    
    static let zutatenPizzaMargherita = [
        Zutat(name: "Pizzateig", erledigt: false, kategorie: .Nudeln),
        Zutat(name: "Tomatensauce", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Mozzarella", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Basilikum", erledigt: false, kategorie: .Obst)
    ]
    
    static let zutatenVegetarischerBurger = [
        Zutat(name: "Vegetarische Patties", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Burgerbrötchen", erledigt: false, kategorie: .Brot),
        Zutat(name: "Salat", erledigt: false, kategorie: .Obst),
        Zutat(name: "Tomaten", erledigt: false, kategorie: .Obst),
        Zutat(name: "Ketchup", erledigt: false, kategorie: .Dosen)
    ]
    
    static let zutatenTacos = [
        Zutat(name: "Taco-Schalen", erledigt: false, kategorie: .Brot),
        Zutat(name: "Hackfleisch", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Käse", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Tomaten", erledigt: false, kategorie: .Obst),
        Zutat(name: "Salat", erledigt: false, kategorie: .Obst),
        Zutat(name: "Salsa", erledigt: false, kategorie: .Dosen)
    ]
    
    static let zutatenBratenMitKnödeln = [
        Zutat(name: "Schweinebraten", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Kartoffeln", erledigt: false, kategorie: .Obst),
        Zutat(name: "Mehl", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Eier", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Sauerkraut", erledigt: false, kategorie: .Dosen)
    ]
    
    static let zutatenPfannkuchen = [
        Zutat(name: "Mehl", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Eier", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Milch", erledigt: false, kategorie: .Kühltheke),
        Zutat(name: "Zucker", erledigt: false, kategorie: .Dosen),
        Zutat(name: "Vanillezucker", erledigt: false, kategorie: .Dosen)
    ]
    
    
    static let exampleGerichteMontag = [
        Gericht(name: "Spaghetti Bolognese", zutaten: zutatenSpaghettiBolognese, wochentag: .montag),
        Gericht(name: "Caesar Salad", zutaten: zutatenCaesarSalad, wochentag: .montag)
    ]
    
    static let exampleGerichteDienstag = [
        Gericht(name: "Hähnchen Curry", zutaten: zutatenHähnchenCurry, wochentag: .dienstag)
    ]
    
    static let exampleGerichteMittwoch = [
        Gericht(name: "Lachsfilet", zutaten: zutatenLachsfilet, wochentag: .mittwoch)
    ]
    static let exampleGerichteDonnerstag = [
        Gericht(name: "Pizza Margherita", zutaten: zutatenPizzaMargherita, wochentag: .donnerstag)
    ]
    
    static let exampleGerichteFreitag = [
        Gericht(name: "Vegetarischer Burger", zutaten: zutatenVegetarischerBurger, wochentag: .freitag)
    ]
    
    static let exampleGerichteSamstag = [
        Gericht(name: "Tacos", zutaten: zutatenTacos, wochentag: .samstag)
    ]
    
    static let exampleGerichteSonntag = [
        Gericht(name: "Braten mit Knödeln", zutaten: zutatenBratenMitKnödeln, wochentag: .sonntag),
        Gericht(name: "Pfannkuchen", zutaten: zutatenPfannkuchen, wochentag: .sonntag)
    ]
    
    static let exampleWochentage: [Wochentag: [Gericht]] = [
        .montag: exampleGerichteMontag,
        .dienstag: exampleGerichteDienstag,
        .mittwoch: exampleGerichteMittwoch,
        .donnerstag: exampleGerichteDonnerstag,
        .freitag: exampleGerichteFreitag,
        .samstag: exampleGerichteSamstag,
        .sonntag: exampleGerichteSonntag
    ]
    
    static let exampleEmptyWochentage: [Wochentag: [Gericht]] = [
        .montag: [],
        .dienstag: [],
        .mittwoch: [],
        .donnerstag: [],
        .freitag: [],
        .samstag: [],
        .sonntag: []
    ]
    
    static let previewViewModelWithContent = WochenplanViewModel(previewData: exampleWochentage)
    static let previewViewModelEmpty = WochenplanViewModel(previewData: exampleEmptyWochentage)
}
