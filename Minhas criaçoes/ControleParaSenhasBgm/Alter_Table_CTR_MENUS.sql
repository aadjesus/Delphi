ALTER TABLE CTR_MENUSDOSISTEMA ADD(TECLAS VARCHAR2(7) NULL) ;
ALTER TABLE CTR_MENUSAOUSUARIO ADD(TECLAS VARCHAR2(7) NULL) ;
ALTER TABLE CTR_CADASTRODEUSUARIOS ADD(UTILIZACADTECLAS    VARCHAR2(1) DEFAULT 'S'
                                      ,UTILIZACADCHECKLIST VARCHAR2(1) DEFAULT 'S'
                                      ,UTILIZACADRECADOS   VARCHAR2(1) DEFAULT 'S'
                                      ,UTILIZANOVIDADESMOD VARCHAR2(1) DEFAULT 'S'
                                      ,UTILIZAREMITIRREL   VARCHAR2(1) DEFAULT 'S'
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