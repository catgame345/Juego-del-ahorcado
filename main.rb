class Ahorcado
  def initialize
    @letters = ('a'.."z").to_a
    @word = words.sample
    @vidas = 7
    @word_teaser = ""

    @word.first.size.times do
      @word_teaser += "_ "
    end
  end

  def words
    [
      ["cricket", "Un juego jugado por una persona agradable"],
      ["correr", "No estamos caminando..."],
      ["celebrar", "Recordando momentos especiales"],
      ["continente", "Hay siete de estos"],
      ["exotico", "No es de por aqui..."],
      ["programa", "Accion de mandar instrucciones a una maquina"],
    ]
  end

  def print_teaser last_guess = nil
    update_teaser(last_guess) unless last_guess.nil?

    puts @word_teaser
  end

  def update_teaser last_guess
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      if letter == '_' && @word.first[index] == last_guess
        new_teaser[index] = last_guess
      end
    end

    @word_teaser = new_teaser.join(' ')
  end

  def make_guess
    if @vidas > 0
      puts "Ingresa una letra"
      guess = gets.chomp

      good_guess = @word.first.include? guess

      if guess == "salir"
        puts "Gracias por jugar!"
      elsif good_guess
        puts "Respuesta correcta!"

        print_teaser guess

        if @word.first == @word_teaser.split.join
          puts "Felicidades... has ganado esta ronda!"
        else
          make_guess
        end
      else
        @vidas -= 1
        if @vidas == 1
          puts "Perdon... tienes #{@vidas} vida. Prueba de nuevo!"
        else
          puts "Perdon... tienes #{@vidas} vidas. Prueba de nuevo!"
        end
        make_guess
      end
    else
      puts "Juego acabado!"
    end
  end

  def comienzo
    puts "Nuevo juego comenzando... tu palabra tiene #{@word.first.size} caractares"
    puts "Para salir del juego en cualquier momento escribe 'salir'"
    print_teaser
    puts "Pista: #{@word.last}"
    make_guess
  end
end

game = Ahorcado.new
game.comienzo
