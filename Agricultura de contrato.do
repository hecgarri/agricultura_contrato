/***********************************************************************/
/* Agricultura de contrato */
/* Autores: Juan Cabas, Héctor Garrido &  José María Gil*/
/* Archivo para reproducir resultados */
/* Bases de datos necesarias: baseChoice.csv */
 /***********************************************************************/

clear all 
set more off /*Esta orden le indica que no se detenga hasta ejecutar el programa completo, esto es útil en programas
en los que el tiempo de la estimación es relativamente largo, como en este caso*/
insheet using "Z:\home\hector\Research\Own Papers\Artículo - Agricultura de Contrato\baseChoice.csv"


/*************************************************************************************/
/* Varias especificaciones para el modelo logit*/
/*************************************************************************************/
*MODELO 1
clogit choice nooption f11 f12 f21 f22 f31 f32 f41 f42, group(id)
/*En este caso estimar la WTP es sencillo, pues es sólo el ratio entre el coeficiente asociado al precio y el coeficiente 
de los demás atributos. Para ello se puede utilizar la orden wtp y comparar los resultados obtenidos por dos diferentes métodos*/
/*Método Delta*/ 
wtp precio2 espana italia plastico metalico x500 x1000
/*Método Krinsky and Robb*/
wtp precio2 espana italia plastico metalico x500 x1000, krinsky reps(1000)
*MODELO 2
mixlogit choice nop precio2 if id!=10, rand(espana italia metalico plastico x500 x1000) id(id) group(exp) nrep(1000) 
#delimit;  /*Esta orden es para generar las tablas para el editor de texto*/
outreg using choice,  squarebrack replace addtable
varlabels title(Modelo 2); 
#delimit cr
/*En este caso estimar la WTP es sencillo, pues es sólo el ratio entre el coeficiente asociado al precio y el coeficiente 
de los demás atributos. Para ello se puede utilizar la orden wtp y comparar los resultados obtenidos por dos diferentes métodos*/
/*Método Delta*/ 
wtp precio2 espana italia plastico metalico x500 x1000
/*Método Krinsky and Robb*/
wtp precio2 espana italia plastico metalico x500 x1000, krinsky reps(1000)

*MODELO 3
mixlogit choice nop if id!=10, rand(espana italia metalico plastico x500 x1000 precio2) id(id) group(exp) nrep(1000) ln(1)
#delimit;  /*Esta orden es para generar las tablas para el editor de texto*/
outreg using choice,  squarebrack replace addtable
varlabels title(Modelo 3); 
#delimit cr
/*A continuación se generan las medias y desviaciones estándar del modelo, no del logaritmo de sus coeficientes. 
El comando utilizado tiene la ventaja de que permite, convenientemente, recuperar el error estándar de las combinaciones
no lineales utilizadas*/
#delimit; 
nlcom 	(mean_precio2: exp([Mean]_b[precio2]+0.5*[SD]_b[precio2]^2))
		(med_precio2: exp([Mean]_b[precio2]))
		(sd_precio2: exp([Mean]_b[precio2]+0.5*[SD]_b[precio2]^2)*sqrt(exp([SD]_b[precio2]^2)-1))
		(mean_espana: exp([Mean]_b[espana]+0.5*[SD]_b[espana]^2))
		(med_espana: exp([Mean]_b[espana]))
		(sd_espana: exp([Mean]_b[espana]+0.5*[SD]_b[espana]^2)*sqrt(exp([SD]_b[espana]^2)-1))
		(mean_italia: exp([Mean]_b[italia]+0.5*[SD]_b[italia]^2))
		(med_italia: exp([Mean]_b[italia]))
		(sd_italia: exp([Mean]_b[italia]+0.5*[SD]_b[italia]^2)*sqrt(exp([SD]_b[italia]^2)-1))
		(mean_plastico: exp([Mean]_b[plastico]+0.5*[SD]_b[plastico]^2))
		(med_plastico: exp([Mean]_b[plastico]))
		(sd_plastico: exp([Mean]_b[plastico]+0.5*[SD]_b[plastico]^2)*sqrt(exp([SD]_b[plastico]^2)-1))
		(mean_metalico: exp([Mean]_b[metalico]+0.5*[SD]_b[metalico]^2))
		(med_metalico: exp([Mean]_b[metalico]))
		(sd_metalico: exp([Mean]_b[metalico]+0.5*[SD]_b[metalico]^2)*sqrt(exp([SD]_b[metalico]^2)-1))
		(mean_x500: exp([Mean]_b[x500]+0.5*[SD]_b[x500]^2))
		(med_x500: exp([Mean]_b[x500]))
		(sd_x500: exp([Mean]_b[x500]+0.5*[SD]_b[x500]^2)*sqrt(exp([SD]_b[x500]^2)-1))
		(mean_x1000: exp([Mean]_b[x1000]+0.5*[SD]_b[x1000]^2))
		(med_x1000: exp([Mean]_b[x1000]))
		(sd_x1000: exp([Mean]_b[x1000]+0.5*[SD]_b[x1000]^2)*sqrt(exp([SD]_b[x1000]^2)-1))
	  ; 
#delimit cr 
/*Para estimar la distribución de la wtp se utiliza el siguiente método, el cual consiste en utilizar la media estimada de 
cada coeficiente y dividirla entre la media del coeficiente del precio. */
#delimit; 
nlcom 	(wtp_espana: (exp([Mean]_b[espana]+0.5*[SD]_b[espana]^2))/(exp([Mean]_b[precio2]+0.5*[SD]_b[precio2]^2)))
		(wtp_italia: (exp([Mean]_b[italia]+0.5*[SD]_b[italia]^2))/(exp([Mean]_b[precio2]+0.5*[SD]_b[precio2]^2)))
		(wtp_plastico: (exp([Mean]_b[plastico]+0.5*[SD]_b[plastico]^2))/(exp([Mean]_b[precio2]+0.5*[SD]_b[precio2]^2)))
		(wtp_metalico: (exp([Mean]_b[metalico]+0.5*[SD]_b[metalico]^2))/(exp([Mean]_b[precio2]+0.5*[SD]_b[precio2]^2)))
		(wtp_x500: (exp([Mean]_b[x500]+0.5*[SD]_b[x500]^2))/(exp([Mean]_b[precio2]+0.5*[SD]_b[precio2]^2)))
		(wtp_x1000: (exp([Mean]_b[x1000]+0.5*[SD]_b[x1000]^2))/(exp([Mean]_b[precio2]+0.5*[SD]_b[precio2]^2)))
; 
#delimit cr 

*MODELO 4	   
mixlogit choice nop precio2  if id!=10, rand(espana italia metalico plastico x500 x1000) id(id) group(exp) nrep(1000) ln(1)
#delimit;  /*Esta orden es para generar las tablas para el editor de texto*/
outreg using choice,  squarebrack replace addtable
varlabels title(Modelo 4); 
#delimit cr
#delimit; 
nlcom (mean_espana: exp([Mean]_b[espana]+0.5*[SD]_b[espana]^2))
	  (med_espana: exp([Mean]_b[espana]))
	  (sd_espana: exp([Mean]_b[espana]+0.5*[SD]_b[espana]^2)*sqrt(exp([SD]_b[espana]^2)-1))
	  (mean_italia: exp([Mean]_b[italia]+0.5*[SD]_b[italia]^2))
	  (med_italia: exp([Mean]_b[italia]))
	  (sd_italia: exp([Mean]_b[italia]+0.5*[SD]_b[italia]^2)*sqrt(exp([SD]_b[italia]^2)-1))
	  (mean_plastico: exp([Mean]_b[plastico]+0.5*[SD]_b[plastico]^2))
	  (med_plastico: exp([Mean]_b[plastico]))
	  (sd_plastico: exp([Mean]_b[plastico]+0.5*[SD]_b[plastico]^2)*sqrt(exp([SD]_b[plastico]^2)-1))
	  (mean_metalico: exp([Mean]_b[metalico]+0.5*[SD]_b[metalico]^2))
	  (med_metalico: exp([Mean]_b[metalico]))
	  (sd_metalico: exp([Mean]_b[metalico]+0.5*[SD]_b[metalico]^2)*sqrt(exp([SD]_b[metalico]^2)-1))
	  (mean_x500: exp([Mean]_b[x500]+0.5*[SD]_b[x500]^2))
	  (med_x500: exp([Mean]_b[x500]))
	  (sd_x500: exp([Mean]_b[x500]+0.5*[SD]_b[x500]^2)*sqrt(exp([SD]_b[x500]^2)-1))
	  (mean_x1000: exp([Mean]_b[x1000]+0.5*[SD]_b[x1000]^2))
	  (med_x1000: exp([Mean]_b[x1000]))
	  (sd_x1000: exp([Mean]_b[x1000]+0.5*[SD]_b[x1000]^2)*sqrt(exp([SD]_b[x1000]^2)-1))
	  ; 
#delimit cr 
/*Para estimar la distribución de la wtp se utiliza el siguiente método, el cual consiste en utilizar la media estimada de 
cada coeficiente y dividirla entre la media del coeficiente del precio. */
#delimit; 
nlcom 	(wtp_espana: (exp([Mean]_b[espana]+0.5*[SD]_b[espana]^2))/([Mean]_b[precio2]))
		(wtp_italia: (exp([Mean]_b[italia]+0.5*[SD]_b[italia]^2))/([Mean]_b[precio2]))
		(wtp_plastico: (exp([Mean]_b[plastico]+0.5*[SD]_b[plastico]^2))/([Mean]_b[precio2]))
		(wtp_metalico: (exp([Mean]_b[metalico]+0.5*[SD]_b[metalico]^2))/([Mean]_b[precio2]))
		(wtp_x500: (exp([Mean]_b[x500]+0.5*[SD]_b[x500]^2))/([Mean]_b[precio2]))
		(wtp_x1000: (exp([Mean]_b[x1000]+0.5*[SD]_b[x1000]^2))/([Mean]_b[precio2]))
; 
#delimit cr 

*MODELO 5
clogit choice nop espana italia plastico metalico x500 x1000 precio2 preciosq if id!=10, group(exp)
#delimit;  /*Esta orden es para generar las tablas para el editor de texto*/
outreg using choice,  squarebrack replace addtable
varlabels title(Modelo 5); 
#delimit cr
/*Disponibilidad a pagar cuadrática*/
/*Este apartado es un poco largo, pero simple en definitiva, es un poco tedioso debido a la no linealidad del precio, 
por lo que es necesario calcular la disponibilidad a pagar en función de cada nivel de precios a diferencia de los modelos anteriores.
Es necesario notar además un problema inherente a la forma cuadrática del precio. Para algunos valores el discriminantes resulta negativo, 
por lo que no es posible determinar la disponibilidad a pagar para ciertos precios. 

Precio	Freq.	Percent	Cum.
			
0		1,404	25.00	25.00
1.9		780	13.89	38.89
2.5		624	11.11	50.00
3		624	11.11	61.11
4.1		624	11.11	72.22
5.1		780	13.89	86.11
6.1		780	13.89	100.00
			
Total	5,616	100.00
*/
#delimit; 
nlcom 	(wtp_espana: (-([choice]precio2+2*1.9*[choice]preciosq)+sqrt(([choice]precio2+2*1.9*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]espana))/2*[choice]preciosq)
		(wtp_espana4: (-([choice]precio2+2*5.1*[choice]preciosq)+sqrt(([choice]precio2+2*5.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]espana))/2*[choice]preciosq)
		(wtp_espana5: (-([choice]precio2+2*6.1*[choice]preciosq)+sqrt(([choice]precio2+2*6.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]espana))/2*[choice]preciosq)
		(wtp_italia: (-([choice]precio2+2*1.9*[choice]preciosq)+sqrt(([choice]precio2+2*1.9*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]italia))/2*[choice]preciosq)
		(wtp_italia5: (-([choice]precio2+2*6.1*[choice]preciosq)+sqrt(([choice]precio2+2*6.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]italia))/2*[choice]preciosq)
		(wtp_plastico5: (-([choice]precio2+2*6.1*[choice]preciosq)+sqrt(([choice]precio2+2*6.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]plastico))/2*[choice]preciosq)
		(wtp_x500: (-([choice]precio2+2*1.9*[choice]preciosq)+sqrt(([choice]precio2+2*1.9*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x500))/2*[choice]preciosq)
		(wtp_x5001: (-([choice]precio2+2*2.5*[choice]preciosq)+sqrt(([choice]precio2+2*2.5*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x500))/2*[choice]preciosq)
		(wtp_x5002: (-([choice]precio2+2*3*[choice]preciosq)+sqrt(([choice]precio2+2*3*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x500))/2*[choice]preciosq)
		(wtp_x5003: (-([choice]precio2+2*4.1*[choice]preciosq)+sqrt(([choice]precio2+2*4.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x500))/2*[choice]preciosq)
		(wtp_x5004: (-([choice]precio2+2*5.1*[choice]preciosq)+sqrt(([choice]precio2+2*5.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x500))/2*[choice]preciosq)
		(wtp_x5005: (-([choice]precio2+2*6.1*[choice]preciosq)+sqrt(([choice]precio2+2*6.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x500))/2*[choice]preciosq)
		(wtp_x1000: (-([choice]precio2+2*1.9*[choice]preciosq)+sqrt(([choice]precio2+2*1.9*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x1000))/2*[choice]preciosq)
		(wtp_x10001: (-([choice]precio2+2*2.5*[choice]preciosq)+sqrt(([choice]precio2+2*2.5*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x1000))/2*[choice]preciosq)
		(wtp_x10002: (-([choice]precio2+2*3*[choice]preciosq)+sqrt(([choice]precio2+2*3*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x1000))/2*[choice]preciosq)
		(wtp_x10003: (-([choice]precio2+2*4.1*[choice]preciosq)+sqrt(([choice]precio2+2*4.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x1000))/2*[choice]preciosq)
		(wtp_x10004: (-([choice]precio2+2*5.1*[choice]preciosq)+sqrt(([choice]precio2+2*5.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x1000))/2*[choice]preciosq)
		(wtp_x10005: (-([choice]precio2+2*6.1*[choice]preciosq)+sqrt(([choice]precio2+2*6.1*[choice]preciosq)^(2)-4*[choice]preciosq*[choice]x1000))/2*[choice]preciosq)

		;
#delimit cr
*MODELO 6
mixlogit choice nop precio2 preciosq if id!=10, rand(espana italia metalico plastico x500 x1000) id(id) group(exp) nrep(1000)
#delimit;  /*Esta orden es para generar las tablas para el editor de texto*/
outreg using choice, squarebrack replace addtable
varlabels title(Modelo 6); 
#delimit cr
#delimit; 
nlcom (wtp_espana: (-([Mean]precio2+2*1.9*[Mean]preciosq)+sqrt(([Mean]precio2+2*1.9*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]espana))/2*[Mean]preciosq)
  (wtp_espana4: (-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]espana))/2*[Mean]preciosq)
  (wtp_espana5: (-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]espana))/2*[Mean]preciosq)
  (wtp_italia: (-([Mean]precio2+2*1.9*[Mean]preciosq)+sqrt(([Mean]precio2+2*1.9*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]italia))/2*[Mean]preciosq)
  (wtp_italia4: (-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]italia))/2*[Mean]preciosq)
  (wtp_italia5: (-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]italia))/2*[Mean]preciosq)
  (wtp_plastico5: (-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]plastico))/2*[Mean]preciosq)
  (wtp_x500: (-([Mean]precio2+2*1.9*[Mean]preciosq)+sqrt(([Mean]precio2+2*1.9*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
  (wtp_x5001: (-([Mean]precio2+2*2.5*[Mean]preciosq)+sqrt(([Mean]precio2+2*2.5*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
  (wtp_x5002: (-([Mean]precio2+2*3*[Mean]preciosq)+sqrt(([Mean]precio2+2*3*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
  (wtp_x5003: (-([Mean]precio2+2*4.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*4.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
  (wtp_x5004: (-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
  (wtp_x5005: (-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
  (wtp_x1000: (-([Mean]precio2+2*1.9*[Mean]preciosq)+sqrt(([Mean]precio2+2*1.9*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
  (wtp_x10001: (-([Mean]precio2+2*2.5*[Mean]preciosq)+sqrt(([Mean]precio2+2*2.5*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
  (wtp_x10002: (-([Mean]precio2+2*3*[Mean]preciosq)+sqrt(([Mean]precio2+2*3*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
  (wtp_x10003: (-([Mean]precio2+2*4.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*4.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
  (wtp_x10004: (-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
  (wtp_x10005: (-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
; 
#delimit cr 

/*Estimación Bootstrap*/
#delimit; 
bootstrap ((-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]espana))/2*[Mean]preciosq) 
,reps(1000): mixlogit choice nop precio2 preciosq if id!=10, rand(espana italia metalico plastico x500 x1000) id(id) group(exp) nrep(1000)
; 
#delimit cr 

((-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]espana))/2*[Mean]preciosq) 
((-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]espana))/2*[Mean]preciosq)
((-([Mean]precio2+2*1.9*[Mean]preciosq)+sqrt(([Mean]precio2+2*1.9*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]italia))/2*[Mean]preciosq)
((-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]italia))/2*[Mean]preciosq)
((-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]italia))/2*[Mean]preciosq)
((-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]plastico))/2*[Mean]preciosq)
((-([Mean]precio2+2*1.9*[Mean]preciosq)+sqrt(([Mean]precio2+2*1.9*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
((-([Mean]precio2+2*2.5*[Mean]preciosq)+sqrt(([Mean]precio2+2*2.5*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
((-([Mean]precio2+2*3*[Mean]preciosq)+sqrt(([Mean]precio2+2*3*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
((-([Mean]precio2+2*4.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*4.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
((-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
((-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x500))/2*[Mean]preciosq)
((-([Mean]precio2+2*1.9*[Mean]preciosq)+sqrt(([Mean]precio2+2*1.9*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
((-([Mean]precio2+2*2.5*[Mean]preciosq)+sqrt(([Mean]precio2+2*2.5*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
((-([Mean]precio2+2*3*[Mean]preciosq)+sqrt(([Mean]precio2+2*3*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
((-([Mean]precio2+2*4.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*4.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
((-([Mean]precio2+2*5.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*5.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)
((-([Mean]precio2+2*6.1*[Mean]preciosq)+sqrt(([Mean]precio2+2*6.1*[Mean]preciosq)^(2)-4*[Mean]preciosq*[Mean]x1000))/2*[Mean]preciosq)

*----------------------------------------------------------------*
/* base Figuras 3 y 4 */
*----------------------------------------------------------------*
#delimit; 
graph bar (asis) var4, over(price, label(labsize(vsmall))) over(attribute)
 ytitle(Miles de pesos chilenos) title(Willingness to pay de acuerdo a atributos y precios)
 subtitle(Categoría base: Aceite de Oliva chileno de 250 ml y envase de vidrio) scheme(s1mono)
; 
#delimit cr 
