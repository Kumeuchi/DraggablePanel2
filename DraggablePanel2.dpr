program DraggablePanel2;

uses
  Vcl.Forms,
  fMain in 'fMain.pas' {frmMain},
  fChildFrm in 'fChildFrm.pas' {formChild},
  plMoveResizePanel in 'plMoveResizePanel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TformChild, formChild);
  Application.Run;
end.
