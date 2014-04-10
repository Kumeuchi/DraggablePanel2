unit plMoveResizePanel;

interface

uses
  Windows, Messages, SysUtils, Classes, StdCtrls, ExtCtrls;

type
  TplMoveResizePanel = class(TCustomPanel)
  private
    { Private 宣言 }
  protected
    procedure WmNCHitTest(var msg: TWmNCHitTest); message WM_NCHITTEST;
    procedure WmSysCommand(var msg: TWmSysCommand); message WM_SYSCOMMAND;
  public
    constructor Create(AOWner: TComponent); override;
    destructor Destroy; override;
  published
    property Color;
  end;

procedure Register;

implementation

//=============================================================================
//  コンポーネントをコンポーネントパレットに登録する手続き
//=============================================================================
procedure Register;
begin
  RegisterComponents('plXRAY', [TplMoveResizePanel]);
end;

{ TMoveResizePanel }

//=============================================================================
//  Create処理
//=============================================================================
constructor TplMoveResizePanel.Create(AOWner: TComponent);
begin
  inherited Create(AOwner);
end;

//=============================================================================
//  Destroy処理
//=============================================================================
destructor TplMoveResizePanel.Destroy;
begin
  inherited Destroy;
end;

//=============================================================================
//  WM_NCHITTESTは[現在マウスカーソルがある部分は何か]を決定する時に送られるメ
//  ッセージ
//  このメッセージの戻値(msg.Result)を変更することで動作を変える
//  HTCAPTION  キャプションを掴んだと思わせる
//             つまりドラッグで移動可能
//  HTLEFT     フォームの左端にマウスがあると思わせる
//             つまりマウスドラッグで横幅のサイズ変更が可能
//
//  ここではクライアント領域の境の5ドット分内にマウスが来た時にその境界とする
//  まずマウス位置の上下左右を変数に代入し，その組合せで判定する
//
//  WM_NCHITTESTをコントロールで実装した場合は，WM_LBUTTONDOWN等のメッセージは
//  無効となる．またカーソルの形状も強制的に変更となるため，操作中のカーソル形
//  状は変更できない(システムのカーソルを変更すれば可能かも知れない)
//=============================================================================
procedure TplMoveResizePanel.WmNCHitTest(var msg: TWmNCHitTest);
const
  mptLeft   = $01;
  mptTop    = $02;
  mptRight  = $04;
  mptBottom = $08;

var
  APos    : TPoint;
  PosFlag : Byte;
begin
  //継承元のメッセージの実行
  inherited;
  //これ以降のコードを実行しなければ通常のTPanelと同じ動作となる
  if (csDesigning in ComponentState) then exit;

  //クライアント領域でのマウス位置を取得
  APos := ScreenToClient(Point(msg.XPos, msg.YPos));

  PosFlag := $00;
  //左端から5ドット未満
  if (APos.X < 5) then PosFlag := PosFlag or mptLeft;
  //上端から5ドット未満
  if (APos.Y < 5) then PosFlag := PosFlag or mptTop;
  //右端から5ドット未満
  if (ClientWidth - APos.X) < 5 then PosFlag := PosFlag or mptRight;
  //下端から5ドット未満
  if (ClientHeight - APos.Y) < 5 then PosFlag := PosFlag or mptBottom;

  case PosFlag of
    mptLeft            : msg.Result := HTLEFT;
    mptTop             : msg.Result := HTTOP;
    mptTop+mptLeft     : msg.Result := HTTOPLEFT;
    mptRight           : msg.Result := HTRIGHT;
    mptTop+mptRight    : msg.Result := HTTOPRIGHT;
    mptBottom          : msg.Result := HTBOTTOM;
    mptBottom+mptLeft  : msg.Result := HTBOTTOMLEFT;
    mptBottom+mptRight : msg.Result := HTBOTTOMRIGHT;
  else
    msg.Result := HTCAPTION;
  end;
end;

//=============================================================================
//  WM_NCHITTESTメッセージの処理でコントロールのクライアント領域にマウスカーソ
//  ルがある時にキャプションバー(HTCAPTION)としてしまったので，それに対する処置
//  この処理がないとダブルクリックでAlign:=alClient;としたのと同じとなる
//=============================================================================
procedure TplMoveResizePanel.WmSysCommand(var msg: TWmSysCommand);
begin
  //CmdTypeにSC_MAXIMIZE(最大化要求)が含まれている時は何もしない
  if (msg.CmdType or SC_MAXIMIZE) = msg.CmdType then begin
  end else begin
    //通常通り
    inherited;
  end;
end;

end.


