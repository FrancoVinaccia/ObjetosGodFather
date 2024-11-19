import armas.*
import rangos.*

class Familia{
    const integrantes = []
    var don

    method masMafioso() = integrantes.max({i => i.cantArmas()})
    method distribuirArmas() = integrantes.forEach{ i => i.agregarArma(new Revolver(balas = 6))}
    method ataqueSorpresaA(otraFamilia) {
        if (otraFamilia.estaVivoElMasMafioso()) {
            self.integrantesVivos().forEach{ i => i.atacar(otraFamilia.masMafioso())}
        }
    }
    method estaVivoElMasMafioso() = not self.masMafioso().estaDurmiendoConLosPeces()
    method integrantesVivos() = integrantes.filter{ i => not i.estaDurmiendoConLosPeces()}
    method muerteDon(){
        self.futurosSubjefes().forEach{s => s.cambiarRango(Subjefe)} //new???????
        self.elegirNuevoDon()
        self.aumentarLealtadFamiliar()
    }
    method futurosSubjefes() = integrantes.filter{ i => i.rango() == Soldado and i.cantArmas() > 5}
    method elegirNuevoDon() = don.subordinadoMasLeal().cambiarRango(Don) //new???????
    method aumentarLealtadFamiliar() = integrantes.forEach{ i => i.aumentarLealtadPorMuerte()}
    method lealtadPromedio() = integrantes.sum({i => i.lealtad()}) / integrantes.size()
}

class Familiar{
    var familia
    var estaVivo = true
    var property estaHerido = false
    var armas = []
    var property rango
    var property lealtad

    method estaDurmiendoConLosPeces() = not estaVivo
    method cantArmas() = armas.size()
    method agregarArma(arma) = armas.add(arma)
    method tieneArmaSutil() = armas.any{ a => a.esSutil()}
    method atacar(persona) = rango.atacar(self,persona)
    method armaCualquiera() = armas.anyOne()
    method armaMasAMano() = armas.first()
    method cambiarRango(nuevoRango) {rango = nuevoRango}
    method aumentarLealtadPorMuerte() {lealtad *= 1.1}
    method morir() {estaVivo = false}
    method herirse() {estaHerido = true}

    method determinarVictimaDeFamilia() = familia.integrantesVivos().anyOne()
    method nuevaLealtad(nuevaLealtad) {lealtad = nuevaLealtad}
    method nuevaFamilia(nuevaFamilia) {familia = nuevaFamilia}
    method atacaVictimas(victimas) {victimas.forEach{ v => self.atacar(v)}}
}

class Traicion{
    const traidor
    const victimas
    var fecha 

    method iniciarTraicion() {
        victimas.add(traidor.determinarVictima())
    }
    method seComplica() {
        self.adelantarFecha() 
        traidor.determinarVictima()
    } 
    method adelantarFecha() {fecha -= 1}
    method concretarTraicion(nuevaFamilia) {
        if(self.esPosibleConcretar()){
            traidor.atacarVictimas(victimas)
            traidor.cambiarFamilia(nuevaFamilia)
            traidor.cambiarRango(Soldado)
            traidor.nuevaLealtad(100)
        }
        else {self.ajusticiarTraidor()}
    }
    method ajusticiarTraidor() {traidor.morir()}
    method esPosibleConcretar() = traidor.familia().lealtadPromedio() > traidor.lealtad()*2
}   