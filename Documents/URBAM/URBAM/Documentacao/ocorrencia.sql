CREATE TABLE natureza_ocorrencia (
  nat_id int NOT NULL AUTO_INCREMENT,
  nat_codigo varchar(5) NOT NULL COMMENT='Codigo da natureza formada por 3 caracteres: X99 (1 alfa, 2 numericos)',
  nat_descricao varchar(100) NOT NULL,
  nat_status char(1) DEFAULT NULL,
  nat_data_inclusao date DEFAULT NULL,
  nat_cod_operador_inc int DEFAULT NULL,
  nat_data_alteracao date DEFAULT NULL,
  nat_cod_operador_alt int DEFAULT NULL,
  nat_ativo BOOL,
  PRIMARY KEY (`nat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela natureza  de ocorrencias (, contra pessoa, contra patrimônio público, contra os costumes, ameaças, etc)';

/*
CREATE TABLE grupo_ocorrencia (
  gru_id int NOT NULL AUTO_INCREMENT,
  nat_id int NOT NULL,
  gru_codigo varchar (10) NOT NULL,
  gru_descricao varchar(100) NOT NULL,
  gru_status char(1) DEFAULT NULL,
  gru_data_inclusao date DEFAULT NULL,
  gru_cod_operador_inc int DEFAULT NULL,
  gru_data_alteracao date DEFAULT NULL,
  gru_cod_operador_alt int DEFAULT NULL,
  gru_ativo BOOL,
  PRIMARY KEY (`gru_id`)
  CONSTRAINT grupo_ocorrencia_FK FOREIGN KEY (`nat_id`) REFERENCES natureza_ocorrencia (`nat_id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de grupo  ocorrencias (detalha a natureza da ocorrência)';
*/

CREATE TABLE regional (
  reg_id int NOT NULL AUTO_INCREMENT,
  reg_codigo varchar(12) NOT NULL,
  reg_descricao varchar(100) NOT NULL,
  reg_status char(1) DEFAULT NULL,
  reg_data_inclusao date DEFAULT NULL,
  reg_cod_operador_inc int DEFAULT NULL,
  reg_data_alteracao date DEFAULT NULL,
  reg_cod_operador_alt int DEFAULT NULL,
  reg_ativo BOOL,
  PRIMARY KEY (`reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela das sedes utsadas pela Prefeitura alocadas para GCM)';

CREATE TABLE proprios_municipais (
  pro_id int NOT NULL AUTO_INCREMENT,
  reg_id int NOT NULL,
  pro_codigo varchar(12) NOT NULL,
  pro_descricao varchar(100) NOT NULL,
  pro_status char(1) DEFAULT NULL,
  pro_nome_resp varchar (30) DEFAULT NULL,
  pro_telefone varchar (12) DEFAULT NULL,
  pro_ramal  varchar(4) DEFAULT NULL,
  pro_latitude int DEFAULT NULL,
  pro_longitude int DEFAULT NULL,
  pro_data_inclusao date DEFAULT NULL,
  pro_cod_operador_inc int DEFAULT NULL, 
  pro_data_alteracao date DEFAULT NULL,
  pro_cod_operador_alt int DEFAULT NULL,
  pro_ativo BOOL,
  PRIMARY KEY (`pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT= 'Tabela de proprios municipais que fazem parte do patrimonio do municipio';



CREATE TABLE gcm (
  gcm_id int NOT NULL AUTO_INCREMENT,
  gcm_ra varchar(12) NOT NULL,
  gcm_nome varchar(100) NOT NULL,
  gcm_cpf  varchar (14) DEFAULT NULL,
  gcm_nivel varchar(5) DEFAULT NULL,
  gcm_classe varchar(3) default null,
  gcm_status BOOL,
  gcm_data_inclusao date DEFAULT NULL,
  gcm_cod_operador_inc int DEFAULT NULL,
  gcm_data_alteracao date DEFAULT NULL,
  gcm_cod_operador_alt int DEFAULT NULL,
  gcm_ativo BOOL,
  PRIMARY KEY (`gcm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de guardas municipais';


-- 153_novo.ocorrencia definition

CREATE TABLE ocorrencia (
  oco_id int NOT NULL AUTO_INCREMENT,
  oco_protocolo varchar(20) NOT NULL,
  oco_ano_ocorrencia int NOT NULL,
  oco_mes_ocorrencia int NOT NULL,
  oco_dia_ocorrencia int NOT NULL,
  oco_time_stamp timestamp NULL DEFAULT NULL,
  oco_status varchar(20) DEFAULT NULL,
  nat_id int NOT NULL,
  gru_id int NOT  NULL,
  pro_id int  DEFAULT NULL,
  oco_grupo_ocorrencia int DEFAULT NULL,
  oco_logradouro varchar (15),
  oco_nome_logradouro varchar(40),
  oco_bairro_distrito varchar (40),
  oco_localidade varchar (40),
  oco_cep varchar (12),
  oco_latitude varchar (15),
  oco_longitude varchar (15),
  oco_referencia varchar (50) DEFAULT NULL,
  oco_transversal varchar (30) DEFAULT NULL,
  oco_denuncia_anonima tinyint(1) DEFAULT NULL,
  oco_nome_solicitante varchar(50) DEFAULT NULL,
  oco_ddd_fone_solicitante int DEFAULT NULL,
  oco_fone_solicitante varchar(12) DEFAULT NULL,
  oco_descricao_fato varchar(300) DEFAULT NULL,
  oco_descricao_comp  varchar(200) NULL,
  oco_arma_fogo BOOL,
  oco_agressor_local  BOOL,
  oco_refem BOOL,
  oco_explosivo BOOL,
  oco_cronologia varchar(30) DEFAULT NULL, 
  oco_descricao_solucao varchar(300) NULL,
  oco_bopc VARCHAR(20) NULL,
  oco_bopm varchar(20) NULL,
  oco_data_fim DATE NOT NULL,
  oco_hora_fim TIMESTAMP NULL,
  oco_nome_testemunha1 varchar (50),
  oco_fin_nome_testemunha2 varchar(50),
  oco_rg_testemunha2 varchar (15),
  oco_matricula_gcm varchar(12) NULL,
  oco_despachada BOOL DEFAULT NULL,
  oco_hora_despacho TIMESTAMP,
  oco_hora_finalizacao TIMESTAMP,
  oco_data_inclusao date DEFAULT NULL,
  oco_data_alteracao date DEFAULT NULL,
  oco_codigo_operador_inc int DEFAULT NULL,
  oco_codigo_operador_alt int DEFAULT NULL,
  oco_ativo BOOL,
  PRIMARY KEY (`oco_id`),
  CONSTRAINT ocorrencia_FK FOREIGN KEY (`nat_id`) REFERENCES natureza_ocorrencia (`nat_id`),
  CONSTRAINT ocorrencia_FK1 FOREIGN KEY (`gru_id`) REFERENCES grupo_ocorrencia (`gru_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='registro de ocorrencias para GCM, FP e Defesa Civil)';


CREATE TABLE historico_ocorrencia (
	hist_id int NOT NULL AUTO_INCREMENT,
	oco_id int NOT NULL,
	hist_origem varchar(12) DEFAULT NULL,
	hist_descricao varchar(20) DEFAULT NULL,
	hist_data DATETIME DEFAULT NULL,
	PRIMARY KEY (`hist_id`),
	CONSTRAINT historico_ocorrencia_FK FOREIGN KEY (`oco_id`) REFERENCES `ocorrencia` (`oco_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Historico de mudanças de situação da ocorrencia ';
-- 153_novo.solicitante_complemento definition

CREATE TABLE solicitante_complemento (
  sol_id int NOT NULL AUTO_INCREMENT,
  oco_id int NOT NULL,
  sol_ano_ocorrencia int NOT NULL,
  sol_mes_ocorrencia int NOT NULL,
  sol_dia_ocorrencia int NOT NULL,
  sol_time_stamp timestamp NULL DEFAULT NULL,
  sol_nome_solicitante varchar(100) DEFAULT NULL,
  sol_ddd_fone_solicitante int NOT NULL,
  sol_fone_solicitante varchar(12) DEFAULT NULL,
  sol_rg varchar(20) DEFAULT NULL,
  sol_cpf varchar(14) DEFAULT NULL,
  sol_data_nascimento date DEFAULT NULL,
  sol_logradouro varchar (15),
  sol_nome_logradouro varchar(40),
  sol_bairro_distrito varchar (40),
  sol_localidade varchar (40),
  sol_CEP varchar (12),
  sol_deseja_apresentar tinyint(1) DEFAULT NULL,
  sol_data_inclusao date DEFAULT NULL,
  sol_data_alteracao date DEFAULT NULL,
  sol_codigo_operador_inc int DEFAULT NULL,
  sol_codigo_operador_alt int DEFAULT NULL,
  sol_ativo BOOL,
  PRIMARY KEY (`sol_id`),
  KEY solicitante_complemento_FK (`oco_id`),
  CONSTRAINT solicitante_complemento_FK FOREIGN KEY (`oco_id`) REFERENCES `ocorrencia` (`oco_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Dados do solicitante da  ocorrência relacionadas Sistema de Protecao ao Cidadao por meio do 153';

CREATE TABLE veiculo_envolvido (
  vei_id int NOT NULL AUTO_INCREMENT,
  oco_id int NOT NULL,
  vei_tipo_veiculo varchar(20) DEFAULT NULL,
  vei_marca varchar(50) DEFAULT NULL,
  vei_modelo varchar(50) DEFAULT NULL,
  vei_cor varchar(20) DEFAULT NULL,
  vei_placa varchar(12) DEFAULT NULL,
  vei_renavan varchar (20) DEFAULT NULL,
  vei_chassi varchar (30) DEFAULT NULL,
  vei_data_inc date DEFAULT NULL,
  vei_data_alt date DEFAULT NULL,
  vei_operador_inc int DEFAULT NULL,
  vei_nro_chassi varchar(30) DEFAULT NULL,
  vei_ativo BOOL,
  PRIMARY KEY (`vei_id`),
  CONSTRAINT veiculo_envolvido_FK FOREIGN KEY (`oco_id`) REFERENCES 153_novo.ocorrencia (`oco_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela veiculos envolvidos ocorrencia';


/*
CREATE TABLE ocorrencia_complemento  (
  com_id int NOT NULL AUTO_INCREMENT,
  oco_id int NOT NULL,
  com_descricao  varchar(200) NULL,
  com_natureza_ocorrencia  varchar(20) NULL,
  com_grupo_ocorrencia varchar(20) NULL,
  com_arma_fogo BOOL,
  com_agressor_local  BOOL,
  com_refem BOOL,
  com_explosivo BOOL,
  com_cronologia varchar(30) DEFAULT NULL,  
  com_data_alteracao date DEFAULT NULL,
  com_codigo_operador_inc int DEFAULT NULL,
  com_codigo_operador_alt int DEFAULT NULL,
  com_ativo BOOL,
  PRIMARY KEY (`com_id`)
  
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Informações complementares da ocorrencia em andamento';
*/


-- 153_novo.viatura definition

CREATE TABLE viatura (
  via_id int NOT NULL AUTO_INCREMENT,
  via_tipo_veiculo varchar(20) DEFAULT NULL,
  via_marca varchar(50) DEFAULT NULL,
  via_modelo varchar(50) DEFAULT NULL,
  via_capac_passageiros int DEFAULT NULL,
  via_placa varchar(12) DEFAULT NULL,
  via_tipo_viatura varchar(5) DEFAULT NULL,
  via_prefixo int DEFAULT NULL,
  via_situacao varchar(20) DEFAULT NULL COMMENT='DISPONIVEL / EMPENHADA',
  via_ano_fabricacao int DEFAULT NULL,
  via_ano_modelo int DEFAULT NULL,
  via_tipo_combustivel varchar(20) DEFAULT NULL COMMENT 'Gasolina, Alcool, Flex, Hibrido, eletrico',
  via_renavan varchar(20) DEFAULT NULL,
  via_nro_chassi varchar(30) DEFAULT NULL,
  via_data_inc date DEFAULT NULL,
  via_data_alt date DEFAULT NULL,
  via_operador_inc int DEFAULT NULL,
  via_ativo BOOL,
  PRIMARY KEY (`via_id`),
  KEY viatura_via_prefixo_IDX (`via_prefixo`,`via_situacao`) USING BTREE,
  KEY viatura_via_tipo_viatura_IDX (`via_tipo_viatura`,`via_prefixo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de viaturas que podem ser despachadas para ocorrencias';


CREATE TABLE rastreio (
	ras_id int NOT NULL AUTO_INCREMENT,
	via_id int NOT NULL,
	ras_data DATE NOT NULL,
	ras_time TIME NOT NULL,
	ras_latitude int NOT NULL,
	ras_longitude int NOT NULL,
	PRIMARY KEY (ras_id),
	CONSTRAINT rastreio_FK FOREIGN KEY (`via_id`) REFERENCES viatura (`via_id`)
)
	


CREATE TABLE envolvido_ocorrencia (
	env_id  INT  NOT NULL auto_increment,
	oco_id  INT  NOT NULL,
    env_nome varchar(100) NULL,
	env_vulgo varchar(50) NULL,
	env_sexo varchar(10) NULL,
	env_cor varchar(12) NULL,
	env_faixa_etaria int NULL,
	env_estilo_cabelo int NULL,
	env_barba varchar(12) NULL,
	env_usa_oculos BOOL,
	env_crianca_colo BOOL,
	env_acessorio_cabeca BOOL,
	env_qual_acessorio varchar(12),
	env_vestimenta_sup varchar(12),
	env_cor_vestimenta_sup varchar(12),
	env_vestimenta_inf varchar(12),
	env_cor_vestimenta_inf varchar(12),
	env_rg varchar(20) NULL,
	env_cpf varchar(14) NULL,
	env_data_nascimento DATE NULL,
	env_autor BOOL NULL,
	env_nome_mae varchar(50) NULL,
	env_apresentou_documentos BOOL NULL,
	env_apresentado_autoridade BOOL NULL,
	env_data_apresentacao DATE NULL,
	env_hora_apresentacao TIME NULL,
	env_data_inc DATE NULL,
	env_data_alt DATE NULL,
	env_operador_inc INT NULL,
	env_operador_alt varchar(100) NULL,
	env_ativo BOOL,
	CONSTRAINT envolvidos_ocorrencia_PK PRIMARY KEY (`env_id`),
	CONSTRAINT envolvidos_ocorrencia_FK FOREIGN KEY (`oco_id`) REFERENCES ocorrencia(`oco_id`)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='Relação dos envolvidos em ocorrências provenientes 153';

/*
CREATE TABLE final_ocorrencia  (
    fin_id INT  AUTO_INCREMENT NOT NULL,
	oco_id INT NOT NULL,
	fin_descricao varchar(300) NULL,
	fin_bopc VARCHAR(100) NULL,
	fin_bopm varchar(20) NULL,
	fin_data DATE NOT NULL,
	fin_hora TIMESTAMP NULL,
	gcm_id int NOT NULL,
	fin_nome_testemunha1 varchar (50),
	fin_rg_testemunha varchar (15),
	fin_nome_testemunha2 varchar(50),
	fin_rg_testemunha2 varchar (15),
	fin_ra_encarregado VARCHAR(30) NULL,
	fin_ra_inspetor varchar(50) NULL,
	fin_data_inc DATE NULL,
	findata_alt DATE NULL,
	fin_operador_inc INT NULL,
	fin_operador_alt INT NULL,
	fin_ativo BOOL,
	CONSTRAINT final_ocorrencia_PK PRIMARY KEY (`fin_id`),
	CONSTRAINT final_ocorrencia_FK1 FOREIGN KEY (`oco_id`) REFERENCES  ocorrencia (`oco_id`),
	CONSTRAINT final_ocorrencia_FK2 FOREIGN KEY (`gcm_id`) REFERENCES  gcm (`gcm_id`)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='Registro da solução da ocorrência pela  guarniçao da viatura';
*/

/*
CREATE TABLE 153_novo.ocorrencia_viatura (
	oco_id INT NOT NULL,
	via_id INT NOT NULL,
	ocv_id INT auto_increment NOT NULL,
	CONSTRAINT ocorrencia_viatura_PK PRIMARY KEY (ocv_id),
	CONSTRAINT ocorrencia_viatura_FK FOREIGN KEY (oco_id) REFERENCES 153_novo.ocorrencia(oco_id),
	CONSTRAINT ocorrencia_viatura_FK_1 FOREIGN KEY (via_id) REFERENCES 153_novo.viatura(via_id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='Relaciona ou associa viatura(s) com ocorrência (normalmente o centro de controle paga o talão para apenas uma viatura) que fica responsável pelo QRU';
*/
