class Jawna
  def initialize(message)
    @code = message
  end

  def zaszyfruj(key)
    @res = String.new
    @code.each_char do |c|
      @res += key[c]
    end
    @code = @res
  end

  def to_s
    @code
  end
end

class Zaszyfrowana
  def initialize(message)
    @ciphered = message
  end

  def odszyfruj(key)
    @res = String.new
    key = key.invert

    @ciphered.each_char do |c|
      @res += key[c]
    end

    @ciphered = @res
  end

  def to_s
    @ciphered
  end
end

klucz = Hash[" " => " ", "a" => "a", "b" => "e", "c" => "j", "d" => "o",
             "e" => "w", "f" => "b", "g" => "f", "h" => "k", "i" => "p",
             "j" => "y", "k" => "c", "l" => "g", "m" => "l", "n" => "r",
             "o" => "z", "p" => "d", "r" => "h", "s" => "m", "t" => "s",
             "u" => "v", "v" => "e", "w" => "i", "x" => "n", "y" => "t", "z" => "u"]

doSzyfrowania = Jawna.new("ala ma kota a kot ma czerwonego psa")
doSzyfrowania.zaszyfruj(klucz)
puts doSzyfrowania.to_s

doOdszyfrowania = Zaszyfrowana.new(doSzyfrowania.to_s)
doOdszyfrowania.odszyfruj(klucz)
puts doOdszyfrowania.to_s

doSzyfrowania2 = Jawna.new("wyrewolwerowany rewolwerowiec wyrewolwerowal swoj nie wyrewolwerowany rewolwer")
doSzyfrowania2.zaszyfruj(klucz)
puts doSzyfrowania2.to_s

doOdszyfrowania2 = Zaszyfrowana.new(doSzyfrowania2.to_s)
doOdszyfrowania2.odszyfruj(klucz)
puts doOdszyfrowania2.to_s