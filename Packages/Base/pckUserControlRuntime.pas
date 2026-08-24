{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit pckUserControlRuntime;

{$warn 5023 off : no warning about unused units}
interface

uses
  TrocaSenha_U, UCBase, SenhaForm_U, EnvMsgForm_U, MsgRecForm_U, MsgsForm_U, 
  UCDataInfo, UCMessages, UserPermis_U, UCSettings, LoginWindow_U, 
  UcConsts_Language, pUCGeral, pUCFrame_User, pUCFrame_Profile, pUCFrame_Log, 
  pUcFrame_UserLogged, UCMail, UCEMailForm_U, IncUser_U, IncPerfil_U, UCmd5, 
  UCObjSel_U, UCMailTransport, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('pckUserControlRuntime', @Register);
end.
