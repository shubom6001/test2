unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls,
  Vcl.ExtCtrls, JPEG, Vcl.ComCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient, Vcl.Buttons, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, ActiveX, Math;

type
  TForm2 = class(TForm)
    IdHTTP1: TIdHTTP;
    Panel1: TPanel;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    WebBrowser1: TWebBrowser;
    Panel3: TPanel;
    btnWMS: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnWMSClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetUrlPicture(Url, savePicture: string);
    procedure GetMMS5(圖層ID, sPicture: string;
      Box1X, Box1Y, Box2X, Box2Y: double; iWidth, iHeight: integer;
      var sUrl: string);
    procedure Zoom(iZoom: double);
  end;

var
  Form2: TForm2;

implementation

uses DM;

{$R *.dfm}

Const
  a = 6378137.0;
  b = 6356752.314245;
  k0 = 0.9999;
  dx = 250000; // int;
  Central_meridian: double = 121; // 中央經線 中央子午線/ BasAng

  sPicture = 'z:\1.jpg';
  x1 = 301790.125000;
  y1 = 2778309.875000;
  iWidth = 800;
  iHeight = 600;
  iZoom:double =1;

Function lon0: double;
begin
  Result := Central_meridian * Pi / 180;
end;

// private string Cal_lonlat_To_twd97(double lon ,double lat)
// private string Cal_TWD97_To_lonlat(double x, double y)
procedure Cal_TWD97_To_lonlat(x, y: double; Var lat, lon: double);
Var
  Dy, e, M, mu, e1, J1, J2, J3, J4, fp, e2, C1, T1, R1, N1, D, Q1, Q2, Q3, Q4,
    Q5, Q6, Q7: double;
Begin
  Dy := 0;
  e := Power((1 - Power(b, 2) / Power(a, 2)), 0.5);
  x := x - dx;
  y := y - Dy;

  // Calculate the Meridional Arc
  M := y / k0;

  // Calculate Footprint Latitude
  mu := M / (a * (1.0 - Power(e, 2) / 4.0 - 3 * Power(e, 4) / 64.0 - 5 *
    Power(e, 6) / 256.0));
  e1 := (1.0 - Power((1.0 - Power(e, 2)), 0.5)) /
    (1.0 + Power((1.0 - Power(e, 2)), 0.5));

  J1 := (3 * e1 / 2 - 27 * Power(e1, 3) / 32.0);
  J2 := (21 * Power(e1, 2) / 16 - 55 * Power(e1, 4) / 32.0);
  J3 := (151 * Power(e1, 3) / 96.0);
  J4 := (1097 * Power(e1, 4) / 512.0);

  fp := mu + J1 * Sin(2 * mu) + J2 * Sin(4 * mu) + J3 * Sin(6 * mu) + J4 *
    Sin(8 * mu);

  // Calculate Latitude and Longitude

  e2 := Power((e * a / b), 2);
  C1 := Power(e2 * Cos(fp), 2);
  T1 := Power(Tan(fp), 2);
  R1 := a * (1 - Power(e, 2)) / Power((1 - Power(e, 2) * Power(Sin(fp), 2)),
    (3.0 / 2.0));
  N1 := a / Power((1 - Power(e, 2) * Power(Sin(fp), 2)), 0.5);

  D := x / (N1 * k0);

  // 計算緯度
  Q1 := N1 * Tan(fp) / R1;
  Q2 := (Power(D, 2) / 2.0);
  Q3 := (5 + 3 * T1 + 10 * C1 - 4 * Power(C1, 2) - 9 * e2) * Power(D, 4) / 24.0;
  Q4 := (61 + 90 * T1 + 298 * C1 + 45 * Power(T1, 2) - 3 * Power(C1, 2) - 252 *
    e2) * Power(D, 6) / 720.0;
  lat := fp - Q1 * (Q2 - Q3 + Q4);

  // 計算經度
  Q5 := D;
  Q6 := (1 + 2 * T1 + C1) * Power(D, 3) / 6;
  Q7 := (5 - 2 * C1 + 28 * T1 - 3 * Power(C1, 2) + 8 * e2 + 24 * Power(T1, 2)) *
    Power(D, 5) / 120.0;
  lon := lon0 + (Q5 - Q6 + Q7) / Cos(fp);

  lat := (lat * 180) / Pi; // 緯  N-S
  lon := (lon * 180) / Pi; // 經  E-W

  // Result := Format('%10.9F,%10.9F',[lon,lat]);//
End;

procedure Cal_lonlat_To_twd97(lon, lat: double; Var x, y: double);
Var
  e, e2, n, nu, p, BA, BB, BC, BD, BE, S, k1, k2, k3, k4, k5: double;
Begin
  lon := (lon / 180) * Pi;
  lat := (lat / 180) * Pi;

  // ---------------------------------------------------------
  e := Power((1 - Power(b, 2) / Power(a, 2)), 0.5);
  e2 := Power(e, 2) / (1 - Power(e, 2));
  n := (a - b) / (a + b);
  nu := a / Power((1 - (Power(e, 2)) * (Power(Sin(lat), 2))), 0.5);
  p := lon - lon0;
  BA := a * (1 - n + (5 / 4) * (Power(n, 2) - Power(n, 3)) + (81 / 64) *
    (Power(n, 4) - Power(n, 5)));
  BB := (3 * a * n / 2.0) * (1 - n + (7 / 8.0) * (Power(n, 2) - Power(n, 3)) +
    (55 / 64.0) * (Power(n, 4) - Power(n, 5)));
  BC := (15 * a * (Power(n, 2)) / 16.0) *
    (1 - n + (3 / 4.0) * (Power(n, 2) - Power(n, 3)));
  BD := (35 * a * (Power(n, 3)) / 48.0) *
    (1 - n + (11 / 16.0) * (Power(n, 2) - Power(n, 3)));
  BE := (315 * a * (Power(n, 4)) / 51.0) * (1 - n);

  S := BA * lat - BB * Sin(2 * lat) + BC * Sin(4 * lat) - BD * Sin(6 * lat) + BE
    * Sin(8 * lat);

  // 計算Y值
  k1 := S * k0;
  k2 := k0 * nu * Sin(2 * lat) / 4.0;
  k3 := (k0 * nu * Sin(lat) * (Power(Cos(lat), 3)) / 24.0) *
    (5 - Power(Tan(lat), 2) + 9 * e2 * Power((Cos(lat)), 2) + 4 * (Power(e2, 2))
    * (Power(Cos(lat), 4)));
  y := k1 + k2 * (Power(p, 2)) + k3 * (Power(p, 4));

  // 計算X值
  k4 := k0 * nu * Cos(lat);
  k5 := (k0 * nu * (Power(Cos(lat), 3)) / 6.0) *
    (1 - Power(Tan(lat), 2) + e2 * (Power(Cos(lat), 2)));
  x := k4 * p + k5 * (Power(p, 3)) + dx;

  // Result := Format('%10.9F,%10.9F',[X,Y]);//x.ToString()+ "," + y.ToString();
End;
(* *
  procedure SaveJGW(sPicture: string; Box1X, Box1Y: double);
  var
  T: TStringList;
  jgw: string;
  begin
  T := TStringList.Create;
  { https://wms.nlsc.gov.tw/wms?LAYERS=EMAP15
  &FORMAT=image%2Fjpeg&REPROJECT=false&PROJECTION=EPSG%3A4326&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&SRS=EPSG%3A3826&BBOX=300150.125,2777069.875,301790.125,2779549.875&WIDTH=1640&HEIGHT=1240
  }
  T.Add('1.000000');
  T.Add('0.000000');
  T.Add('0.000000');
  T.Add('-1.000000');
  T.Add(format('%6.6f', [Box1X]));
  T.Add(format('%7.6f', [Box1Y]));
  jgw := ChangeFileExt(sPicture, '.jgw');
  T.SaveToFile(jgw);
  T.Free;
  end;

  * *)

procedure TForm2.Zoom(iZoom: double);
var
  圖層ID: string;
  iWidth, iHeight: integer;
  sUrl: string;
  x2, y2, x0, y0, DSzW,DSzH: double;
begin

(*  iWidth:= 400;
  iHeight:= 300;

  dm1.ADOTable1.Locate('圖層名稱', ComboBox1.Items[ComboBox1.ItemIndex], []);
  圖層ID := dm1.ADOTable1.FieldByName('圖層ID').AsString;

  x2 := x1 - iWidth;
  y2 := y1 - iHeight;

  iWidth := Trunc(iWidth * iZoom);
  iHeight := Trunc(iHeight * iZoom);


  GetMMS5(圖層ID, sPicture, x1, y1, x2, y2, iWidth, iHeight, sUrl);
  *)
  iWidth:= 800;
  iHeight:= 600;

  dm1.ADOTable1.Locate('圖層名稱', ComboBox1.Items[ComboBox1.ItemIndex], []);
  圖層ID := dm1.ADOTable1.FieldByName('圖層ID').AsString;

  DSzH:=iHeight * iZoom;
  DSzW:=iHeight * iZoom;
  x0 := x1 - DSzW;
  y0 := y1 - DSzH;
  x2 := x1 + DSzW;
  y2 := y1 + DSzH;

  //iWidth := Trunc(iWidth * iZoom);
//  iHeight := Trunc(iHeight * iZoom);


  GetMMS5(圖層ID, sPicture, x1, y1, x2, y2, iWidth, iHeight, sUrl);

end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  iZoom:= iZoom / 2;
  Zoom(iZoom);
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
  iZoom:= iZoom * 2;
  Zoom(iZoom);
end;

procedure TForm2.btnWMSClick(Sender: TObject);
begin
  Zoom(1);
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  i: integer;
  S: string;
begin
  ComboBox1.Clear;
  with dm1.ADOTable1 do
  begin
    first;
    while not Eof do
    begin
      S := FieldByName('圖層名稱').AsString;
      ComboBox1.Items.Add(S);
      next;
    end;
  end;
  ComboBox1.ItemIndex := 0;

end;

procedure TForm2.GetUrlPicture(Url, savePicture: string);
var
  MS: TMemoryStream;
  JPEG: TJPEGImage;
begin
  MS := TMemoryStream.Create;
  JPEG := TJPEGImage.Create;
  try
    IdHTTP1.Get(Url, MS);
    MS.SaveToFile(savePicture);
  finally
    JPEG.Free;
    MS.Free;
  end;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  S: string;
begin
  S := 'https://wms.nlsc.gov.tw/wms?LAYERS=EMAP15&FORMAT=image%2Fjpeg&REPROJECT=false&PROJECTION=EPSG%3A3826&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&SRS=EPSG%3A3826&BBOX=301790.125000,2778309.875000,305070.125000,2780789.875000&WIDTH=3280&HEIGHT=2480';
  WebBrowser1.Navigate(S);
end;

procedure TForm2.GetMMS5(圖層ID, sPicture: string;
  Box1X, Box1Y, Box2X, Box2Y: double; iWidth, iHeight: integer;
  var sUrl: string);
var
  S, s1, s2, s3, jgw: string;
  lat1, lon1, lat2, lon2, k1, k2: double;
  T: TStringList;
begin

  { https://wms.nlsc.gov.tw/wms?LAYERS=EMAP15
    &FORMAT=image%2Fjpeg&REPROJECT=false&PROJECTION=EPSG%3A4326&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&SRS=EPSG%3A3826&BBOX=300150.125,2777069.875,301790.125,2779549.875&WIDTH=1640&HEIGHT=1240
  }

  S := format('https://wms.nlsc.gov.tw/wms?LAYERS=%s', [圖層ID]);
  s1 := '&FORMAT=image%2Fjpeg&REPROJECT=false&PROJECTION=EPSG%3A3826&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&SRS=EPSG%3A3826';

  s2 := format('&BBOX=%6.6f,%7.6f,%6.6f,%7.6f', [Box1X, Box1Y, Box2X, Box2Y]);
  s3 := format('&WIDTH=%d&HEIGHT=%d', [iWidth, iHeight]);
  // [1600,1200]);

  sUrl := S + s1 + s2 + s3;
  WebBrowser1.Navigate(sUrl);
  GetUrlPicture(sUrl, sPicture);

  T := TStringList.Create;
  try
    T.Add(sUrl);
    T.SaveToFile('Z:\1.TXT');
  finally
    T.Free;
  end;

end;

end.
