# class Minhaclasse
#
#   def c=(valor)
#     @c = valor
#   end
#
#   # def initialize(x)
#   # end
#
#   def self.troca
#     #puts @c.sub('um','1')
#     #self.c = @c.sub('um','1')
#     puts "aa"
#   end
#
#
#
#
# end
#
# a = Minhaclasse.new
# a.c = 'umdois'
# Minhaclasse.troca
#
# #puts a.inspect


#############################################

# class Minhaclasse2
#
#   def c=(valor)
#       @c = valor
#   end
#
#   def c
#       puts @c
#   end
#
#   def troca
#     puts @c.sub("dois", "2")
#   end
#
#   def troca!
#     puts @c.sub("dois", "2")
#     @c = @c.sub("dois", "2")
#     self.c = @c.sub("dois", "2")
#   end
#
#
#
# end
#
# a  = Minhaclasse2.new
# a.c = "um-dois-tres"
# a.troca!
# a.c


#############################################

class Minhaclasse3

  def initialize=(valor)
      @c = valor
  end

  def initialize
      puts @c
  end

  def troca
    puts @c.sub("dois", "2")
  end

  def troca!
    puts @c.sub("dois", "2")
    @c = @c.sub("dois", "2")
    self.c = @c.sub("dois", "2")
  end



end

a  = Minhaclasse3.new
a = "um-dois-tres"
puts a.class
