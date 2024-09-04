SET ECHO ON;

SELECT SYSDATE FROM DUAL;

CREATE TABLE ESPECIALIDADE(
    COD_ESPEC NUMBER(3)
        CONSTRAINT pk_cod_espec PRIMARY KEY,
    NOME VARCHAR2(30) NOT NULL,
    OBS VARCHAR2(100)
);

CREATE TABLE CONVENIO(
    COD_CONV VARCHAR2(6)
        CONSTRAINT pk_cod_conv PRIMARY KEY,
    NOME VARCHAR2(20) NOT NULL,
    STATUS NUMBER(1)
        CONSTRAINT ck_status CHECK (STATUS IN(0, 1, 2))
);


CREATE TABLE MEDICO(
    COD_MED NUMBER(4)
        CONSTRAINT pk_cod_med PRIMARY KEY,
    NOME VARCHAR2(50) NOT NULL,
    TITULO VARCHAR2(10),
    CRM NUMBER(6) 
        CONSTRAINT uk_crm UNIQUE,
    UF_CRM VARCHAR2(2) 
        CONSTRAINT uk_uf_crm UNIQUE,
    COD_ESPEC NUMBER(3) NOT NULL
        CONSTRAINT fk_cod_espec REFERENCES ESPECIALIDADE 
);

CREATE TABLE PACIENTE(
    COD_PAC NUMBER(7) 
        CONSTRAINT pk_cod_pac PRIMARY KEY,
    NOME VARCHAR2(50) NOT NULL,
    DT_NASC DATE NOT NULL,
    SEXO VARCHAR(1) NOT NULL
        CONSTRAINT ck_sexo CHECK(SEXO IN('F', 'M')),
    COD_CONV VARCHAR2(6) 
        CONSTRAINT fk_cod_conv REFERENCES CONVENIO,
    HISTORICO VARCHAR2(4000)
);


CREATE TABLE ATENDIMENTO(
    COD_PAC NUMBER(7) 
        CONSTRAINT fk-cod_pac REFERENCES PACIENTE,
    COD_MED NUMBER(4) 
        CONSTRAINT fk_cod_med REFERENCES MEDICO,
    DT_ATEND DATE,
        CONSTRAINT pk_atendimento PRIMARY KEY (COD_PAC, 
            COD_MED,
            DT_ATEND),
    DT_RETORNO DATE,
    PRECO NUMBER(7,2) 
        CONSTRAINT ck_preco_atend CHECK (PRECO >= 0),
    OBS VARCHAR2(500)
);
