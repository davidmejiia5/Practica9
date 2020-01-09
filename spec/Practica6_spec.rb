RSpec.describe Practica6 do
  
before (:all) do
                @carne_vaca = Alimento.new("carne_vaca",21.1,0.0,3.1,50.0,164.0)
                @carne_cordero = Alimento.new("carne_cordero",18.0,0.0,3.1,50.0,164.0)
                @camarones = Alimento.new("camarones",17.6,1.5,0.6,18.0,2.0)
		@chocolate = Alimento.new("chocolate",5.3,47.0,30.0,2.3,3.4)
                @salmon = Alimento.new("Salmon",19.9,0.0,13.6,6.0,3.7)
                @cerdo = Alimento.new("cerdo",21.5,0.0,6.3,7.6,11.0)
                @pollo = Alimento.new("pollo",20.6,0.0,5.6,5.7,7.1)
                @queso = Alimento.new("queso",25.0,1.3,33.0,11.0,41.0)
                @cerveza = Alimento.new("cerveza",0.5,3.6,0.0,0.25,0.22)
                @leche = Alimento.new("leche",3.3,4.8,3.2,3.2,8.9)
                @huevo = Alimento.new("huevos",13.0,1.1,11.0,4.2,5.7)
                @cafe = Alimento.new("cafe",0.1,0.0,0.0,0.4,0.3)
                @tofu = Alimento.new("tofu",8.0,1.9,4.8,2.0,2.2)
                @lentejas = Alimento.new("lentejas",23.5,52.0,1.4,0.4,3.4)
                @nuez = Alimento.new("nuez",20.0,21.0,54.0,0.3,7.9)

		@menu1 = 3*@lentejas.valor_energetico + 2*@chocolate.valor_energetico + 4*@pollo.valor_energetico
		@desayuno = 4*@queso.valor_energetico + 5*@leche.valor_energetico + 6*@cafe.valor_energetico
		@cena = 3*@carne_vaca.valor_energetico + 4*@salmon.valor_energetico + 5*@cerveza.valor_energetico
		
		@list1 = Lista.new()
		@list = Lista.new()
		@espa = Lista.new()
		@vasca = Lista.new()
		@vege = Lista.new()
		@vgel = Lista.new()
		@loka = Lista.new()

		@plato1 = Plato.new("random")
		@plato1.insert_alimento(@chocolate)
		@plato1.insert_gramos(200)
		@plato1.insert_alimento(@carne_vaca)
      		@plato1.insert_gramos(500)

		@ambiental1 = Ambiental.new("ambientalRandom")
		@ambiental1.insert_alimento(@chocolate)
		@ambiental1.insert_gramos(200)
		@ambiental1.insert_alimento(@carne_vaca)
		@ambiental1.insert_gramos(500)

	  	@ambiental2 = Ambiental.new("Salmonete")
		@ambiental2.insert_alimento(@salmon)
                @ambiental2.insert_gramos(225)
                @ambiental2.insert_alimento(@tofu)
                @ambiental2.insert_gramos(150)
		
		@v = Array.new
		@v.push(@ambiental1)
		@v.push(@ambiental2)

		@p = Array.new
		@p.push(9.95)
		@p.push(11.4)
		
		
		
	  @platoDSL2 = PlatoDSL.new("lentejas") do

		lentejas = Alimento.new("lentejas",23.5,52.0,1.4,0.4,3.4)
          	nuez = Alimento.new("nuez",20.0,21.0,54.0,0.3,7.9)

		ingredient lentejas
		quantity 200
		ingredient nuez
		quantity 500
	  end

	  @platoDSL1 = PlatoDSL.new("choco carne") do
                chocolat = Alimento.new("chocolate",5.3,47.0,30.0,2.3,3.4)
                carne_papas = Alimento.new("carne_papas",21.1,0.0,3.1,50.0,164.0)
                ingredient chocolat
                quantity 200
                ingredient carne_papas
                quantity 500
          end

	@menuNew = Menu.new("Combinado 1º") do

		platoDSL1 = PlatoDSL.new("choco carne") do
                	chocolat = Alimento.new("chocolate",5.3,47.0,30.0,2.3,3.4)
                	carne_papas = Alimento.new("carne_papas",21.1,0.0,3.1,50.0,164.0)
                	ingredient chocolat
                	quantity 200
                	ingredient carne_papas
                	quantity 500
          	end

		platoDSL2 = PlatoDSL.new("lentejas") do
	                lentejas = Alimento.new("lentejas",23.5,52.0,1.4,0.4,3.4)
	                nuez = Alimento.new("nuez",20.0,21.0,54.0,0.3,7.9)
	                ingredient lentejas
	                quantity 200
	                ingredient nuez
                	quantity 500
	        end


                component platoDSL1
                price 5.50

                component platoDSL2
                price 4.70
          end
	  end


	context "Que el DSL" do
		it "Funcione con los platos" do
			expect(@platoDSL1.name_).to eq("choco carne")
			expect(@platoDSL1.get_VCT).to eq(10639.3)
		end

		it "Funcione con los menus" do
			expect(@menuNew.name_).to eq("Combinado 1º")
			expect(@menuNew.to_s).to eq("Combinado 1º = 10.2€ Contiene: choco carne = 5.5€ lentejas = 4.7€ " )
		end
  	end

        context "Debe existir" do
                it "Un nombre para cada alimento" do
                        expect(@carne_vaca.ali).to eq("carne_vaca")
                        expect(@camarones.ali).to eq("camarones")
                        expect(@cafe.ali).to eq("cafe")
                end

                it "La cantidad de gases de efecto invernadero" do
                        expect(@salmon.gas).to eq(6.0)
                        expect(@queso.gas).to eq(11.0)
                        expect(@tofu.gas).to eq(2.0)
                end

                it "La cantidad de terreno utilizado" do
                        expect(@salmon.te).to eq(3.7)
                        expect(@queso.te).to eq(41.0)
                        expect(@tofu.te).to eq(2.2)
                end

        end

	 context "Existe un metodo para obtener" do
                it "El nombre del alimento" do
                        expect(@huevo.get_ali).to eq("huevos")
                        expect(@nuez.get_ali).to eq("nuez")
		end

                it "Emision de gases de efecto invernadero" do
                        expect(@leche.get_gas).to eq(3.2)
                        expect(@cerveza.get_gas).to eq(0.25)
                end

                it "La cantidad de terreno utilizado" do
                        expect(@salmon.get_te).to eq(3.7)
                        expect(@queso.get_te).to eq(41.0)
                        expect(@tofu.get_te).to eq(2.2)
                end

                it "El alimento formateado" do
                        expect(@queso.to_s).to  eq('(queso,25.0,1.3,33.0,11.0,41.0)')
			expect(@huevo.to_s).to eq('(huevos,13.0,1.1,11.0,4.2,5.7)')
		end
	end
	
	context "Valor energetico" do 
		it "Es el siguiente" do
			expect(@nuez.valor_energetico).to eq(112)
		end
	end	
	
	context "Se calcula correctamente el impacto ambiental diario de" do
		it "Un hombre de 20-39 años" do 
			expect(@desayuno + @menu1 + @cena).to eq(1633.5)
		end
		it "Una mujer de 20-39 años" do
			expect(@desayuno + @menu1 + @cena).to eq(1633.5)
		end
	end	
	
	context "Debe existir" do
		it "Un nodo de la lista con sus datos, su siguiente y su previo" do
			@list1.push(@cafe)
			expect((@list1.head).value).to eq(@cafe)
			expect((@list1.head).next).to eq nil
			expect((@list1.head).prev).to eq nil
		end

		it "Una Lista con su cabeza y su cola" do 
			@list.push(@cafe)
			expect((@list.head).value).to eq(@cafe)
			expect((@list.tail).value).to eq(@cafe)
		end
	end

	context "Se puede insertar" do 
		it "Un elemento en la lista" do	
			expect(@list.size).to eq(1)
			@list.push(@nuez)
			expect(@list.size).to eq(2)
		end
		it "Varios elementos en la lista" do 
			@list.push(@leche)
			@list.push(@cerdo)
			@list.push(@pollo)
			expect(@list.size).to eq(5)
		end
	end
	context "Se extrae el" do
		it " primer elemento de la lista" do 
			expect(@list.size).to eq(5)
			@drop = @list.pop_head()
			expect(@list.size).to eq(4)
			expect(@drop).to eq(@pollo)
		end
		it " el ultimo elemento de la lista" do
			expect(@list.size).to eq(4)
			@drop = @list.pop_tail()
			expect(@list.size).to eq(3)
			expect(@drop).to eq(@cafe)
		end
	end


	context "Que funcionen las listas" do
		it "Sea enumerable" do
			expect(@list1.count).to eq(1)
	end
		it "Tamaño" do
			expect(@list1.size).to eq(1)
		end
	end

	context "Que funcionen los platos" do
		it "Tenga nombre" do
			expect(@plato1.nombre_).to eq("random")
	  	end

	  	it "Exista conjunto de alimentos" do
			expect(@plato1.get_alimentos.size).to eq(2)
	 	end

		it "Exista conjunto de gramos" do
			expect(@plato1.get_gramos.size).to eq(2)
	 	end

		it "Porcentaje de proteinas" do
			expect(@plato1.get_proteinas).to eq(116.1)
		end

		it "Porcentaje de lipidos" do
			expect(@plato1.get_lipidos).to eq(75.5)
	  	end	

		it "Porcentaje de carbohidratos" do
			expect(@plato1.get_carbohidratos).to eq(94.0)
		end
		it "VCT" do
			expect(@plato1.get_VCT).to eq(10639.3)
	  	end

		it "Plato formateado" do
			expect(@plato1.to_s).to eq ("El plato esta formado por: carne_vaca chocolate ")
		end
	end

	context "Que funcione la herencia" do
		it "CO2" do
			expect(@ambiental1.get_co2).to eq(254.6)
		end

		it "m2" do
			expect(@ambiental1.get_m2).to eq(826.8)
		end

		it "Eficiencia energetica formateada" do
			expect(@ambiental1.to_s).to eq("CO2: 254.6 M^2: 826.8")
		end

		it "Comprobar Clase, Objeto y Jerarquía" do
			expect(@ambiental1.class.to_s).to eq("Ambiental")
			expect(@ambiental1.instance_of? Ambiental).to eq(true)
		end

		it "Que sea comparable" do
			expect(@ambiental1 <=> @ambiental2).to eq(0)
		end
	end

	context "Que funcionen los indices" do 
		it "Indice de impacto energia" do
			expect(@ambiental1.indice_energia).to eq(1)
		end
		it "Indice de impacto huella de carbono"do
			expect(@ambiental1.indice_huella).to eq(3)
		end
		it "Huella nutricional"do
			expect(@ambiental1.huella_nut).to eq(2)
		end
	end
	context "Comprobando array de platos" do
		it "Mayor numero de huella nutricional" do
			expect(@v.max).to eq(@ambiental1)
		end
		it "Incremento vector" do
			expect(@v.max.incremento(@p)).to eq([19.9,22.8])
		end

	end
end
