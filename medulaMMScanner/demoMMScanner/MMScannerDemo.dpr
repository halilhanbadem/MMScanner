program MMScannerDemo;

uses
  Vcl.Forms,
  untDemo1 in 'untDemo1.pas' {frmDemo},
  usesMMScanner in '..\uses_MMScanner\usesMMScanner.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDemo, frmDemo);
  Application.Run;
end.
