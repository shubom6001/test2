program WMS;

uses
  Vcl.Forms,
  WinAPI.Windows,
  Unit2 in 'Unit2.pas' {Form2},
  DM in 'DM.pas' {DM1: TDataModule};

{$R *.res}
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
