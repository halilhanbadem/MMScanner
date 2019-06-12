{
  The author of this library is Halil Han Badem.
  Please do not change this information without permission.
  This file is free of charge to the developers of Developers :).

  Build Delphi IDE: Delphi 10.3
  Developer by: Halil Han Badem

  Instagram: https://instagram.com/halilhanbadem.pas
  Facebook: https://facebook.com/halilhanbadem
  Twitter: https://twitter.com/halilhanbadem
  Github: https://github.com/halilhanbadem
  Website: https://halilhanbadem.com
  Udemy Delphi Education: https://udemy.com/sifirdan-delphi-ogrenin
}

{
  Warning!!!

  If you own, the paid deploy is strictly prohibited.
  These libraries are distributed free of charge. If you want to support me, please donate through the site! I'd be happy if you donated.

  Uyarý!!!

  Sahiplenmek, ücretli daðýtmak kesinlikle yasaktýr.
  Bu kütüphaneler ücretsiz olarak daðýtýlmaktadýr. Bana destek olmak istiyorsanýz lütfen site üzerinden baðýþ yapýn! Baðýþ yaparsanýz mutlu olurum.

  Donate web site: https://halilhanbadem.com
  Baðýþ web site: https://halilhanbadem.com
}
unit usesMMScanner;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils,
  System.Variants,
  Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, MSHTML, Vcl.ExtCtrls,
  Vcl.CheckLst, Vcl.Forms, Vcl.Graphics, Vcl.Controls, Vcl.Dialogs;

type
  TMMScanner = class
    constructor Create(BrowserParent: TForm; const BrowserTop, BrowserLeft,
      BrowserHeight, BrowserWidth: Integer); overload;
    procedure FreeBrowser;
    function ErisimNo(TC, DogumYili: string): string;
    function getResult(TC, DogumYili: string): string;
    procedure resetBrowser;
    procedure setBrowser(setHeight, setWidth, setLeft, setTop: integer);
  private
    MMBrowser: TWebBrowser;
    function Parse(Text, Sol, Sag: string): String;
    procedure Waiting(iMilliSeconds: Integer);
  public

  end;

resourcestring
  urlErisimNo = 'https://mmtarama.saglik.gov.tr/randevu/erisim-no-ogren';
  urlSonuc = 'https://mmtarama.saglik.gov.tr/randevu/mamografi-sonuc-sorgula';

var
  MMScanner: TMMScanner;

implementation

{ TMMScanner }

constructor TMMScanner.Create(BrowserParent: TForm;
  const BrowserTop, BrowserLeft, BrowserHeight, BrowserWidth: Integer);
begin
  MMBrowser := TWebBrowser.Create(nil);
  TWinControl(MMBrowser).Parent := BrowserParent;
  MMBrowser.Silent := True;
  MMBrowser.RegisterAsBrowser := True;
  MMBrowser.HandleNeeded;
  MMBrowser.Height := BrowserHeight;
  MMBrowser.Width := BrowserWidth;
  MMBrowser.Left := BrowserLeft;
  MMBrowser.Top := BrowserTop;
  MMBrowser.Navigate(urlErisimNo);
end;


function TMMScanner.ErisimNo(TC, DogumYili: string): string;
var
  _ErisimNo: String;
begin
  Result := 'Eriþim no alýnamadý!';
  if MMBrowser.LocationURL = 'https://mmtarama.saglik.gov.tr/randevu/erisim-no-ogren'
  then
  begin
    while MMBrowser.ReadyState <> READYSTATE_COMPLETE do
    begin
      Application.ProcessMessages;
    end;

    MMBrowser.OleObject.document.getElementByID
      ('MamoFront_Mammography_AskForAccessionNumberPanel0_PatientTrId').click;
    MMBrowser.OleObject.document.getElementByID
      ('MamoFront_Mammography_AskForAccessionNumberPanel0_PatientTrId')
      .value := TC;
    MMBrowser.OleObject.document.getElementByID
      ('MamoFront_Mammography_AskForAccessionNumberPanel0_DobYear').click;
    MMBrowser.OleObject.document.getElementByID
      ('MamoFront_Mammography_AskForAccessionNumberPanel0_DobYear').value :=
      DogumYili;
    MMBrowser.OleObject.document.getElementByID
      ('MamoFront_Mammography_AskForAccessionNumberPanel0_Button').click;
  end;

  while MMBrowser.ReadyState <> READYSTATE_COMPLETE do
  begin
    Application.ProcessMessages;
  end;

  Waiting(1500);

  if MMBrowser.LocationURL = 'https://mmtarama.saglik.gov.tr/randevu/erisim/' +
    TC + '/' + DogumYili then
  begin
    _ErisimNo := MMBrowser.OleObject.document.getElementsByClassName('box-body')
      .item(0).innerText;;
    Result := Trim(Parse(_ErisimNo, 'Eriþim No : ', 'TC'));
  end;
end;

procedure TMMScanner.FreeBrowser;
begin
  FreeAndNil(MMBrowser);
end;

function TMMScanner.getResult(TC, DogumYili: string): string;
var
  _ErisimNo: String;
begin
  _ErisimNo := ErisimNo(TC, DogumYili);

  if _ErisimNo = 'Eriþim no alýnamadý!' then
  begin
    ShowMessage('Eriþim no alýnamadýðý için iþleminiz gerçekletirilemedi!');
    exit;
  end;

  Waiting(1500);

  MMBrowser.Navigate(urlSonuc);

  while MMBrowser.ReadyState <> READYSTATE_COMPLETE do
  begin
    Application.ProcessMessages;
  end;

  MMBrowser.OleObject.document.getElementByID
    ('MamoFront_Mammography_AskForMammographyResultPanel0_AccessionNumber')
    .click;
  MMBrowser.OleObject.document.getElementByID
    ('MamoFront_Mammography_AskForMammographyResultPanel0_AccessionNumber')
    .value := _ErisimNo;
  MMBrowser.OleObject.document.getElementByID
    ('MamoFront_Mammography_AskForMammographyResultPanel0_PatientTrId').click;
  MMBrowser.OleObject.document.getElementByID
    ('MamoFront_Mammography_AskForMammographyResultPanel0_PatientTrId')
    .value := TC;
  MMBrowser.OleObject.document.getElementByID
    ('MamoFront_Mammography_AskForMammographyResultPanel0_UrlButton').click();

  while MMBrowser.ReadyState <> READYSTATE_COMPLETE do
  begin
    Application.ProcessMessages;
  end;

  Waiting(1500);

  Result := MMBrowser.OleObject.document.getElementsByClassName('col-xs-12')
    .item(6).innerText;
end;

function TMMScanner.Parse(Text, Sol, Sag: string): String;
begin
  Delete(Text, 1, Pos(Sol, Text) + Length(Sol) - 1);
  Result := Copy(Text, 1, Pos(Sag, Text) - 1);
end;

procedure TMMScanner.resetBrowser;
begin
  MMBrowser.Navigate(urlErisimNo);
end;

procedure TMMScanner.setBrowser(setHeight, setWidth, setLeft, setTop: integer);
begin
  MMBrowser.Height := setHeight;
  MMBrowser.Top := setTop;
  MMBrowser.Width := setWidth;
  MMBrowser.Left := setLeft;
end;

procedure TMMScanner.Waiting(iMilliSeconds: Integer);
var
  start: Integer;
begin
  start := GetTickCount;
  while (GetTickCount - start) < iMilliSeconds do
    Application.ProcessMessages;
end;

end.
