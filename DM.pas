unit DM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDM1 = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    ADOTable1識別碼: TAutoIncField;
    ADOTable1圖層名稱: TWideStringField;
    ADOTable1圖層ID: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM1: TDM1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM1.DataModuleCreate(Sender: TObject);
begin
  ADOConnection1.Connected:= True;
  ADOTable1.Active:= True;
end;

end.
