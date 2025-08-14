/*Kelime Oyunu Alıştırması
Görev:
Bilgisayar kelimeyi karıştırır,  doğru kelimeyi bul!
Örnek: LMAE → ELMA
Kullanacağın Konular:
Array (kelime listesi için)
String (harfleri karıştırmak için)
Koşul (doğru/yanlış kontrol için)
*/

// Word Game
// Create a word game where a word is shuffled and the user has to guess it.

import Foundation

let areas = ["Maltepe", "beykoz", "kadikoy", "atasehir", "pendik"]

let chosenWord = areas.randomElement()!

func shuffleLet(_ word: String) -> String {
    return String(word.shuffled())
}

// Shuffle the chosen word
let shuffledLet = shuffleLet(chosenWord)

print("Shuffled Word: \(shuffledLet)")

// Simulate a prediction (in a real game, this would be user input)
let prediction = "maltepe"

if prediction.lowercased() == chosenWord {
    print("Congratulations! \(chosenWord)")
} else {
    print("Incorrect! Truth: \(chosenWord)")
}
