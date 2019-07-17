object frmPrincipal: TfrmPrincipal
  Left = 480
  Top = 145
  ActiveControl = edtDoc
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsSingle
  ClientHeight = 706
  ClientWidth = 978
  Color = clCream
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  KeyPreview = True
  Menu = mmPrincipal
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    978
    706)
  PixelsPerInch = 96
  TextHeight = 25
  object lbDoc: TLabel
    Left = 28
    Top = 47
    Width = 98
    Height = 19
    Caption = 'Documento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbDirect: TLabel
    Left = 4
    Top = 88
    Width = 185
    Height = 19
    Caption = 'C:\Windows\system32'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 110
    Width = 977
    Height = 592
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Panel2'
    TabOrder = 10
  end
  object Panel1: TPanel
    Left = 4
    Top = 2
    Width = 970
    Height = 79
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object btnProcurar: TButton
    Left = 619
    Top = 41
    Width = 156
    Height = 31
    Anchors = [akTop, akRight]
    Caption = 'Procurar - F5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btnProcurarClick
  end
  object edtDoc: TEdit
    Left = 127
    Top = 44
    Width = 489
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object checkPastasSub: TCheckBox
    Left = 28
    Top = 15
    Width = 173
    Height = 17
    Caption = 'Procurar em Subpastas'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 230
    Top = 116
    Width = 420
    Height = 570
    Hint = 'Duplo click para abrir Doc.'
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiSelect = True
    ParentFont = False
    ParentShowHint = False
    PopupMenu = pmAbrirPasta
    ShowHint = True
    TabOrder = 11
    OnDblClick = ListBox1DblClick
    OnKeyPress = ListBox1KeyPress
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 4
    Top = 144
    Width = 225
    Height = 543
    Anchors = [akLeft, akTop, akBottom]
    Color = clBtnHighlight
    DirLabel = lbDirect
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemHeight = 19
    ParentFont = False
    TabOrder = 8
  end
  object DriveComboBox1: TDriveComboBox
    Left = 4
    Top = 116
    Width = 225
    Height = 27
    DirList = DirectoryListBox1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object ListBox2: TListBox
    Left = 651
    Top = 116
    Width = 323
    Height = 570
    Hint = 'Bot'#227'o Direito para gerar planilha'
    ParentCustomHint = False
    Anchors = [akTop, akRight, akBottom]
    Color = clBtnHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    PopupMenu = pmExportacao
    ShowHint = True
    TabOrder = 12
  end
  object btnCancelar: TButton
    Left = 776
    Top = 41
    Width = 156
    Height = 31
    Anchors = [akTop, akRight]
    Caption = 'Cancelar - F7'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = btnCancelarClick
  end
  object checkData: TCheckBox
    Left = 447
    Top = 15
    Width = 264
    Height = 17
    Hint = 
      'Desmarcado procura somente por nome de arquivos sem considerar a' +
      ' data de cria'#231#227'o'
    Anchors = [akTop, akRight]
    Caption = 'Pesquisar por Data de cria'#231#227'o do doc:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = checkDataClick
  end
  object dtpInicial: TDateTimePicker
    Left = 713
    Top = 7
    Width = 105
    Height = 29
    Hint = 'Data Inicial'
    Anchors = [akTop, akRight]
    Date = 41703.701830185190000000
    Time = 41703.701830185190000000
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object dtpFinal: TDateTimePicker
    Left = 827
    Top = 7
    Width = 105
    Height = 29
    Hint = 'Data Inicial'
    Anchors = [akTop, akRight]
    Date = 41703.701830185190000000
    Time = 41703.701830185190000000
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 687
    Width = 978
    Height = 19
    Anchors = [akLeft, akRight]
    Panels = <
      item
        Text = ' Desenv. Eduardo Moraes'
        Width = 300
      end
      item
        Width = 120
      end>
  end
  object pmExportacao: TPopupMenu
    Left = 880
    Top = 287
    object GerarPlanilha1: TMenuItem
      Caption = 'Gerar Planilha'
      Enabled = False
      OnClick = GerarPlanilha1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
  end
  object pmAbrirPasta: TPopupMenu
    Left = 504
    Top = 376
    object AbrirPastadoDoc1: TMenuItem
      Caption = 'Abrir Pasta do Doc'
      Enabled = False
      OnClick = AbrirPastadoDoc1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ExcluirTodosRegistros1: TMenuItem
      Caption = 'Excluir Todos Registros'
      Enabled = False
      OnClick = ExcluirTodosRegistros1Click
    end
  end
  object SaveDialogCodEmp: TSaveDialog
    DefaultExt = '.txt'
    FileName = 'Arq_Cod_Empresas'
    Filter = 'Relat'#243'rio de Empresas.txt|.txt'
    InitialDir = 'C:\'
    Left = 824
    Top = 432
  end
  object mmPrincipal: TMainMenu
    Left = 840
    Top = 88
    object Configurao1: TMenuItem
      Caption = 'Configura'#231#227'o'
      object DiretrioPadro1: TMenuItem
        Caption = 'Diret'#243'rio Padr'#227'o'
      end
    end
  end
end
