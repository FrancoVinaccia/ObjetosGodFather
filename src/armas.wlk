
class Arma {
}

class Revolver {
    var balas
    method esSutil() = balas == 1
    method usar(victima) {
        if (self.quedanBalas()){
        balas -= 1
        victima.morir()}
    }
    method quedanBalas() = balas > 0
}

class Escopeta {
    method esSutil() = false
    method usar(victima) {
        if (victima.estaHerido()){victima.morir()}
        else {victima.herirse()}
    }
}

class CuerdaDePiano {
    const esDeBuenaCalidad
    method esSutil() = true
    method usar(victima) {if (esDeBuenaCalidad){victima.morir()}}
}