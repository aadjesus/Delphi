program Contas;

uses
  Forms,
  CNTPrincipal in 'CNTPrincipal.pas' {CNTFormPricipal},
  CNTPesquisaUsuario in 'CNTPesquisaUsuario.pas' {CNTFormPesquisaUsuario},
  CNTHistorico in 'CNTHistorico.pas' {CNTFormHistorico},
  CNTDataModuleContas in 'CNTDataModuleContas.pas' {DMContas: TDataModule},
  CNTPesquisaHistorico in 'CNTPesquisaHistorico.pas' {CNTFormPesquisaHistorico},
  CNTInclusao in 'CNTInclusao.pas' {CNTMovDigIclusao},
  CNTListagemCadastros in 'CNTListagemCadastros.pas' {CNTFormListagemCadastro},
  CNTUsuarios in 'CNTUsuarios.pas' {CNTFormUsuario},
  CNTApresentacao in 'CNTApresentacao.pas' {CNTFormApresentacao};
{$R *.RES}

Var
  CNTFormApresentacao: TCNTFormApresentacao;

begin
  Application.Initialize;
  CNTFormApresentacao := TCNTFormApresentacao.Create(Application);
  CNTFormApresentacao.Show;
  CNTFormApresentacao.Update;

  Application.CreateForm(TCNTFormPricipal, CNTFormPricipal);
  Application.CreateForm(TDMContas, DMContas);
  Application.CreateForm(TCNTFormPesquisaUsuario, CNTFormPesquisaUsuario);
  Application.CreateForm(TCNTFormHistorico, CNTFormHistorico);
  Application.CreateForm(TCNTFormPesquisaHistorico, CNTFormPesquisaHistorico);
  Application.CreateForm(TCNTMovDigIclusao, CNTMovDigIclusao);
  Application.CreateForm(TCNTFormListagemCadastro, CNTFormListagemCadastro);
  Application.CreateForm(TCNTFormUsuario, CNTFormUsuario);
  CNTFormApresentacao.Close;
  CNTFormApresentacao.Free;
  Application.Run;

end.


{
Var
  CNTFormApresentacao: TCNTFormApresentacao;

begin
  Application.Initialize;
  CNTFormApresentacao := TCNTFormApresentacao.Create(Application);
  CNTFormApresentacao.Show;
  CNTFormApresentacao.Update;

  Application.CreateForm(TMscFormTelaPrincipal, MscFormTelaPrincipal);
  CNTFormApresentacao.Close;
  CNTFormApresentacao.Free;
  Application.Run;
end.

}
