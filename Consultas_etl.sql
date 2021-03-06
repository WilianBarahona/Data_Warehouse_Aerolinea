----------------------------------------------------------------------
------------Grupo #2 Consultas etl para el data mart------------------
----------------------------------------------------------------------

--###############consultas de las tablas de dimensiones#############

--Consulta para llenar la Tabla DIM_VUELOS
SELECT  Z.IDVUELO, 
		CONCAT(P.PNOMBRE,' ', P.SNOMBRE,' ',P.PAPELLIDO,' ',P.SAPELLIDO) AS PILOTO,
		CONCAT(CC.PNOMBRE,' ',CC.SNOMBRE,' ',CC.PAPELLIDO,' ',CC.SAPELLIDO) AS COPILOTO,
		CD.NOMBRECIUDAD AS CIUDAD_ORIGEN,
		CC.NOMBRECIUDAD AS CIUDAD_DESTINO,
		AV.REGISTRO AS REGISTRO_AVION
FROM (
	SELECT  V.IDVUELO,P.PNOMBRE,P.SNOMBRE,P.PAPELLIDO,P.SAPELLIDO,CD.NOMBRECIUDAD
	FROM VUELO V
	INNER JOIN TRIPULANTEXVUELO TXV ON V.IDVUELO=TXV.VUELO_IDVUELO
	INNER JOIN TRIPULANTE T ON TXV.TRIPULANTE_IDTRIPULANTE=T.IDTRIPULANTE
	INNER JOIN EMPLEADO E ON T.EMPLEADO_IDEMPLEADO=E.IDEMPLEADO
	INNER JOIN PERSONA P ON E.PERSONA_IDPERSONA=P.IDPERSONA
	INNER JOIN EMPLEADOXCARGO EXC ON E.IDEMPLEADO=EXC.EMPLEADO_IDEMPLEADO
	INNER JOIN CARGO C ON EXC.CARGO_IDCARGO=C.IDCARGO
	INNER JOIN RUTA R ON V.RUTA_IDRUTA=R.IDRUTA
	INNER JOIN CIUDAD CD ON CD.IDCIUDAD=R.CIUDAD_IDCIUDADDESTINO
	WHERE C.IDCARGO=2
) CC, VUELO Z
INNER JOIN TRIPULANTEXVUELO TXV ON Z.IDVUELO=TXV.VUELO_IDVUELO
INNER JOIN TRIPULANTE T ON TXV.TRIPULANTE_IDTRIPULANTE=T.IDTRIPULANTE
INNER JOIN EMPLEADO E ON T.EMPLEADO_IDEMPLEADO=E.IDEMPLEADO
INNER JOIN PERSONA P ON E.PERSONA_IDPERSONA=P.IDPERSONA
INNER JOIN EMPLEADOXCARGO EXC ON E.IDEMPLEADO=EXC.EMPLEADO_IDEMPLEADO
INNER JOIN CARGO C ON EXC.CARGO_IDCARGO=C.IDCARGO
INNER JOIN RUTA R ON Z.RUTA_IDRUTA=R.IDRUTA
INNER JOIN CIUDAD CD ON CD.IDCIUDAD=R.CIUDAD_IDCIUDADORIGEN
INNER JOIN AVION AV ON Z.AVION_IDAVION=AV.IDAVION
WHERE C.IDCARGO=1 AND CC.IDVUELO=Z.IDVUELO

--consulta para llenar la Tabla DIM_PASAJEROS
SELECT PJ.IDPASAJERO, PJ.NUMEROPASAPORTE,
CONCAT(P.PNOMBRE,' ',P.SNOMBRE,' ',P.PAPELLIDO,' ',P.SAPELLIDO) AS PASAJERO
FROM PASAJERO PJ
INNER JOIN PERSONA P ON PJ.PERSONA_IDPERSONA=P.IDPERSONA

--consulta para llenar la Tabla DIM_TIEMPO
SELECT DATEPART(YEAR,V.FECHAHORAPARTIDA) ANIO,
       DATEPART(MONTH,V.FECHAHORAPARTIDA) AS MES,
	   DATEPART(WEEK,V.FECHAHORAPARTIDA) AS SEMANA,
	   DATENAME(WEEKDAY,V.FECHAHORAPARTIDA) AS DIA,
	   DATEPART(QUARTER, V.FECHAHORAPARTIDA) AS TRIMESTRE,
	   V.IDVUELO AS ID_TIEMPO
FROM VUELO V;

--consulta de la tabla de HECHOS_VUELOS
SELECT V.IDVUELO,P.IDPASAJERO,A.COSTOPASAJE VENTAS_X_PASAJERO,V.IDVUELO AS ID_TIEMPO
FROM VUELO V
INNER JOIN FACTURADETALLE FD ON V.IDVUELO=FD.VUELO_IDVUELO
INNER JOIN PASAJERO P ON FD.PASAJERO_IDPASAJERO=P.IDPASAJERO
INNER JOIN ASIENTO A ON FD.ASIENTO_IDASIENTO=A.IDASIENTO;




