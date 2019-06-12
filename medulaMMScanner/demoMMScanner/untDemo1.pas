unit untDemo1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, usesMMScanner, Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TfrmDemo = class(TForm)
    btnErisimNo: TButton;
    btnSonucGetir: TButton;
    edtTC: TEdit;
    edtDogumYili: TEdit;
    btnSetBrowser: TButton;
    btnResetBrowser: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnErisimNoClick(Sender: TObject);
    function Kontrol: boolean;
    procedure btnSonucGetirClick(Sender: TObject);
    procedure btnSetBrowserClick(Sender: TObject);
    procedure btnResetBrowserClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure buttonReaksiyon(param: boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDemo: TfrmDemo;
  MMScanner: TMMScanner;

implementation

{$R *.dfm}

procedure TfrmDemo.btnErisimNoClick(Sender: TObject);
begin
  try
    buttonReaksiyon(False);
    btnErisimNo.Caption := 'Lütfen bekleyin!';
    if not Kontrol then
    begin
      exit;
    end;

    MessageBox(handle,
      pChar(edtTC.Text + ' kimlik numaralý hastanýn eriþim numarasý: ' +
      MMScanner.ErisimNo(edtTC.Text, edtDogumYili.Text)), 'Eriþim No',
      MB_OK + MB_ICONINFORMATION);
  finally
    buttonReaksiyon(True);
    btnErisimNo.Caption := 'Eriþim No Al';
  end;
end;

procedure TfrmDemo.btnResetBrowserClick(Sender: TObject);
begin
  MMScanner.resetBrowser;
end;

procedure TfrmDemo.btnSetBrowserClick(Sender: TObject);
begin
  MMScanner.setBrowser(126, 343, 312, 30);
  /// change
end;

procedure TfrmDemo.btnSonucGetirClick(Sender: TObject);
begin
  try
    buttonReaksiyon(False);
    btnSonucGetir.Caption := 'Lütfen bekleyin!';
    if not Kontrol then
    begin
      exit;
    end;

    MessageBox(handle,
      pChar(edtTC.Text + ' kimlik numaralý hastanýn MM sonucu: ' +
      MMScanner.getResult(edtTC.Text, edtDogumYili.Text)), 'Sonuç',
      MB_OK + MB_ICONINFORMATION);
  finally
    buttonReaksiyon(True);
    btnSonucGetir.Caption := 'Sonuç Getir';
  end;
end;

procedure TfrmDemo.buttonReaksiyon(param: boolean);
begin
  if not param then
  begin
    btnErisimNo.Enabled := False;
    btnSonucGetir.Enabled := False;
    btnSetBrowser.Enabled := False;
    btnResetBrowser.Enabled := False;
  end
  else if param then
  begin
    btnErisimNo.Enabled := True;
    btnSonucGetir.Enabled := True;
    btnSetBrowser.Enabled := True;
    btnResetBrowser.Enabled := True;
  end;
end;

procedure TfrmDemo.FormCreate(Sender: TObject);
begin
  MMScanner := TMMScanner.Create(Self, 0, 0, 0, 0);
end;

procedure TfrmDemo.FormDestroy(Sender: TObject);
begin
 MMScanner.FreeBrowser;
end;

function TfrmDemo.Kontrol: boolean;
begin
  if (trim(edtTC.Text) = '') or (trim(edtDogumYili.Text) = '') or
    (Length(edtTC.Text) < 11) then
  begin
    MessageBox(handle,
      'T.C Kimlik numarasý hatalý/eksik veya doðum yýlý eksik girilmiþ!',
      'Eksik!', MB_OK + MB_ICONERROR);
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

end.
