class Nave{
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
	method cargarCombustible(cantidad){
		combustible += cantidad
	} 
	
	method descargarCombustible(cantidad){
		combustible = 0.max(combustible - cantidad)
	}
	
	method velocidad() = velocidad
	
	method acelerar(cantidad){
		velocidad = 100000.min(velocidad + cantidad)
	}
	
	method desacelerar(cantidad){
		velocidad = 0.max(velocidad - cantidad)
	}
	
	method direccion() = direccion
	
	method irHaciaElSol(){
		direccion = 10
	}
	
	method escaparDelSol(){
		direccion = -10
	}
	
	method ponerseParalelaAlSol(){
		direccion = 0
	}
	
	method acercarseUnPocoAlSol(){
		direccion = 10.min(direccion + 1)
	}
	
	method alejarseUnPocoAlSol(){
		direccion = -10.max(direccion - 1)
	}
	
	method prepararViaje(){
		self.accionAdicionalEnPrepararViaje()
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	
	method accionAdicionalEnPrepararViaje()
	
	method estaTranquila() = combustible >= 4000 && velocidad < 12000
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	
	method escapar()
	
	method avisar()
	
	method relajo(){
		return self.estaTranquila() && self.pocaActividad()
	}
	
	method pocaActividad()
}

class NaveBaliza inherits Nave{
	var color
	var cambioColor = false
	
	method color() = color
	
	method cambiarColorDeBaliza(nuevoColor){
		color = nuevoColor
		cambioColor = true
	}
	
	override method accionAdicionalEnPrepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParalelaAlSol()
	}
	
	override method estaTranquila(){ 
		return super() && color != "rojo"
	}
	
	override method escapar(){
		self.irHaciaElSol()
	}
	
	override method avisar(){
		self.cambiarColorDeBaliza("rojo")
	}
	
	override method pocaActividad(){
		return not cambioColor
	}
}

class NaveDePasajeros inherits Nave{
	var pasajeros
	var comida
	var bebida
	var descargadas = 0
	
	method pasajeros() = pasajeros
	method comida() = comida
	method bebida() = bebida
	
	method cargarComida(unaComida){
		comida += unaComida
	}                      
	
	method descargarComida(unaComida){
		comida = 0.max(unaComida - 1)
		descargadas += unaComida
	}
	
	method cargarBebida(unaBebida){
		bebida += unaBebida
	}
	
	method descargarBebida(unaBebida){
		bebida = 0.max(unaBebida - 1)
	}
	
	override method accionAdicionalEnPrepararViaje(){
		self.cargarComida(pasajeros * 4)
		self.cargarBebida(pasajeros * 6)
		self.acercarseUnPocoAlSol()
	}
	override method escapar(){
		self.acelerar(velocidad)
	}
	
	override method avisar(){
		self.descargarComida(pasajeros)
		self.descargarBebida(2*pasajeros)
	}
	
	override method pocaActividad(){
		return descargadas < 50
	}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
}

class NaveHospital inherits NaveDePasajeros{
	var property quirofanosPreparados = false
	
	override method estaTranquila(){
		return super() && not quirofanosPreparados
	}
	
	override method recibirAmenaza(){
		super()
		quirofanosPreparados = true
	}
}

class NaveCombate inherits Nave{
	var visible = true
	var misilesDesplegados = true
	const mensajes = []
	
	method mensajes() = mensajes
	
	method ponerseVisible(){
		visible = true
	}
	
	method ponerseInvisible(){
		visible = false
	}
	
	method estaInvisible() = not visible
	
	method desplegarMisiles(){
		misilesDesplegados = true
	}
	
	method replegarMisiles(){
		misilesDesplegados = false
	}
	
	method misilesDesplegados() = misilesDesplegados
	
	method emitirMensaje(mensaje){
		mensajes.add(mensaje)
	}
	
	method mensajesEmitido(){
		return mensajes.size()
	}
	
	method primerMensajeEmitido(){
		if(mensajes.isEmpty()){
			self.error("No hay mensajes")
		}
		return mensajes.first()	
	}
	
	method ultimoMensajeEmitido(){
		if(mensajes.isEmpty()){
			self.error("No hay mensajes")
		}
		return mensajes.last()	
	}
	
	method esEscueta(){
		return mensajes.all({m => m.size() <= 30})
	}
	
	method esEscueta1(){
		return not mensajes.any({m => m.size() > 30})
	}
	
	method emitioMensaje(mensaje){
		return mensajes.contains(mensaje)
	}
	
	override method accionAdicionalEnPrepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
		self.acelerar(15000)
	}
	
	override method estaTranquila(){ 
		return super() && !misilesDesplegados 
	}
	
	override method escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	
	override method avisar(){
		self.emitirMensaje("Amenaza recibida")
	}
	
	override method pocaActividad(){
		return self.esEscueta()
	}
}

class NaveSigilosa inherits NaveCombate{
	
	override method estaTranquila(){
		return super() && visible
	}
	
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}

