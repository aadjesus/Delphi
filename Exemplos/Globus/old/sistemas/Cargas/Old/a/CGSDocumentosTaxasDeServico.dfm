�
 TFRMCGSDOCUMENTOSTAXASDESERVICO 0�D  TPF0TfrmCGSDocumentosTaxasDeServicofrmCGSDocumentosTaxasDeServicoLeft�Top� AlignalClientBorderIconsbiSystemMenu BorderStylebsNoneCaptionTaxas de ServicoClientHeight�ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
KeyPreview	OldCreateOrderPositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreate	OnDestroyFormDestroyOnHideFormHide
OnKeyPressFormKeyPressOnShowFormShowPixelsPerInch`
TextHeight TPanelpnlPrincipalLeft Top Width�HeightcAlignalClient
BevelOuterbvNoneTabOrder OnExitpnlPrincipalExit 	TGroupBoxgbxGridLeft Top� Width�Height� AlignalClientCaption#    Taxas de serviços  ( F8 - sair ) TabOrderVisible 	TRxDBGrid	gridTaxasLeftTopWidth�HeightLAlignalTop
DataSourcedsTaxasOptionsdgTitlesdgIndicator
dgColLines
dgRowLinesdgRowSelect 	PopupMenuPopMenu1ReadOnly	TabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style OnExitgridTaxasExit	OnKeyDowngridTaxasKeyDown
OnKeyPressgridTaxasKeyPressOnKeyUpgridTaxasKeyUpColumnsExpanded	FieldNamecodtaxasTitle.Caption   CódigoWidth&Visible	 Expanded	FieldName	DescricaoTitle.Caption   DescriçãoWidth� Visible	 Expanded	FieldNameQtdSolicTitle.CaptionQuant.Width$Visible	 Expanded	FieldName	QTDMINIMATitle.Caption   Qtd mínWidth+Visible	 Expanded	FieldName
ReferenciaTitle.CaptionRefWidthVisible	 Expanded	FieldName	VLRMINIMOTitle.Caption   Valor mín.Width:Visible	 Expanded	FieldNameValorTitle.CaptionValor WidthOVisible	 Expanded	FieldName
ObservacaoTitle.Caption   ObservaçãoWidthdVisible	    TDBGrid	gridSobreLeftTop[Width�HeightMAlignalClient
DataSourcedsTaxasSobreFont.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgRowSelect 
ParentFont	PopupMenupmSobreReadOnly	TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlackTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style OnExitgridSobreExitOnKeyUpgridTaxasKeyUpColumnsExpanded	FieldName	DescricaoTitle.CaptionSobreWidth� Visible	 Expanded	FieldNameDESCRICAOTIPOTitle.CaptionTipoWidthYVisible	 Expanded	FieldName
ReferenciaTitle.CaptionRef.WidthVisible	 Expanded	FieldNameValorTitle.CaptionValor Width^Visible	     	TGroupBoxgbxTaxasLeft Top Width�Height� AlignalTopCaption#    Taxas de serviços  ( F8 - sair ) TabOrder VisibleOnEntergbxTaxasEnterOnExitgbxTaxasExit TPanelpnlTaxasLeftTopDWidth�Height,AlignalTop
BevelOuterbvNoneTabOrderVisible TLabelLabel76LeftTopWidth<Height	AlignmenttaRightJustifyCaption   Qtde mínima  TLabellblValorMinimoLeftTopWidth=Height	AlignmenttaRightJustifyCaption   Valor mínimo  TLabellblReferenciaLeftTopWidth4Height	AlignmenttaRightJustifyCaption   ReferênciaFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabellblValorLeft2TopWidthHeight	AlignmenttaRightJustifyCaptionValorFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TPanelPanel1Left� TopWidthHeightCaptionPanel1TabOrderOnEnterPanel1Enter  TBitBtnbtnAddLeft�TopWidthHeightActionactGravarTaxaFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder
Glyph.Data
�   �   BM�       v   (               h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ������� ������� ��� ��� ������� ������� �  � � ����� �  � � ������� ������� ��� ��� ������� �������   TDBEditedtValorMinimoTaxasLeftNTop WidthmHeight	DataField	VLRMINIMO
DataSourcedsTaxasTabOrderOnChangenedValorSobreChangeOnExitedtQtdeMinimaTaxasExitOnKeyUpedtCodigoKeyUp  TDBEditedtQtdeMinimaTaxasLeftVTop WidthKHeight	DataField	QTDMINIMA
DataSourcedsTaxasTabOrder OnChangenedValorSobreChangeOnExitedtQtdeMinimaTaxasExit	OnKeyDownedtQtdeMinimaTaxasKeyDownOnKeyUpedtCodigoKeyUp  TDBLookupComboBoxcbxReferenciaTaxasLeftVTopWidthKHeightBiDiModebdLeftToRight	DataField
REFERENCIA
DataSourcedsTaxasKeyFieldCODIGO	ListField	DESCRICAO
ListSourcedsReferenciaParentBiDiModeTabOrderOnExitcbxReferenciaTaxasExit  TDBEditedtValorTaxasLeftNTopWidthUHeight	DataFieldVALOR
DataSourcedsTaxasTabOrderOnChangenedValorSobreChangeOnExitedtQtdeMinimaTaxasExitOnKeyUpedtCodigoKeyUp   TPanelpnlSobreLeftToppWidth�HeightCAlignalTop
BevelOuterbvNoneTabOrderVisible 	TGroupBoxgbxSobreLeftTop�Width�Height@Caption ( F8 - sair ) TabOrder  TLabelLabel8LeftTopWidthHeight	AlignmenttaRightJustifyCaptionTipoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabelLabel6Left*TopWidth"Height	AlignmenttaRightJustifyCaptionSobreFont.CharsetDEFAULT_CHARSET
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabellblReferencia2LeftTop*Width?Height	AlignmenttaRightJustifyCaption   ReferênciaFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabel	lblValor2LeftTop,WidthHeight	AlignmenttaRightJustifyCaptionValorFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TBitBtnbtnAddSobreLeft�Top&WidthHeightActionactGravarSobreFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder
Glyph.Data
�   �   BM�       v   (               h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ������� ������� ��� ��� ������� ������� �  � � ����� �  � � ������� ������� ��� ��� ������� �������   TDBLookupComboBoxcbbTipoLeft0TopWidth|HeightBiDiModebdLeftToRight	DataFieldTIPOTAXA
DataSourcedsTaxasSobreDropDownRowsKeyFieldCODIGO	ListField	DESCRICAO
ListSourcedsTipoParentBiDiModeTabOrderOnExitcbbTipoExit
OnKeyPresscbbSobreKeyPressOnKeyUpcbbSobreKeyUp  	TComboBoxcbbSobreLeftPTopWidth� HeightBiDiModebdLeftToRight
ItemHeightParentBiDiModeTabOrder OnExitcbbSobreExit
OnKeyPresscbbSobreKeyPressOnKeyUpcbbSobreKeyUp  TDBEditnedValorSobreLeft0Top&WidthcHeight	DataFieldVALOR
DataSourcedsTaxasSobreTabOrderOnChangenedValorSobreChangeOnExitnedValorSobreExitOnKeyUpcbbSobreKeyUp  TDBLookupComboBoxcbbReferenciaSobreLeftPTop%WidthJHeight	DataField
REFERENCIA
DataSourcedsTaxasSobreDropDownRowsKeyFieldCODIGO	ListField	DESCRICAO
ListSourcedsReferenciaTabOrderOnClicknedValorSobreChangeOnExitedtQtdeMinimaTaxasExitOnKeyUpcbbSobreKeyUp    TPanelpnlComumLeftTopWidth�Height5AlignalTop
BevelOuterbvNoneTabOrder  TLabelLabel24Left0TopWidth!Height	AlignmenttaRightJustifyCaption   CódigoFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TSpeedButtonspbCodigoTaxasLeft� TopWidthHeightEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
Glyph.Data
F  B  BMB      v   (               �                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ���������   ��� ��� �   ���p���p�   ��� �݀ �   ���     �   �D@p   �   ���p   �   ���     �   ���  p �   ����� ��   ����� ��   ����� ��   ������M��   �DDDDDM��   �tGDtGM��   �DDDDDM��   ���������   Margin 
ParentFontParentShowHintShowHintOnClickspbCodigoTaxasClick  TLabellblQtdSolicLeftTop!WidthFHeight	AlignmenttaRightJustifyCaptionQtde solicitada  TEditedtFocoLeftlTopWidthHeightAutoSizeTabOrderOnEnteredtFocoEnter  TEditedtDescricaoTaxasLeft� TopWidthHeightColorclMenuCtl3D	Enabled	MaxLength2ParentCtl3DTabOrder  
TDBNumEditedtQtdeSolicTaxasLeftVTopWidthKHeightTabStop	DataFieldQTDSOLIC
DataSourcedsTaxasDecimalsTabOrderOnChangenedValorSobreChangeOnExitedtQtdeSolicTaxasExit	OnKeyDownedtQtdeSolicTaxasKeyDownOnKeyUpedtCodigoKeyUp  TDBCheckBoxckbPendenteLeftETopWidthkHeightCaptionPendente	DataField	TAXA_PEND
DataSourcedsTaxasEnabledTabOrderValueCheckedSValueUncheckedNOnExitedtQtdeSolicTaxasExit	OnKeyDownedtCodigoKeyDownOnKeyUpedtCodigoKeyUp  TDBCheckBoxckbSobreLeft� TopWidthwHeightCaptionTaxa sobre valor	DataField
SOBREVALOR
DataSourcedsTaxasEnabledTabOrderValueCheckedSValueUncheckedNOnClickckbSobreClickOnExitedtQtdeSolicTaxasExit  TEdit	edtCodigoLeftVTopWidth3Height	MaxLengthTabOrder OnChangeedtCodigoChangeOnClickedtCodigoClickOnEnteredtCodigoEnterOnExitedtCodigoExit	OnKeyDownedtCodigoKeyDown
OnKeyPressedtCodigoKeyPressOnKeyUpedtCodigoKeyUp   TDBGrid
gridSobre2LeftTop� Width�HeightTabStopAlignalClientColor	clBtnFace
DataSourcedsTaxasSobre2Font.CharsetANSI_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgRowSelect 
ParentFont	PopupMenu	popSobre2ReadOnly	TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlackTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style VisibleOnExitgridSobreExitOnKeyUpgridTaxasKeyUpColumnsExpanded	FieldName	DescricaoTitle.CaptionSobreWidth� Visible	 Expanded	FieldNameDESCRICAOTIPOTitle.CaptionTipoWidthYVisible	 Expanded	FieldName
ReferenciaTitle.CaptionRef.WidthVisible	 Expanded	FieldNameValorTitle.CaptionValor Width^Visible	      TPanelpnlTotalLeft TopcWidth�Height!AlignalBottom
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder TLabelLabel1Left� Top
WidthHHeightCaptionTotal das taxas  TNumEditnedTotalTaxasLeftKTopWidthlHeightTabStop	AlignmenttaRightJustifyColor	clBtnFaceDecimalsEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder OnExitedtQtdeSolicTaxasExit   TPanelpnlObservacaoLeftkTop� Width�Height� 
BevelInnerbvRaised
BevelOuter	bvLowered
BevelWidthBorderWidthTabOrderVisible TBevelBevel7Left TopWidthHeight  TBevelBevel8Left Top]WidthHeight  TPanelpnlTituloObservacaoLeftTopWidth�HeightAlignalTop	AlignmenttaLeftJustify
BevelOuterbvNoneCaption          CGS - ObservaçõesTabOrder  TImageImage1Left Top WidthHeightAlignalLeftPicture.Data
�  TBitmapv  BMv      v   (                                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                                       �����          DLDH��         DDDDDH��       DDLLLLLH�      DDD4DDDD��     LDLC<LLLLH�    DDD�4�D�DĈ�   LLLC<LLLLL��   DDD�34�����H�   DLLC3<LLLLL8�  DD�C33�����3�  LLLC33<LLLL3�  DD�333<����3�  DLL333�L�LL3�  DD�33<����33�  LLL3LLL���33�  DDD3��<���33�   DLLC<C<L�L38�   DD4333<����Ȁ   L3333<LLC<�    D3333<���4�     L3333<L<C0      333�3�43        C33L3<L0         DC4D�@           LLL@                                                                      Stretch	Transparent	  TPanelPanel5Left�TopWidthHeightCaptionPanel5Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameSystem
Font.StylefsBold 
ParentFontTabOrder  TLabelLabel25LeftTopWidthHeightAlignalClient	AlignmenttaCenterCaptionXFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontLayouttlCenter    	TConfirma	Confirma2Left� TopbWidthbHeightCaption
&ConfirmarFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderOnClickConfirma2Click
Glyph.Data
�  �  BM�      v   (   $            h                      �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  333333333333�33333  334C33333338�33333  33B$3333333�8�3333  34""C33333833�3333  3B""$33333�338�333  4"*""C3338�8�3�333  2"��"C3338�3�333  :*3:"$3338�38�8�33  3�33�"C333�33�3�33  3333:"$3333338�8�3  33333�"C333333�3�3  33333:"$3333338�8�  333333�"C333333�3�  333333:"C3333338�  3333333�#3333333��  3333333:3333333383  333333333333333333  	NumGlyphs  TMemoEdtObservacaoLeftTop!Width�Height9	MaxLength� 
ScrollBars
ssVerticalTabOrderOnExitEdtObservacaoExit   TDataSourcedsTaxasAutoEditDataSetrxTaxasEnabledLeftTop>  TDataSourcedsTaxasSobreAutoEditDataSetrxTaxasSobreLeft,Top>  
TPopupMenuPopMenu1OnChangePopMenu1ChangeOnPopupPopMenu1PopupLeftqTop> 	TMenuItem
popAlterarActionactAlterarTaxa  	TMenuItem
popExcluirActionactExcluirTaxa  	TMenuItem
popIncluirActionactIncluirTaxa  	TMenuItem
ObservacaoCaption   ObservaçãoShortCutO@OnClickObservacaoClick   TQueryqryTaxasDatabaseNameDbBGMLeftTop�   TQueryqrySobreDatabaseNameDbBGMLeft+Top�   TRxMemoryDatamdtLog	FieldDefs LeftMTop�  TStringFieldmdtLogCODTAXAS	FieldNameCODTAXASSize  TStringFieldmdtLogDescricao	FieldName	DescricaoSize(  TStringFieldmdtLogSobreValor	FieldName
SobreValorSize  TStringFieldmdtLogPendente	FieldNamePendenteSize  TStringFieldmdtLogReferencia	FieldName
ReferenciaSize  TFloatFieldmdtLogQtdMin	FieldNameQtdMin  TFloatFieldmdtLogQtdSolic	FieldNameQtdSolic  TFloatFieldmdtLogValorMin	FieldNameValorMin  TFloatFieldmdtLogValor	FieldNameValor  TStringFieldmdtLogDiaria	FieldNameDiariaSize   TQueryqryReferenciaDatabaseNameDbBGMLeft�Top  TDataSourcedsReferenciaDataSetqryReferenciaLeft!Top  TActionListActionList1LeftpTop�  TActionactIncluirTaxaCategoryTaxasCaptionIncluirShortCutI@	OnExecuteactIncluirTaxaExecute  TActionactAlterarTaxaCategoryTaxasCaptionAlterarShortCutA@	OnExecuteactAlterarTaxaExecute  TActionactGravarTaxaCategoryTaxas	OnExecuteactGravarTaxaExecute  TActionactExcluirTaxaCategoryTaxasCaptionExcluirShortCutE@	OnExecuteactExcluirTaxaExecute  TActionactGravarSobreCategoryTaxas	OnExecuteactGravarSobreExecute  TActionactAlterarSobreCategoryTaxasCaptionAlterarShortCutA@	OnExecuteactAlterarSobreExecute  TActionactIncluirSobreCategoryTaxasCaptionIncluirHintIncluirShortCutI@	OnExecuteactIncluirSobreExecute   TRxMemoryDatarxTaxasSobre	FieldDefs 	AfterOpenrxTaxasAfterOpen
BeforePostrxTaxasSobreBeforePost	AfterPostrxTaxasAfterPostAfterDeleterxTaxasAfterPostOnFilterRecordrxTaxasSobreFilterRecordLeft� Top>  TRxMemoryDatarxTaxas	FieldDefs 	AfterOpenrxTaxasAfterOpen	AfterPostrxTaxasAfterPostAfterScrollrxTaxasAfterScrollLeft� Top>  TRxMemoryData	rxTaxasNE	FieldDefs AfterDeleterxTaxasAfterPostLeft� Top>  TDataSource	dsTaxasNEAutoEditDataSet	rxTaxasNEEnabledLeftQTop>  TQueryqryTipoDatabaseNameDbBGMLeft�TopK  TDataSourcedsTipoDataSetqryTipoLeftTopI  
TPopupMenupmSobreOnPopupPopMenu1PopupLeft� Top> 	TMenuItempmSobreAlterarActionactAlterarSobre  	TMenuItem	MenuItem2ActionactExcluirTaxa  	TMenuItem	MenuItem3ActionactIncluirSobre   TRxMemoryDatarxTaxasSobreNE	FieldDefs 	AfterOpenrxTaxasAfterOpen
BeforePostrxTaxasSobreBeforePostOnFilterRecordrxTaxasSobreFilterRecordLeft� Top�   TDataSourcedsTaxasSobre2AutoEditDataSetrxTaxasSobreLeft� Top�   TRxMemoryDatarxTemp	FieldDefs Left� Top�  TStringFieldStringField1	FieldNameCODTAXASSize  TStringFieldStringField2	FieldName	DescricaoSize(  TStringFieldStringField3	FieldName
SobreValorSize  TStringFieldStringField4	FieldNamePendenteSize  TStringFieldStringField5	FieldName
ReferenciaSize  TFloatFieldFloatField1	FieldNameQtdMin  TFloatFieldFloatField2	FieldNameQtdSolic  TFloatFieldFloatField3	FieldNameValorMin  TFloatFieldFloatField4	FieldNameValor  TStringFieldStringField6	FieldNameDiariaSize   
TPopupMenu	popSobre2OnPopupPopMenu1PopupLeft+Top> 	TMenuItem	MenuItem4ActionactExcluirTaxa   TRxMemoryDataRxComparaTaxas	FieldDefs Left� Top�   TRxMemoryDataRxComparaSobre	FieldDefs Left	Top�   TRxMemoryDatarxComparaLog	FieldDefs Left$Top�   TQueryQuery1DatabaseNameDbBGMLeftHTop�   TRxMemoryDataMDConvTaxas	FieldDefs LeftHTop> TIntegerFieldMDConvTaxasCODTAXAS	FieldNameCODTAXAS  TFloatFieldMDConvTaxasVALORINDICE	FieldNameVALORINDICE  TStringFieldMDConvTaxasCONVVALOR	FieldName	CONVVALORSize  TStringFieldMDConvTaxasCONVVLRMINIMO	FieldNameCONVVLRMINIMOSize    