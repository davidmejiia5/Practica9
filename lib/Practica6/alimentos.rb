
Node = Struct.new(:value, :next, :prev)

#Clase para definir los alimentos y sus valores nutricionales
class Alimento
	
	include Comparable
	attr_accessor :ali, :gas, :te, :pro, :carb, :lip
	
	#Constructor de la clase alimi¡ento
        def initialize(a,p,c,l,g,t)
                @ali = a
                @pro = p
                @carb = c
                @lip = l
                @gas = g
                @te = t
        end
	#Metodo para obtener el nombre del alimento
	def get_ali
                return @ali
        end
	#Método para obtener el co2
        def get_gas
                return @gas
        end
	#Método para obtener el terreno
        def get_te
                return @te
        end
	#Método para obtener el valor energético 
        def valor_energetico
                return (@pro+4)+(@carb+4)+(@lip+9)
        end
	#Sobrecarga del to_s
        def to_s
                "(#{@ali},#{@pro},#{@carb},#{@lip},#{@gas},#{@te})"
        end

	#Método para poder comparar
	def <=>(toCompare)
		@ali <=> toCompare.ali
	end

end

#Clase para representar alimentos en una lista
class Lista
	include Enumerable
	attr_accessor :size, :head, :tail, :n
	
	#Constructor de la clase Lista
	def initialize()
		@size = 0
		@head = Node.new(nil,nil,nil)
		@tail = Node.new(nil,nil,nil)
	end
	#Método push
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
	#Método pop por la cabecera
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
	#Método de extracción por la cola
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
	#Método iteración de la lista
	def each
		nodo = @head
		while (nodo != nil)
			yield nodo.value
			nodo = nodo.next
		end
	end
end

#Clase para poder representar un plato
class Plato
	attr_accessor :nombre_, :listAlimentos_
	#Constructor de la clase Plato
	def initialize(name)
		@nombre_ = name
		@listAlimentos_ = Lista.new
		@listGramos_ = Lista.new
	end
	#Método para insertar alimento en la lista
	def insert_alimento(alimento)
		@listAlimentos_.push(alimento)
	end
	#Método para insertar gramos en la lista
	def insert_gramos(gramos)
		@listGramos_.push(gramos)
	end
	#Método para devolver la lista de alimentos 
	def get_alimentos
		return @listAlimentos_
	end
	#Método para devolver la lista de gramos
	def get_gramos
		return @listGramos_
	end
	#Método para obtener el porcentaje de proteinas del plato 
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
	#Método para obtener el porcentaje de lípidos del plato
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
	#Método para obtener el porcentaje de carbohidratos del plato
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
	#Método para obtener el valor calórico total
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

	#Método to_s sobrecargado
	def to_s
		alimentos = "El plato esta formado por: " 
		@listAlimentos_.each do |element|
			alimentos = alimentos + element.ali
			alimentos = alimentos + " "
		end
		return alimentos
	end
end

#Clase Ambiental, hereda de Plato
class Ambiental < Plato
	include Comparable

	attr_accessor :co2, :m2
	#Método para obtener el c02 total del plato por gramos
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
	#Método para obtener la cantidad de terreno por gramos 
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
	#Sobrecarga del to_s
	def to_s
		texto = "CO2: "
		texto = texto + get_co2.to_s
		texto = texto + " M^2: "
		texto = texto + get_m2.to_s
                return texto
	end
	#Métdodo para clcular el índice de energía
	def indice_energia
		if (get_co2 < 800)
			return 1
		elsif (get_co2 < 1200)
			return 2
		else
			return 3
		end
	end
	#Método para calcular el indice de huella de carbono 
	def indice_huella
		if (get_VCT < 670)
			return 1
		elsif (get_VCT < 830)
			return 2
		else
			return 3
		end
	end
	#Método para calcular la huella nutricional
	def huella_nut
		return (indice_energia + indice_huella)/2
	end
	#Método para incrementar el vector de precios
	def incremento(v)
		v.collect {|x| x*huella_nut}
	end
	#Método para poder comparar
	def <=>(other)
		#nombre_ <=> other.nombre_
		huella_nut <=> other.huella_nut
	end
end

