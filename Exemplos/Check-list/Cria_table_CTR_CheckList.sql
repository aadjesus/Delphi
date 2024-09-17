drop table CTR_CheckList
Create Table CTR_CheckList(USUARIO    	VARCHAR2(15) NOT NULL		 
                          ,SISTEMA	    VARCHAR2(3)	 NOT NULL	
                          ,INDICEMENU   VARCHAR2(6)	 NOT NULL	
                          ,ORDEM        NUMBER       NOT NULL	                    
                          ,PROCEDIMENTO VARCHAR2(30)		
                          ,EXECUTADO    VARCHAR2(1)  DEFAULT 'N'		
                          ,DATAEXECUSAO DATE         
                          ,DATACRIACAO  DATE         DEFAULT sysdate
                          ,EXECUTAR     VARCHAR2(1)  DEFAULT 'S'
                          ,QTDEDIAS     NUMBER
                          );
                          
--                          ,EXECUTAR     -- (D = na data / P = no periodo / S = sempre )

                          
