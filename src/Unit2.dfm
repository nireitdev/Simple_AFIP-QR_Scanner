object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'QR AFIP'
  ClientHeight = 477
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 377
    Width = 646
    Height = 100
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 646
    Height = 377
    Align = alTop
    TabOrder = 1
    object Image1: TImage
      Left = 8
      Top = 25
      Width = 361
      Height = 315
      Proportional = True
      Stretch = True
    end
    object Label1: TLabel
      Left = 8
      Top = 0
      Width = 73
      Height = 19
      Caption = 'AFIP QR '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button2: TButton
      Left = 196
      Top = 346
      Width = 173
      Height = 25
      Caption = 'Desactivar'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 8
      Top = 346
      Width = 173
      Height = 25
      Caption = 'Activar Video'
      TabOrder = 1
      OnClick = Button1Click
    end
    object TreeView1: TTreeView
      Left = 375
      Top = 25
      Width = 258
      Height = 346
      AutoExpand = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Indent = 19
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
    end
  end
end
