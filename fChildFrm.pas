unit fChildFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, plMoveResizePanel;

type
  TformChild = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
    AMoveResizePanel: TplMoveResizePanel;
  public
    { Public êÈåæ }
  end;

var
  formChild: TformChild;

implementation

{$R *.dfm}


procedure TformChild.FormShow(Sender: TObject);
begin
//  with AMoveResizePanel do
//  begin
//    AMoveResizePanel := TplMoveResizePanel.Create(Self);
//    //Parent := formChild;
//    Left := 20;
//    Top := 50;
    //Color := clYello;
//    ParentBackground := false;
//  end;
end;

end.
