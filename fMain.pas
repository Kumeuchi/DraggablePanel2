unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmMain = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  fChildFrm, plMoveResizePanel;

var
AMoveResizePanel:tplMoveResizePanel;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  formChild.Show;
  with AMoveResizePanel do
  begin
    AMoveResizePanel := TplMoveResizePanel.Create(Self);
    Parent := formChild;
    Left := 20;
    Top := 50;
    //Color := clYello;
    ParentBackground := false;
  end;
end;

end.
