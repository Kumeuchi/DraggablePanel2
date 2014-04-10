unit plMoveResizePanel;

interface

uses
  Windows, Messages, SysUtils, Classes, StdCtrls, ExtCtrls;

type
  TplMoveResizePanel = class(TCustomPanel)
  private
    { Private �錾 }
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
//  �R���|�[�l���g���R���|�[�l���g�p���b�g�ɓo�^����葱��
//=============================================================================
procedure Register;
begin
  RegisterComponents('plXRAY', [TplMoveResizePanel]);
end;

{ TMoveResizePanel }

//=============================================================================
//  Create����
//=============================================================================
constructor TplMoveResizePanel.Create(AOWner: TComponent);
begin
  inherited Create(AOwner);
end;

//=============================================================================
//  Destroy����
//=============================================================================
destructor TplMoveResizePanel.Destroy;
begin
  inherited Destroy;
end;

//=============================================================================
//  WM_NCHITTEST��[���݃}�E�X�J�[�\�������镔���͉���]�����肷�鎞�ɑ����郁
//  �b�Z�[�W
//  ���̃��b�Z�[�W�̖ߒl(msg.Result)��ύX���邱�Ƃœ����ς���
//  HTCAPTION  �L���v�V������͂񂾂Ǝv�킹��
//             �܂�h���b�O�ňړ��\
//  HTLEFT     �t�H�[���̍��[�Ƀ}�E�X������Ǝv�킹��
//             �܂�}�E�X�h���b�O�ŉ����̃T�C�Y�ύX���\
//
//  �����ł̓N���C�A���g�̈�̋���5�h�b�g�����Ƀ}�E�X���������ɂ��̋��E�Ƃ���
//  �܂��}�E�X�ʒu�̏㉺���E��ϐ��ɑ�����C���̑g�����Ŕ��肷��
//
//  WM_NCHITTEST���R���g���[���Ŏ��������ꍇ�́CWM_LBUTTONDOWN���̃��b�Z�[�W��
//  �����ƂȂ�D�܂��J�[�\���̌`��������I�ɕύX�ƂȂ邽�߁C���쒆�̃J�[�\���`
//  ��͕ύX�ł��Ȃ�(�V�X�e���̃J�[�\����ύX����Ή\�����m��Ȃ�)
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
  //�p�����̃��b�Z�[�W�̎��s
  inherited;
  //����ȍ~�̃R�[�h�����s���Ȃ���Βʏ��TPanel�Ɠ�������ƂȂ�
  if (csDesigning in ComponentState) then exit;

  //�N���C�A���g�̈�ł̃}�E�X�ʒu���擾
  APos := ScreenToClient(Point(msg.XPos, msg.YPos));

  PosFlag := $00;
  //���[����5�h�b�g����
  if (APos.X < 5) then PosFlag := PosFlag or mptLeft;
  //��[����5�h�b�g����
  if (APos.Y < 5) then PosFlag := PosFlag or mptTop;
  //�E�[����5�h�b�g����
  if (ClientWidth - APos.X) < 5 then PosFlag := PosFlag or mptRight;
  //���[����5�h�b�g����
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
//  WM_NCHITTEST���b�Z�[�W�̏����ŃR���g���[���̃N���C�A���g�̈�Ƀ}�E�X�J�[�\
//  �������鎞�ɃL���v�V�����o�[(HTCAPTION)�Ƃ��Ă��܂����̂ŁC����ɑ΂��鏈�u
//  ���̏������Ȃ��ƃ_�u���N���b�N��Align:=alClient;�Ƃ����̂Ɠ����ƂȂ�
//=============================================================================
procedure TplMoveResizePanel.WmSysCommand(var msg: TWmSysCommand);
begin
  //CmdType��SC_MAXIMIZE(�ő剻�v��)���܂܂�Ă��鎞�͉������Ȃ�
  if (msg.CmdType or SC_MAXIMIZE) = msg.CmdType then begin
  end else begin
    //�ʏ�ʂ�
    inherited;
  end;
end;

end.


