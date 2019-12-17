
Node = Struct.new(:value, :next, :prev)

class Alimento
	
	include Comparable
	attr_accessor :ali, :gas, :te, :pro, :carb, :lip

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


	def <=>(toCompare)
		@ali <=> toCompare.ali
	end

end


class Lista
	include Enumerable
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

	def each
		nodo = @head
		while (nodo != nil)
			yield nodo.value
			nodo = nodo.next
		end
	end
end


class Plato
	attr_accessor :nombre_, :listAlimentos_
	def initialize(name)
		@nombre_ = name
		@listAlimentos_ = Lista.new
		@listGramos_ = Lista.new
	end

	def insert_alimento(alimento)
		@listAlimentos_.push(alimento)
	end

	def insert_gramos(gramos)
		@listGramos_.push(gramos)
	end

	def get_alimentos
		return @listAlimentos_
	end

	def get_gramos
		return @listGramos_
	end

	def get_proteinas
		p = 0
		iter = 0
		iterador2 = 0
		@listGramos_.each do |gramos|
			gr = gramos
			iter = iter + 1
			@listAlimentos_.each do |element|
				iterador2 = iterador2 + 1
				if (iter == iterador2)	
					p = p + gr*element.pro/100
				end
			end
			iterador2 = 0
		end
		return p
	end

	def get_lipidos
		l = 0
                iter = 0
                iterador2 = 0
                @listGramos_.each do |gramos|
                        gr = gramos
                        iter = iter + 1
                        @listAlimentos_.each do |element|
                                iterador2 = iterador2 + 1
                                if (iter == iterador2)
                                        l = l + gr*element.lip/100
                                end
                        end
                        iterador2 = 0
                end
                return l
	end

	def get_carbohidratos
		c = 0
                iter = 0
                iterador2 = 0
                @listGramos_.each do |gramos|
                        gr = gramos
                        iter = iter + 1
                        @listAlimentos_.each do |element|
                                iterador2 = iterador2 + 1
                                if (iter == iterador2)
                                        c = c + gr*element.carb/100
                                end
                        end
                        iterador2 = 0
                end
                return c
	end
	
	def get_VCT
		total = 0
		@listGramos_.each do |grams|
			total = total + grams
		end
		pro = (get_proteinas*total)/100
		li = (get_lipidos*total)/100
		car = (get_carbohidratos*total)/100
		return ((pro*4)+(li*9)+(car*4))
	end


	def to_s
		alimentos = "El plato esta formado por: " 
		@listAlimentos_.each do |element|
			alimentos = alimentos + element.ali
			alimentos = alimentos + " "
		end
		return alimentos
	end
end

class Ambiental < Plato
	include Comparable

	attr_accessor :co2, :m2

	def get_co2
		co = 0
                iter = 0
                iterador2 = 0
                @listGramos_.each do |gramos|
                        gr = gramos
                        iter = iter + 1
                        @listAlimentos_.each do |element|
                                iterador2 = iterador2 + 1
                                if (iter == iterador2)
                                        co = co + gr*element.gas/100
                                end
                        end
                        iterador2 = 0
                end
		@co2 = co
                return co
	end

	def get_m2
		m = 0
                iter = 0
                iterador2 = 0
                @listGramos_.each do |gramos|
                        gr = gramos
                        iter = iter + 1
                        @listAlimentos_.each do |element|
                                iterador2 = iterador2 + 1
                                if (iter == iterador2)
                                        m = m + gr*element.te/100
                                end
                        end
                        iterador2 = 0
                end
                @m2 = m
                return m
	end

	def to_s
		texto = "CO2: "
		texto = texto + get_co2.to_s
		texto = texto + " M^2: "
		texto = texto + get_m2.to_s
                return texto
	end

	def indice_energia
		if (get_co2 < 800)
			return 1
		elsif (get_co2 < 1200)
			return 2
		else
			return 3
		end
	end
	def indice_huella
		if (get_VCT < 670)
			return 1
		elsif (get_VCT < 830)
			return 2
		else
			return 3
		end
	end

	def huella_nut
		return (indice_energia + indice_huella)/2
	end


	def <=>(other)
		#nombre_ <=> other.nombre_
		huella_nut <=> other.huella_nut
	end
end

