unit UfrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus,
  UThreads, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.FileCtrl, System.IniFiles;

type
  TfrmPrincipal = class(TForm)
    btnProcurar: TButton;
    edtDoc: TEdit;
    checkPastasSub: TCheckBox;
    ListBox1: TListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    lbDoc: TLabel;
    ListBox2: TListBox;
    pmExportacao: TPopupMenu;
    GerarPlanilha1: TMenuItem;
    btnCancelar: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    N1: TMenuItem;
    checkData: TCheckBox;
    dtpInicial: TDateTimePicker;
    dtpFinal: TDateTimePicker;
    lbDirect: TLabel;
    pmAbrirPasta: TPopupMenu;
    AbrirPastadoDoc1: TMenuItem;
    StatusBar1: TStatusBar;
    SaveDialogCodEmp: TSaveDialog;
    N2: TMenuItem;
    ExcluirTodosRegistros1: TMenuItem;
    mmPrincipal: TMainMenu;
    Configurao1: TMenuItem;
    DiretrioPadro1: TMenuItem;
    procedure btnProcurarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GerarPlanilha1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure ListBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure checkDataClick(Sender: TObject);
    procedure AbrirPastadoDoc1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExcluirTodosRegistros1Click(Sender: TObject);
    function lerConfig:string;
  private
  Function GetNetUserName: string;
  function FileTimeToDTime(FTime: TFileTime): TDateTime;
    { Private declarations }
  public
    arq : string;
    StartTime: Cardinal;
    Recursive: Integer;
    procedure FindFiles(const sDirectory: string;
    const SearchSubfolders: boolean = true);
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  ThreadBuscador : TBuscador;

implementation

uses
  Winapi.ShellAPI;

{$R *.dfm}

procedure TfrmPrincipal.AbrirPastadoDoc1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', Pchar(ExtractFilePath(ListBox1.Items.Strings[ListBox1.ItemIndex])),nil,nil,SW_SHOWNORMAL);
end;

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
    edtDoc.Clear;
    edtDoc.SetFocus;
    btnProcurar.Click;
    ListBox1.Clear;
    ListBox2.Clear;
end;

procedure TfrmPrincipal.btnProcurarClick(Sender: TObject);
begin
  AbrirPastadoDoc1.Enabled := True;
  ThreadBuscador := TBuscador.Create(True);
  ThreadBuscador.FreeOnTerminate := True;
  ThreadBuscador.Resume;
end;

procedure TfrmPrincipal.checkDataClick(Sender: TObject);
begin
  if checkData.Checked = True then
  begin
    dtpInicial.Enabled := True;
    dtpInicial.Color := clYellow;
    dtpFinal.Enabled := True;
    dtpFinal.Color := clYellow;
    dtpInicial.SetFocus;
  end
  else
    if checkData.Checked = False then
  begin
    dtpInicial.Enabled := False;
    dtpInicial.Color := clWhite;
    dtpFinal.Enabled := False;
    dtpFinal.Color := clWhite;
    edtDoc.SetFocus;
  end;
end;

procedure TfrmPrincipal.ExcluirTodosRegistros1Click(Sender: TObject);
var
  i : Integer;
begin
  if Application.MessageBox('Confirma excusão de todos arquivos encontrados?', 'Atenção', MB_YESNO) =  IDYES then
    begin
      for i := 0 to Pred(ListBox1.Items.Count) do
        begin
          DeleteFile(ListBox1.Items.Strings[i]);
        end;

      if Application.MessageBox('Arquivos Excluídos com sucesso!', 'Confirmação', MB_OK + MB_ICONINFORMATION) = IDOK then
        begin
          ListBox1.Clear;
          ListBox2.Clear;
        end;
    end;
end;

function TfrmPrincipal.FileTimeToDTime(FTime: TFileTime): TDateTime;
var
  LocalFTime: TFileTime;
  STime: TSystemTime;
begin
  FileTimeToLocalFileTime(FTime, LocalFTime);
  FileTimeToSystemTime(LocalFTime, STime);
  Result := SystemTimeToDateTime(STime);
end;

procedure TfrmPrincipal.FindFiles(const sDirectory: string;
  const SearchSubfolders: boolean);
var
sr: TSearchRec;
dtCreate : TDateTime;
begin
  if edtDoc.Text = Trim('') then
  begin
    frmPrincipal.Caption := 'Localizador de Documentos.';
    edtDoc.SetFocus;
    Exit;
  end;

if DirectoryExists(sDirectory) then
try
  if Recursive <= 0 then
  begin
    StartTime:= GetTickCount;
    Recursive:= 0;
    ListBox1.Clear;
    ListBox2.Clear;
  end;

if FindFirst(sDirectory + '\*.*', faAnyFile, sr) = 0 then
begin
  repeat
  case sr.Attr of  faDirectory:
  if SearchSubfolders then
    if(Sr.Name <> '.') and
      (Sr.Name <> '..') then
      begin
        Inc(Recursive);
        FindFiles(sDirectory + '\'+ sr.Name);
        frmPrincipal.Caption := (sDirectory + sr.Name);
      end;
      else
       if Pos(AnsiUpperCase(edtDoc.Text),
         AnsiUpperCase(sr.Name)) <> 0 then
         begin
         dtCreate :=  FileTimeToDTime(sr.FindData.ftCreationTime);
          if checkData.Checked = True then
          begin
            if (dtCreate >= dtpInicial.Date) and (dtCreate <= dtpFinal.Date) then
            begin
              ListBox1.Items.Add(sDirectory + '\' + sr.Name);
              ListBox2.Items.Add(sr.Name + '- criado em ' + DateToStr(dtCreate));
            end;
          end
          else
          if checkData.Checked = False then
          begin
             ListBox1.Items.Add(sDirectory + '\' + sr.Name);
             ListBox2.Items.Add(sr.Name + '- criado em ' + DateToStr(dtCreate));
          end;
         end;
      end;
  until FindNext(sr) <> 0;
end;

finally
FindClose(sr);
Dec(Recursive);
if Recursive < 0 then
  begin
    ListBox1.Items.Add('Terminado em '
    + IntToStr(GetTickCount - StartTime)+'ms.');
    ListBox1.ItemIndex := ListBox1.Count - 1;
    frmPrincipal.Caption := 'Total de Documentos Encontrados:' + IntToStr(ListBox1.Items.Count - 1);
  end;
 end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if application.MessageBox ('Deseja Realmente Sair?','Sair do Sistema', Mb_YesNo+MB_iconQuestion)= IdYes then
  begin
    Action:=cafree
  end
  else
    Action:=caNone;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmPrincipal.Caption := 'Localizador de Documentos.';
  DriveComboBox1.Drive := lerConfig[1];
//  DirectoryListBox1.Directory := 'R:\empresas';
  dtpInicial.Date := Date;
  dtpFinal.Date := Date;
  StatusBar1.Panels[1].Text := 'Versão: ' + FormatDateTime('dd/mm/yyyy' + ' - ' + 'hh:mm', FileDateToDateTime(FileAge(Application.ExeName)));
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  DeleteFile('R:\temp\SearchFR_Log\' + GetNetUserName + '.txt');
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if application.MessageBox ('Deseja Realmente Sair?','Sair do Sistema', Mb_YesNo+MB_iconQuestion) = IDYES then
      Application.Terminate;
  end;
  if Key = VK_F5 then
  begin
    btnProcurar.Click;
  end;
  if Key = VK_F7 then
  begin
    btnCancelar.Click;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  // ShowMessage(lerConfig)
end;
{var
  log : TStringList;
begin
  StatusBar1.Panels[1].Text := 'Usuário: ' + AnsiUpperCase(GetNetUserName);
  log := TStringList.Create;
    try
      log.SaveToFile('R:\temp\SearchFR_Log\' + AnsiUpperCase(GetNetUserName) + '.txt');
    finally
      log.Free;
    end;
end;}

procedure TfrmPrincipal.GerarPlanilha1Click(Sender: TObject);
var
i : Integer;
Arq : TStringList;
Aux : string;
begin
  if SaveDialogCodEmp.Execute then
    begin
      Arq := TStringList.Create;
      try
        for i := 0 to ListBox2.Items.Count -1 do
          begin
            Aux := Copy(ListBox2.Items[i], 1, 4);
            Arq.Add(Aux);
          end;
        Arq.SaveToFile(SaveDialogCodEmp.FileName);
        if Application.MessageBox(Pchar('Planilha criada em ' + SaveDialogCodEmp.FileName + '_' + FormatDateTime('dd.mm.yyyy', Date) + ' - Deseja Abrir?'), 'Confirmação', MB_YESNO) = IDYES then
          ShellExecute(Handle, 'open', PChar(SaveDialogCodEmp.FileName + '_' + FormatDateTime('dd.mm.yyyy', Date)), '', '', SW_SHOWNORMAL);
      finally
        FreeAndNil(Arq);
      end;
    end;
end;

function TfrmPrincipal.GetNetUserName: string;
var
  NetUserNameLength: DWord;
begin
  NetUserNameLength:=50;
  SetLength(Result, NetUserNameLength);
  GetUserName(pChar(Result),NetUserNameLength);
  SetLength(Result, StrLen(pChar(Result)));
end;

function TfrmPrincipal.lerConfig:string;
var
  config:TIniFile;
  param:string;
begin
  config := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\config.ini');
  param := config.readstring('PARAMETRO','PATH','');

  Result := param;
end;


procedure TfrmPrincipal.ListBox1DblClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', Pchar(ListBox1.Items.Strings[ListBox1.ItemIndex]),nil,nil,SW_SHOWNORMAL);
end;

procedure TfrmPrincipal.ListBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    ShellExecute(Handle, 'open', Pchar(ListBox1.Items.Strings[ListBox1.ItemIndex]),nil,nil,SW_SHOWNORMAL);
  end;
end;

end.
