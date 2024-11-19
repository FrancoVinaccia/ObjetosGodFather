import familia.*

class Don{
    const subordinados
    method sabeDespacharElegantemente() = true
    method atacar(atacante,victima) = subordinados.anyOne().atacar(victima)
    method subordinadoMasLeal() = subordinados.max({s => s.lealtad()})
} 

class Subjefe{
    const subordinados
    method sabeDespacharElegantemente() = subordinados.any{ s => s.tieneArmaSutil()}
    method atacar(atacante,victima) = atacante.armaCualquiera().usar(victima)
}

class Soldado{
    method sabeDespacharElegantemente(unaPersona) = unaPersona.tieneArmaSutil()
    method atacar(atacante,victima) = atacante.armaMasAMano().usar(victima)
}