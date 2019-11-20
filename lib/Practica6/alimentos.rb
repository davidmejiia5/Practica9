
Node = Struct.new(:value, :next, :prev)

class Alimento
	
	attr_accessor :ali, :gas, :te

        def initialize(a,p,c,l,g,t)
                @ali = a
                @pro = p
                @carb = c
                @lip = l
                @gas = g
                @te = t
        end
	def get_ali
                return @ali
        end

        def get_gas
                return @gas
        end

        def get_te
                return @te
        end

        def valor_energetico
                return (@pro+4)+(@carb+4)+(@lip+9)
        end

        def to_s
                "(#{@ali},#{@pro},#{@carb},#{@lip},#{@gas},#{@te})"
        end

end


class Lista

	attr_accessor :size, :head, :tail

	def initialize()
		@size = 0
		@head = nil
		@tail = nil
	end

	def push(val)
		if(@size == 0)
			@Head = val
			val.next = nil
		else
			@head.prev = val
			val.next = @head
		end
		@head = val
		val.prev = nil
		@size = @size + 1
	end





end

