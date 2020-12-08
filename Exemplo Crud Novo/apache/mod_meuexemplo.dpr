library mod_meuexemplo;

uses
  {$IFDEF MSWINDOWS}
  Winapi.ActiveX,
  {$ENDIF }
  Web.WebBroker,
  Web.ApacheApp,
  Web.HTTPD24Impl,
  ProdutosClass in '..\ProdutosClass.pas',
  ProdutosService in '..\ProdutosService.pas',
  UMyController in '..\UMyController.pas',
  UMyWebModule in '..\UMyWebModule.pas' {MyWebModule: TWebModule},
  UPoolConnection in '..\UPoolConnection.pas';

{$R *.res}

// httpd.conf entries:
//
(*
 LoadModule meuexemplo_module modules/mod_meuexemplo.dll

 <Location /xyz>
    SetHandler mod_meuexemplo-handler
 </Location>
*)
//
// These entries assume that the output directory for this project is the apache/modules directory.
//
// httpd.conf entries should be different if the project is changed in these ways:
//   1. The TApacheModuleData variable name is changed.
//   2. The project is renamed.
//   3. The output directory is not the apache/modules directory.
//   4. The dynamic library extension depends on a platform. Use .dll on Windows and .so on Linux.
//

// Declare exported variable so that Apache can access this module.
var
  GModuleData: TApacheModuleData;
exports
  GModuleData name 'meuexemplo_module';

begin
{$IFDEF MSWINDOWS}
  //CoInitFlags := COINIT_MULTITHREADED;
{$ENDIF}
  Web.ApacheApp.InitApplication(@GModuleData);
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
