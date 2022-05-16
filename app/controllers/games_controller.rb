require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      letter = ('a'..'z').to_a.sample
      @letters << letter
    end
  end

  def score
    @letters = params[:letters].split.join(", ")
    @word = params[:word].upcase
    included = included?(@word, @letters)
    english = english_word?(@word)
    not_english = !english_word?(@word)
    if included & english
      @answer = "Congratulations! #{@word} is a valid English word"
    elsif included & not_english
      @answer = "Sorry but #{@word} does not seem to be a valid English word..."
    else # Pas inclus et pas Anglais
      @answer = "Sorry but #{@word} cant' be built out of #{@letters}"
    end
  end
  end

 private
  def english_word?(@word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    word["found"]
  end

  def included?(word, letters) #("minee", [A, B, C, D, E, F, G, H, I, J])
    word.chars.all? do |letter|
    # .chars => Return an Array of characters of a string => ["m", "i", "n", "e", "e"]
    # .all?  => Passes each element of the collection donc "m" puis "i" puis "n" puis "e" puis "e"
    word.count(letter) <= letters.count(letter)
    # Je compte le nb de A dans ["m", "i", "n", "e", "e"]
    # ...
    # Je compte le nb de E dans ["m", "i", "n", "e", "e"] = 2
    # Je vérifie que ce nb est <= au nb de fois où la lettre appararaît ds lettres (au nb de fois où E apparaît dans [A, B, C, D, E, F, G, H, I, J])
    # included? vrai si word.chars.all? vrai si <= vrai
    end
  end

  end
  # On veut maîtriser trois scénarios :

  # Le mot ne peut pas être créé à partir de la grille d’origine.
  # Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide.
  # Le mot est valide d’après la grille et est un mot anglais valide.

end
