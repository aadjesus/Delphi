�
 TUSERS 0!5  TPF0TUsersUsersOldCreateOrder	OnCreateUsersCreateLeft>TopfHeight�Width� TDataSourcedsUsersDataSetqryUsersLeftTopL  TDataSource
dsProfilesDataSetqryProfilesLeftLTopL  TDataSourcedsProgsDataSetqryProgsLeft� TopL  TDataSource	dsHistoryDataSet
qryHistoryLeft� TopL  TDataSource	dsUAccessDataSet
qryUAccessLeftTopL  TDataSource	dsPAccessDataSet
qryPAccessLeft`TopL  TQuery
GenerateIdDatabaseNamedbUsersInterbaseLeft0Top8  TQueryProfNullDatabaseNamedbUsersInterbase
DataSource
dsProfilesSQL.StringsUpdate UCS_USERSSet PROFILE_ID=0Where PROFILE_ID=:PROF_ID  LeftLTop� 	ParamDataDataTypeftFloatNamePROF_ID	ParamType	ptUnknown    TQueryDelUserFromUAccessDatabaseNamedbUsersInterbase
DataSourcedsUsersSQL.Stringsdelete From UCS_UACCESSWhere USER_ID=:USER_ID  Left0Top� 	ParamDataDataTypeftFloatNameUSER_ID	ParamType	ptUnknown    TQueryDelProgsFromUAccessDatabaseNamedbUsersInterbase
DataSourcedsProgsSQL.Stringsdelete From UCS_UACCESSWhere MENU_ID=:MENU_ID Left0Top� 	ParamDataDataTypeftFloatNameMENU_ID	ParamType	ptUnknown    TQueryDelProfsFromPAccessDatabaseNamedbUsersInterbase
DataSource
dsProfilesSQL.Stringsdelete From UCS_PACCESSWhere PROF_ID=:PROF_ID  Left� Top� 	ParamDataDataTypeftFloatNamePROF_ID	ParamType	ptUnknown    TQueryDelProgsFromPAccessDatabaseNamedbUsersInterbase
DataSourcedsProgsSQL.Stringsdelete From UCS_PACCESSWhere MENU_ID=:MENU_ID Left� Top� 	ParamDataDataTypeftFloatNameMENU_ID	ParamType	ptUnknown    TQueryDelUHistoryDatabaseNamedbUsersInterbase
DataSourcedsUsersSQL.Stringsdelete From UCS_HISTORYWhere USER_ID=:USER_ID  LeftTop� 	ParamDataDataTypeftFloatNameUSER_ID	ParamType	ptUnknown    TQueryUpdateUFromProfileDatabaseNamedbUsersInterbase
DataSourcedsUsersSQL.StringsUpdate UCS_UACCESS /Set AUTHORIZED = (Select UCS_PACCESS.AUTHORIZED,                 From UCS_PACCESS, UCS_USERSB                 Where UCS_PACCESS.APP_KEY=UCS_UACCESS.APP_KEY ANDB                       UCS_PACCESS.MENU_ID=UCS_UACCESS.MENU_ID ANDE                       UCS_USERS.PROFILE_ID=UCS_PACCESS.PROF_ID   ANDA                       UCS_USERS.USER_ID=UCS_UACCESS.USER_ID  AND2                       UCS_USERS.USER_ID=:USER_ID)Where USER_ID=:USER_ID  LeftTop� 	ParamDataDataTypeftFloatNameUSER_ID	ParamType	ptUnknown DataTypeftFloatNameUSER_ID	ParamType	ptUnknown    TQueryqryUsers	AfterOpenqryUsersAfterOpenBeforeInsertqryUsersBeforeInsert
BeforeEditqryUsersBeforeEdit
BeforePostqryUsersBeforePost	AfterPostqryUsersAfterPostBeforeDeleteqryUsersBeforeDeleteAfterDeleteqryUsersAfterDeleteAfterScrollqryUsersAfterScrollOnCalcFieldsqryUsersCalcFieldsDatabaseNamedbUsersInterbaseRequestLive	SQL.StringsSELECT USERCS_NAME , REAL_NAME , USER_PWD ,
 USER_ID , LAST_PWD_CHANGE , PROFILE_ID, AUDIT_MODEFROM UCS_USERSORDER BY USERCS_NAME LeftTop TStringFieldqryUsersUSER_NAME	FieldNameUSERCS_NAMEOriginUCS_USERS.USERCS_NAMESize
  TStringFieldqryUsersREAL_NAME	FieldName	REAL_NAMEOriginUCS_USERS.REAL_NAMESize(  TStringFieldqryUsersUSER_PWD	FieldNameUSER_PWDOriginUCS_USERS.USER_PWD  TStringFieldqryUsersPROFILE	FieldKindfkLookup	FieldNamePROFILELookupDataSetqryProfilesLookupKeyFieldsPROF_IDLookupResultFieldPROF_DESCRIPTION	KeyFields
PROFILE_IDSizeLookup	  TStringFieldqryUsersCalcUserActive	FieldKindfkCalculated	FieldNameCalcUserActiveSize
Calculated	  TStringFieldqryUsersAUDIT_MODEDefaultExpression'0'	FieldName
AUDIT_MODEOriginUCS_USERS.USERCS_NAMESize  TFloatFieldqryUsersUSER_ID	FieldNameUSER_IDOriginUCS_USERS.USERCS_NAME  TFloatFieldqryUsersPROFILE_ID	FieldName
PROFILE_IDOriginUCS_USERS.REAL_NAME  TFloatFieldqryUsersLAST_PWD_CHANGE	FieldNameLAST_PWD_CHANGEOriginUCS_USERS.USERCS_NAME	OnGetTextqryUsersLAST_PWD_CHANGEGetText	OnSetTextqryUsersLAST_PWD_CHANGESetText   TQueryqryProfilesAfterInsertqryProfilesAfterInsert
BeforePostqryProfilesBeforePost	AfterPostqryProfilesAfterPostBeforeDeleteqryProfilesBeforeDeleteAfterDeleteqryProfilesAfterDeleteOnCalcFieldsqryProfilesCalcFieldsDatabaseNamedbUsersInterbaseRequestLive	SQL.StringsSELECT PROF_DESCRIPTION ,  PROF_ID ,  INTERVAL_CHANGE_PWD ,  MUST_CHANGE_PWD ,  HIDE_DISABLE_MENU, AUDIT_MODEFROM UCS_PROFILES ORDER BY PROF_DESCRIPTION LeftPTop TStringFieldqryProfilesPROF_DESCRIPTION	FieldNamePROF_DESCRIPTIONOriginUCS_PROFILES.PROF_DESCRIPTIONSize  TStringFieldqryProfilesMUST_CHANGE_PWDDefaultExpression'1'	FieldNameMUST_CHANGE_PWDOriginUCS_PROFILES.MUST_CHANGE_PWDSize  TStringFieldqryProfilesItemNotAutorized	FieldKindfkCalculated	FieldNameItemNotAutorized
Calculated	  TStringFieldqryProfilesCalcMustChangePwd	FieldKindfkCalculated	FieldNameCalcMustChangePwdSize
Calculated	  TStringFieldqryProfilesAUDIT_MODE	FieldName
AUDIT_MODEOriginUCS_PROFILES.PROF_DESCRIPTIONSize  TFloatFieldqryProfilesPROF_ID	FieldNamePROF_IDOriginUCS_PROFILES.PROF_DESCRIPTION  TFloatFieldqryProfilesINTERVAL_CHANGE_PWD	FieldNameINTERVAL_CHANGE_PWDOriginUCS_PROFILES.PROF_ID
EditFormat0  TFloatFieldqryProfilesHIDE_DISABLE_MENU	FieldNameHIDE_DISABLE_MENUOrigin UCS_PROFILES.INTERVAL_CHANGE_PWD   TQueryqryProgs
BeforePostqryProgsBeforePost	AfterPostqryProgsAfterPostBeforeDeleteqryProgsBeforeDeleteDatabaseNamedbUsersInterbaseRequestLive	SQL.StringsSELECT APP_KEY , MENU_NAME ,  MENU_ID , MENU_CAPTIONFROM UCS_PROGSWHERE APP_KEY=:APP_KEY   Left� Top	ParamDataDataTypeftStringNameAPP_KEY	ParamType	ptUnknown   TStringFieldqryProgsAPP_KEY	FieldNameAPP_KEYOriginUCS_PROGS.APP_KEY  TStringFieldqryProgsMENU_NAMEDisplayWidthd	FieldName	MENU_NAMEOriginUCS_PROGS.MENU_NAMESized  TStringFieldqryProgsMENU_CAPTIONDisplayWidthd	FieldNameMENU_CAPTIONOriginUCS_PROGS.MENU_CAPTIONSized  TFloatFieldqryProgsMENU_ID	FieldNameMENU_IDOriginUCS_PROGS.APP_KEY   TQuery
qryHistoryDatabaseNamedbUsersInterbaseRequestLive	SQL.StringsSELECT USER_ID , USER_PWD ,  CHANGE_DATEFROM UCS_HISTORY  Left� Top TStringFieldqryHistoryUSER_PWD	FieldNameUSER_PWDOriginUCS_HISTORY.USER_PWD  TFloatFieldqryHistoryUSER_ID	FieldNameUSER_IDOriginUCS_HISTORY.USER_ID  TFloatFieldqryHistoryCHANGE_DATE	FieldNameCHANGE_DATEOriginUCS_HISTORY.USER_ID	OnGetTextqryHistoryCHANGE_DATEGetText   TQuery
qryUAccessDatabaseNamedbUsersInterbaseRequestLive	SQL.StringsSELECT APP_KEY , USER_ID ,  MENU_ID , AUTHORIZEDFROM UCS_UACCESSWHERE APP_KEY=:APP_KEY LeftTop	ParamDataDataTypeftStringNameAPP_KEY	ParamType	ptUnknown   TStringFieldqryUAccessAPP_KEY	FieldNameAPP_KEYOriginUCS_UACCESS.APP_KEY  TStringFieldqryUAccessAUTHORIZED	FieldName
AUTHORIZEDOriginUCS_UACCESS.AUTHORIZEDSize  TFloatFieldqryUAccessUSER_ID	FieldNameUSER_IDOriginUCS_UACCESS.APP_KEY  TFloatFieldqryUAccessMENU_ID	FieldNameMENU_IDOriginUCS_UACCESS.USER_ID   TQuery
qryPAccessDatabaseNamedbUsersInterbaseSessionNameDefaultRequestLive	SQL.StringsSELECT APP_KEY , PROF_ID ,  MENU_ID , AUTHORIZEDFROM UCS_PACCESS WHERE APP_KEY=:APP_KEY Left`Top	ParamDataDataTypeftStringNameAPP_KEY	ParamType	ptUnknown   TStringFieldqryPAccessAPP_KEY	FieldNameAPP_KEYOriginUCS_PACCESS.APP_KEY  TStringFieldqryPAccessAUTHORIZED	FieldName
AUTHORIZEDOriginUCS_PACCESS.AUTHORIZEDSize  TFloatFieldqryPAccessPROF_ID	FieldNamePROF_IDOriginUCS_PACCESS.APP_KEY  TFloatFieldqryPAccessMENU_ID	FieldNameMENU_IDOriginUCS_PACCESS.PROF_ID   TQueryqryAuditDatabaseNamedbUsersInterbaseSQL.StringsSELECT UCS_AUDIT.APP_KEY ,  UCS_AUDIT.USER_ID ,  UCS_AUDIT.PROG_ID ,  UCS_AUDIT.START_SESSION ,  UCS_AUDIT.END_SESSION ,  UCS_AUDIT.COMPUTER_NAME ,  UCS_PROGS.MENU_CAPTION ,  UCS_USERS.USERCS_NAME&FROM UCS_AUDIT , UCS_USERS , UCS_PROGS/WHERE ( UCS_AUDIT.USER_ID = UCS_USERS.USER_ID )  AND* ( UCS_AUDIT.PROG_ID = UCS_PROGS.MENU_ID )  AND* ( UCS_AUDIT.APP_KEY = UCS_PROGS.APP_KEY )  AND ( UCS_AUDIT.APP_KEY=:APP_KEY) 
UpdateModeupWhereKeyOnlyLeft�Top	ParamDataDataTypeftStringNameAPP_KEY	ParamType	ptUnknown   TStringFieldqryAuditAPP_KEY	FieldNameAPP_KEYOrigin"UCS_AUDIT.DB".APP_KEY  TFloatFieldqryAuditUSER_ID	FieldNameUSER_IDOrigin"UCS_AUDIT.DB".USER_ID  TFloatFieldqryAuditPROG_ID	FieldNamePROG_IDOrigin"UCS_AUDIT.DB".PROG_ID  TStringFieldqryAuditCOMPUTER_NAME	FieldNameCOMPUTER_NAMEOrigin"UCS_AUDIT.DB".COMPUTER_NAMESize  TStringFieldqryAuditMENU_CAPTION	FieldNameMENU_CAPTIONOrigin"UCS_PROGS.DB".MENU_CAPTIONSized  TStringFieldqryAuditUSERCS_NAME	FieldNameUSERCS_NAMEOrigin"UCS_USERS.DB".USERCS_NAMESize
  TStringFieldqryAuditSTART_SESSION	FieldNameSTART_SESSIONOriginUCS_AUDIT.APP_KEY	OnGetTextqryAuditSTART_SESSIONGetText  TStringFieldqryAuditEND_SESSION	FieldNameEND_SESSIONOriginUCS_AUDIT.USER_ID	OnGetTextqryAuditEND_SESSIONGetText   TDataSourcedsAuditDataSetqryAuditLeft�TopH  TQueryqryUserNameDatabaseNamedbUsersInterbaseSQL.StringsSELECT USERCS_NAME, USER_IDFROM UCS_USERS WHERE USERCS_NAME<>'master'ORDER BY UCS_USERS.USERCS_NAME LeftxTop�   TDataSource
dsUserNameDataSetqryUserNameLeftxTop�   TQueryqryMenuCaptionDatabaseNamedbUsersInterbaseSQL.StringsSELECT MENU_CAPTION, MENU_IDFROM UCS_PROGS  WHERE UCS_PROGS.APP_KEY=:APP_KEYOrder By UCS_PROGS.MENU_CAPTION  Left�Top� 	ParamDataDataTypeftStringNameAPP_KEY	ParamType	ptUnknown    TDataSourcedsMenuCaptionDataSetqryMenuCaptionLeft�Top�   TQueryqryUserInfoDatabaseNamedbUsersInterbaseRequestLive	SQL.StringsSelect  APP_KEY, 
  USER_ID,  EXPIRATION_DATE,  USER_EXPIRE,  USER_ACTIVEFrom UCS_USERINFOWhere APP_KEY=:APP_KEY  Left�Top	ParamDataDataTypeftStringNameAPP_KEY	ParamType	ptUnknown   TStringFieldqryUserInfoAPP_KEY	FieldNameAPP_KEYOriginUCS_USERINFO.APP_KEY  TStringFieldqryUserInfoUSER_EXPIRE	FieldNameUSER_EXPIREOriginUCS_USERINFO.USER_EXPIRESize  TStringFieldqryUserInfoUSER_ACTIVE	FieldNameUSER_ACTIVEOriginUCS_USERINFO.USER_ACTIVESize  TFloatFieldqryUserInfoUSER_ID	FieldNameUSER_IDOriginUCS_USERINFO.APP_KEY  TFloatFieldqryUserInfoEXPIRATION_DATE	FieldNameEXPIRATION_DATEOriginUCS_USERINFO.APP_KEY   TDataSource
dsUserInfoDataSetqryUserInfoLeft�TopH  TQueryqryAddUserInfoSQL.StringsInsert into UCS_USERINFO Values
(:APP_KEY,
 :USER_ID, :EXPIRATION_DATE, '0', '1')  Left� Top0	ParamDataDataTypeftStringNameAPP_KEY	ParamType	ptUnknown DataTypeftFloatNameUSER_ID	ParamType	ptUnknown DataTypeftFloatNameEXPIRATION_DATE	ParamType	ptUnknown    TQueryqryDelUserInfoDatabaseNamedbUsersInterbase
DataSourcedsUsersSQL.StringsDelete From UCS_USERINFOWhere USER_ID=:USER_ID  LeftTop0	ParamDataDataTypeftFloatNameUSER_ID	ParamType	ptUnknown    TQueryQuery1DatabaseNamedbUsersInterbaseRequestLive	SQL.StringsSELECT APP_KEY , USER_ID ,
 PROG_ID , START_SESSION , END_SESSION , COMPUTER_NAMEFROM UCS_AUDITWHERE APP_KEY=:APP_KEY Left�Topx TStringFieldStringField1	FieldNameAPP_KEYOriginUCS_AUDIT.APP_KEY  TStringFieldStringField2	FieldNameCOMPUTER_NAMEOriginUCS_AUDIT.COMPUTER_NAMESize  TStringFieldStringField3	FieldKindfkLookup	FieldNameUSERCS_NAMELookupDataSetqryUsersLookupKeyFieldsUSER_IDLookupResultFieldUSERCS_NAME	KeyFieldsUSER_IDLookup	  TStringFieldStringField4DisplayWidthd	FieldKindfkLookup	FieldNameMENU_CAPTIONLookupDataSetqryProgsLookupKeyFieldsMENU_IDLookupResultFieldMENU_CAPTION	KeyFieldsPROG_IDSizedLookup	  TFloatFieldFloatField1	FieldNameUSER_IDOriginUCS_AUDIT.USER_ID  TFloatFieldFloatField2	FieldNamePROG_IDOriginUCS_AUDIT.PROG_ID  TStringFieldStringField5	FieldNameSTART_SESSIONOriginUCS_AUDIT.START_SESSIONSize  TStringFieldStringField6	FieldNameEND_SESSIONOriginUCS_AUDIT.END_SESSIONSize   TQueryqryDeleteAuditDatabaseNamedbUsersInterbase
DataSourcedsAuditSQL.Stringsdelete from UCS_AUDITwhere  APP_KEY = :APP_KEY and  USER_ID = :USER_ID and  PROG_ID = :PROG_ID and$  START_SESSION = :START_SESSION and   END_SESSION = :END_SESSION and   COMPUTER_NAME = :COMPUTER_NAME  Left�Topx	ParamDataDataTypeftStringNameAPP_KEY	ParamType	ptUnknown DataTypeftFloatNameUSER_ID	ParamType	ptUnknown DataTypeftFloatNamePROG_ID	ParamType	ptUnknown DataTypeftStringNameSTART_SESSION	ParamType	ptUnknown DataTypeftStringNameEND_SESSION	ParamType	ptUnknown DataTypeftStringNameCOMPUTER_NAME	ParamType	ptUnknown    TQueryUpdateUFromProfileAccessDatabaseNamedbUsersInterbase
DataSourcedsUsersSQL.StringsUpdate UCS_UACCESS Set AUTHORIZED = :AUTHORIZEDWhere USER_ID=:USER_ID AND      MENU_ID=:MENU_ID AND      PROFILE_ID=:PROF_ID AND      APP_KEY=:APP_KEY      Left�Top,	ParamDataDataTypeftStringName
AUTHORIZED	ParamType	ptUnknown DataTypeftFloatNameUSER_ID	ParamType	ptUnknown DataTypeftFloatNameMENU_ID	ParamType	ptUnknown DataTypeftFloatNamePROF_ID	ParamType	ptUnknown DataTypeftStringNameAPP_KEY	ParamType	ptUnknown     