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
		
		@n1 = Node.new(@chocolate,nil,nil)
		@n2 = Node.new(@tofu,nil,nil)
		@n3 = Node.new(@nuez,@n1,@n2)
		@n4 = Node.new(@pollo,@n3,@n1)
		@n5 = Node.new(@queso,@n4,@n3)
		
		@list = Lista.new()
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
			expect(@n1.value).to eq(@chocolate)
			expect(@n1.next).to eq nil
			expect(@n1.prev).to eq nil
			
			expect(@n2.value).to eq(@tofu)
			expect(@n2.next).to eq nil
			expect(@n2.prev).to eq nil

			expect(@n3.value).to eq(@nuez)
                        expect(@n3.next).to eq(@n1)
                        expect(@n3.prev).to eq(@n2)

			expect(@n5.value).to eq(@queso)
                        expect(@n5.next).to eq(@n4)
                        expect(@n5.prev).to eq(@n3)
		end

		it "Una Lista con su cabeza y su cola" do 
			expect(@list.head).to eq nil
			expect(@list.tail).to eq nil
		end
	end

	context "Se puede insertar" do 
		it "Un elemento en la lista" do	
			expect(@list.size).to eq(0)
			@list.push(@n1)
			expect(@list.size).to eq(1)
		end
	end


end
