
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
	attr_accessor :size, :head, :tail, :n

	def initialize()
		@size = 0
		@head = Node.new(nil,nil,nil)
		@tail = Node.new(nil,nil,nil)
	end

	def push(val)
		n = Node.new(val,nil,nil)
		if(@size == 0)
			@tail = n
			n.next = nil
		else
			@head.prev = n
			n.next = @head
		end
		@head = n
		n.prev = nil
		@size = @size + 1
	end

	def pop_head()
		if (@size == 0)
			puts "Lista vacia"
		else
			drop = @head.value
			(@head.next).prev = nil
			@head = @head.next
			@size = @size - 1
			return drop
		end
	end

	def pop_tail()
		if (size == 0)
			puts "Lista vacia"
		else
			drop = @tail.value
			(@tail.prev).next = nil
			@tail = @tail.prev
			@size = size - 1
			return drop
		end
	end





end

