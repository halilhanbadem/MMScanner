object frmDemo: TfrmDemo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MMScanner Demo - developer by Halil Han Badem'
  ClientHeight = 174
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 52
    Height = 14
    Caption = 'Hasta T.C:'
  end
  object Label2: TLabel
    Left = 8
    Top = 57
    Width = 83
    Height = 14
    Caption = 'Hasta Do'#287'um Y'#305'l'#305':'
  end
  object btnErisimNo: TButton
    Left = 8
    Top = 99
    Width = 121
    Height = 26
    Caption = 'Eri'#351'im No Al'
    TabOrder = 0
    OnClick = btnErisimNoClick
  end
  object btnSonucGetir: TButton
    Left = 8
    Top = 130
    Width = 121
    Height = 26
    Caption = 'Sonu'#231' Getir'
    TabOrder = 1
    OnClick = btnSonucGetirClick
  end
  object edtTC: TEdit
    Left = 8
    Top = 30
    Width = 248
    Height = 22
    NumbersOnly = True
    TabOrder = 2
  end
  object edtDogumYili: TEdit
    Left = 8
    Top = 72
    Width = 248
    Height = 22
    NumbersOnly = True
    TabOrder = 3
  end
  object btnSetBrowser: TButton
    Left = 135
    Top = 99
    Width = 121
    Height = 26
    Caption = 'setBrowser'
    TabOrder = 4
    OnClick = btnSetBrowserClick
  end
  object btnResetBrowser: TButton
    Left = 135
    Top = 130
    Width = 121
    Height = 26
    Caption = 'resetBrowser'
    TabOrder = 5
    OnClick = btnResetBrowserClick
  end
end
