unit UThreads;

interface

uses Classes;

type
TBuscador=class(TThread)
  protected
  procedure Execute; override;
end;

implementation

uses
  System.SysUtils, UfrmPrincipal;

{ TBuscador }

procedure TBuscador.Execute;
begin
  Priority := tpLower;
  frmPrincipal.FindFiles(frmPrincipal.DirectoryListBox1.Directory, frmPrincipal.checkPastasSub.Checked);
  inherited;

end;

end.
