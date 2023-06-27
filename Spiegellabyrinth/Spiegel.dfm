object SiegelGolf: TSiegelGolf
  Left = 192
  Top = 124
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'SpiegelGolf  '#169' Fiete   Anno 2023   -  Schwierigkeit  leicht'
  ClientHeight = 620
  ClientWidth = 836
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF
    FFFFFFFFFFF88FFFFFFFF7000007FFFFFFFFFFFFFF2227FFFFFFF7000000FFFF
    FFFFFFFFF722228FFFFFF7000000FFFFFFFFFFFFF222227FFFFFF7000000FFFF
    FFFFFFFFF722228FFFFFF7000000FFFFFFFFFFFFFF7227FFFFFFF70000007777
    778FFFFFFFFFFFFFFFFFF70000070000008FFFFFFFFFFFFFFFFFF70000000000
    008FFFFFFFFFFFFFFFFFF70000000000008FFFFFFFFFFFFFFFFFF70000000000
    008FFFFFFFFFFFFFFFFFF70000000000008FFFFFFFFFFFFFFFFFF70000000000
    008FFFFFFFFFFFFFFFFFF7000007FF778FFFFFFFFFFFFFFFFFFFFFFFFFFFF222
    28FFFFFFFFFFFFFFFFFFFFFFFFFF722227FFFFFFFFFFFFFFFFFFFFFFFFFF7222
    22FFFFFFFFFFFFFFFFFFFFFFFFFF822228FFFFFFFFFFFFFFFFFFFFFFFFFFF872
    7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8888888FFFFFF8888888FFFF
    FFFFFFFF8000000FFFFFF7000000FFFFFFFFFFFF8000000FFFFFF7000000FFFF
    FFFFFFFF8000000FFFFFF7000000FFFFFFFFFFFF8000000FFFFFF7000000FFFF
    FFFFFFFF8000000FFFFFF7000000FFFFFFFFFFFF8000000FFFFFF70000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object LabelFG: TLabel
    Left = 16
    Top = 22
    Width = 76
    Height = 16
    Caption = 'Seitenl'#228'nge'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelStufe: TLabel
    Left = 112
    Top = 284
    Width = 35
    Height = 16
    Cursor = crHelp
    Hint = 'es gibt drei Stufen'
    Caption = 'Stufe'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object LabelInfo: TLabel
    Left = 280
    Top = 16
    Width = 553
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Ausgabe: TDrawGrid
    Left = 268
    Top = 48
    Width = 554
    Height = 554
    Cursor = crHandPoint
    DefaultColWidth = 108
    DefaultRowHeight = 108
    Enabled = False
    FixedCols = 0
    FixedRows = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    GridLineWidth = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = AusgabeDrawCell
  end
  object SpinEditG: TSpinEdit
    Left = 100
    Top = 18
    Width = 41
    Height = 26
    Cursor = crHandPoint
    Hint = 'Gr'#246#223'e 4 bis 12'
    EditorEnabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Increment = 2
    MaxLength = 2
    MaxValue = 12
    MinValue = 4
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 6
    OnChange = SpinEditGChange
  end
  object ButtonNT: TButton
    Left = 56
    Top = 60
    Width = 145
    Height = 26
    Cursor = crHandPoint
    Hint = 'neue Stellung'
    Caption = 'neue Aufgabe'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = ButtonNTClick
  end
  object BarWahl: TScrollBar
    Left = 16
    Top = 308
    Width = 234
    Height = 20
    Cursor = crCross
    Hint = 'Schwierigkeit leicht'
    LargeChange = 50
    PageSize = 0
    ParentShowHint = False
    Position = 50
    ShowHint = True
    SmallChange = 50
    TabOrder = 3
    OnChange = BarWahlChange
  end
  object Hinweise: TMemo
    Left = 16
    Top = 344
    Width = 234
    Height = 256
    Cursor = crHandPoint
    Hint = 'Anleitung'
    TabStop = False
    Alignment = taCenter
    BorderStyle = bsNone
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      'Du musst die gr'#252'ne und rote Kugel'
      'einlochen. Die Steuerung erfolgt '
      'mittels der Richtungspfeile.'
      ''
      'F'#252'r den Spielabbruch ist der'
      'mittlere Button zu benutzen.'
      ''
      'Die Kugeln bewegen sich BEIDE'
      'gleichzeitig. Die gr'#252'ne in die'
      'gew'#228'hlte Richtung, die rote in'
      'die entgegengesetzte!'
      'Die Hindernisse k'#246'nnen beim L'#246'sen'
      'hilfreich sein!'
      ''
      'Die Anzahl der Hindernisse '
      'ergibt sich aus der Seitenl'#228'nge.')
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 4
  end
  object BBRechts: TBitBtn
    Left = 142
    Top = 232
    Width = 25
    Height = 22
    Cursor = crHandPoint
    Hint = 'gr'#252'n nach rechts, rot nach links'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BBRechtsClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333FFF333333333333000333333333
      3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
      3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
      0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
      BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
      33337777773FF733333333333300033333333333337773333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BBLinks: TBitBtn
    Left = 93
    Top = 232
    Width = 25
    Height = 22
    Cursor = crHandPoint
    Hint = 'gr'#252'n nach links, rot nach rechts'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = BBLinksClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333333333333333333333333333333333333333333FF333333333333
      3000333333FFFFF3F77733333000003000B033333777773777F733330BFBFB00
      E00033337FFF3377F7773333000FBFB0E000333377733337F7773330FBFBFBF0
      E00033F7FFFF3337F7773000000FBFB0E000377777733337F7770BFBFBFBFBF0
      E00073FFFFFFFF37F777300000000FB0E000377777777337F7773333330BFB00
      000033333373FF77777733333330003333333333333777333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BBRunter: TBitBtn
    Left = 119
    Top = 256
    Width = 25
    Height = 22
    Cursor = crHandPoint
    Hint = 'gr'#252'n nach unten, rot nach oben'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = BBRunterClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
      33333333373F33333333333330B03333333333337F7F33333333333330F03333
      333333337F7FF3333333333330B00333333333337F773FF33333333330F0F003
      333333337F7F773F3333333330B0B0B0333333337F7F7F7F3333333300F0F0F0
      333333377F73737F33333330B0BFBFB03333337F7F33337F33333330F0FBFBF0
      3333337F7333337F33333330BFBFBFB033333373F3333373333333330BFBFB03
      33333337FFFFF7FF3333333300000000333333377777777F333333330EEEEEE0
      33333337FFFFFF7FF3333333000000000333333777777777F33333330000000B
      03333337777777F7F33333330000000003333337777777773333}
    NumGlyphs = 2
  end
  object BBHoch: TBitBtn
    Left = 119
    Top = 208
    Width = 25
    Height = 22
    Cursor = crHandPoint
    Hint = 'gr'#252'n nach oben, rot nach  unten'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = BBHochClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
      333333777777777F33333330B00000003333337F7777777F3333333000000000
      333333777777777F333333330EEEEEE033333337FFFFFF7F3333333300000000
      333333377777777F3333333330BFBFB03333333373333373F33333330BFBFBFB
      03333337F33333F7F33333330FBFBF0F03333337F33337F7F33333330BFBFB0B
      03333337F3F3F7F7333333330F0F0F0033333337F7F7F773333333330B0B0B03
      3333333737F7F7F333333333300F0F03333333337737F7F33333333333300B03
      333333333377F7F33333333333330F03333333333337F7F33333333333330B03
      3333333333373733333333333333303333333333333373333333}
    NumGlyphs = 2
  end
  object Start: TButton
    Left = 56
    Top = 98
    Width = 145
    Height = 26
    Cursor = crHandPoint
    Hint = 'es wird gekugelt'
    Caption = 'Start oder Neustart'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = StartClick
  end
  object BBAbbruch: TBitBtn
    Left = 118
    Top = 232
    Width = 25
    Height = 22
    Cursor = crHandPoint
    Hint = 'Abbruch'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = BBAbbruchClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333FFFFF333333000033333388888833333333333F888888FFF333
      000033338811111188333333338833FFF388FF33000033381119999111833333
      38F338888F338FF30000339119933331111833338F388333383338F300003391
      13333381111833338F8F3333833F38F3000039118333381119118338F38F3338
      33F8F38F000039183333811193918338F8F333833F838F8F0000391833381119
      33918338F8F33833F8338F8F000039183381119333918338F8F3833F83338F8F
      000039183811193333918338F8F833F83333838F000039118111933339118338
      F3833F83333833830000339111193333391833338F33F8333FF838F300003391
      11833338111833338F338FFFF883F83300003339111888811183333338FF3888
      83FF83330000333399111111993333333388FFFFFF8833330000333333999999
      3333333333338888883333330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object Speichern: TButton
    Left = 56
    Top = 136
    Width = 145
    Height = 26
    Cursor = crHandPoint
    Hint = 'Puzzle speichern'
    Caption = 'speichern'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = SpeichernClick
  end
  object Laden: TButton
    Left = 56
    Top = 174
    Width = 145
    Height = 26
    Cursor = crHandPoint
    Hint = 'Puzzle laden'
    Caption = 'laden'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = LadenClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'TrinudoFelder   (*.txt)|*.txt|MusterBitMap (*.bmp)|*.bmp'
    Options = [ofOverwritePrompt]
    Left = 208
    Top = 16
  end
  object OpenDialog: TOpenDialog
    Filter = 'TrinudoFelder                    (*.txt)|*.txt'
    Options = []
    Left = 168
    Top = 16
  end
end
