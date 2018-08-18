CREATE TABLE dim_pasajeros (
    id_pasajero   INTEGER NOT NULL,
    pasaporte     VARCHAR(100),
    pasajero      VARCHAR(255)
);

ALTER TABLE dim_pasajeros ADD CONSTRAINT dim_pasajeros_pk PRIMARY KEY ( id_pasajero );

CREATE TABLE dim_tiempos (
    id_tiempo   INTEGER NOT NULL,
    dia         VARCHAR(50),
    semana      INTEGER,
    mes         VARCHAR(50),
    anio        INTEGER,
    trimestre   INTEGER
);

ALTER TABLE dim_tiempos ADD CONSTRAINT dim_tiempos_pk PRIMARY KEY ( id_tiempo );

CREATE TABLE dim_vuelos (
    id_vuelo         INTEGER NOT NULL,
    piloto           VARCHAR(255),
    copiloto         VARCHAR(255),
    ciudad_origen    VARCHAR(255),
    ciudad_destino   VARCHAR(255),
    registro_avion   VARCHAR(50)
);

ALTER TABLE dim_vuelos ADD CONSTRAINT dim_vuelos_pk PRIMARY KEY ( id_vuelo );

CREATE TABLE hechos_vuelos (
    id_pasajero         INTEGER NOT NULL,
    id_vuelo            INTEGER NOT NULL,
    id_tiempo           INTEGER NOT NULL,
    ventas_x_pasajero   INTEGER NOT NULL
);

ALTER TABLE hechos_vuelos
    ADD CONSTRAINT hechos_vuelos_pk PRIMARY KEY ( id_pasajero,
    id_vuelo,
    id_tiempo );

ALTER TABLE hechos_vuelos
    ADD CONSTRAINT vuelos_hvuelos_fk FOREIGN KEY ( id_vuelo )
        REFERENCES dim_vuelos ( id_vuelo );

ALTER TABLE hechos_vuelos
    ADD CONSTRAINT vuelos_pasajeros_fk FOREIGN KEY ( id_pasajero )
        REFERENCES dim_pasajeros ( id_pasajero );

ALTER TABLE hechos_vuelos
    ADD CONSTRAINT vuelos_tiempos_fk FOREIGN KEY ( id_tiempo )
        REFERENCES dim_tiempos ( id_tiempo );
