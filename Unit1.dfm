object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'DLL Explorer'
  ClientHeight = 337
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    527
    337)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 8
    Width = 129
    Height = 25
    Caption = 'Open DLL file...'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 39
    Width = 489
    Height = 282
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Dll file [*.dll]|*.dll'
    Left = 368
    Top = 80
  end
end
