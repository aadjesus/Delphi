ALTER TABLE CTR_MENUSDOSISTEMA ADD(TECLAS VARCHAR2(7) NULL) ;
ALTER TABLE CTR_MENUSAOUSUARIO ADD(TECLAS VARCHAR2(7) NULL) ;
ALTER TABLE CTR_CADASTRODEUSUARIOS ADD(UTILIZACADTECLAS    VARCHAR2(1) DEFAULT 'S'
                                      ,UTILIZACADCHECKLIST VARCHAR2(1) DEFAULT 'S'
                                      ,UTILIZACADLEMBRETES VARCHAR2(1) DEFAULT 'S'
                                      ,UTILIZANOVIDADESMOD VARCHAR2(1) DEFAULT 'S'
                                      ,UTILIZAREMITIRREL   VARCHAR2(1) DEFAULT 'S'
                                      ,ENVIAREMAILDATELA   VARCHAR2(1) DEFAULT 'S'
                                      );
CREATE TABLE CTR_EMAIL(CODEMAIL   NUMBER         NOT NULL
                      ,USUARIO	  VARCHAR2(15)   NOT NULL
                      ,SISTEMA	  VARCHAR2(3)    NOT NULL
                      ,DE         VARCHAR2(2000) NOT NULL
                      ,DATAEMAIL  DATE
                      ,PARA       VARCHAR2(2000) NOT NULL
                      ,CC         VARCHAR2(2000)
                      ,ASSUNTO    VARCHAR2(200)
                      ,PRIORIDADE VARCHAR2(1)    NOT NULL
                      ,TEXTO      LONG
                      ) ;
CREATE TABLE CTR_EMAILARQ(CODEMAIL NUMBER NOT NULL
                         ,ARQUIVO	 VARCHAR2(200)
                         ) ;                                  
CREATE TABLE CTR_LEMBRETES(USUARIO	       VARCHAR2(15)  NOT NULL
                          ,SISTEMA	       VARCHAR2(3)   NOT NULL
                          ,DATALEMBRETE    DATE          NOT NULL
                          ,LEMBRETE        VARCHAR2(255) NOT NULL
                          ,DATAVALIDADE    DATE          NULL
                          ,DATAATENCAO     DATE          NULL
                          ,CORLEMBRETE     VARCHAR2(15)  NULL
                          ,CORFONTLEMBRETE VARCHAR2(15)  NULL
                          ,CORATENCAO      VARCHAR2(15)  NULL
                          ,CORFONTATENCAO  VARCHAR2(15)  NULL                         
                          ,LINHA           NUMBER(3)     NULL
                          ,COLUNA          NUMBER(3)     NULL
                          ,ALTURA          NUMBER(3)     NULL
                          ,LARGURA         NUMBER(3)     NULL
                          ) ;                       

CREATE TABLE CTR_CHECKLIST(USUARIO	       VARCHAR2(15)  NOT NULL
                          ,SISTEMA	       VARCHAR2(3)   NOT NULL
                          ,INDICEMENU	     VARCHAR2(6)	 NOT NULL		
                          ,NOME	           VARCHAR2(30)	 NOT NULL		
                          ,CAPTION	       VARCHAR2(50)	 NOT NULL		
                          ,EXECUTARA       DATE          NULL
                          ,QTDEDIAS        NUMBER(3)     NULL
                          ,MOSTRAPARATODOS VARCHAR2(1)   NULL                         
                          --
                          ,TELA VARCHAR2(50)	 NOT NULL		
                          ,EXECUTADO VARCHAR2(1)   NULL                         
                          ,PROCEDIMENTO VARCHAR2(50)	 NOT NULL		
                          ) ;                          
CREATE TABLE CTR_HELPDOUSUARIO(USUARIO        VARCHAR2(15)  NOT NULL
                              ,SISTEMA        VARCHAR2(3)   NOT NULL
                              ,FORM	          VARCHAR2(30)	 NOT NULL		
                              ,TOPICO         VARCHAR2(30)	NOT NULL		
                              ,TEXTOTOPICO	  LONG			                              
                              ,MOSTRAPRATODOS VARCHAR2(1)	DEFAULT 'N'
                          ) ;                         
                         
-- apaga                         
ALTER TABLE CTR_MENUSDOSISTEMA drop(TECLAS ) ;
ALTER TABLE CTR_MENUSAOUSUARIO drop(TECLAS ) ;
ALTER TABLE CTR_CADASTRODEUSUARIOS drop(UTILIZACADTECLAS    
                                       ,UTILIZACADCHECKLIST 
                                       ,UTILIZACADLEMBRETES 
                                       ,UTILIZANOVIDADESMOD 
                                       ,UTILIZAREMITIRREL   
                                       ,ENVIAREMAILDATELA 
                                       );
drop TABLE CTR_EMAIL ;
drop TABLE CTR_EMAILARQ ;
drop TABLE CTR_LEMBRETES ;
drop TABLE CTR_CHECKLIST ;
drop TABLE CTR_HELPDOUSUARIO ;