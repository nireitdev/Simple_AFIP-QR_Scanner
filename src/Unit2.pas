unit Unit2;


{

  Tomado desde webcam libs from https://github.com/heise/GRBLize/
  Librerias ZXing para delphi: https://github.com/Spelt/ZXing.Delphi
  
  Aggiornado para AFIP 
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  VFrames, VSample, Vcl.ComCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Button2: TButton;
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    TreeView1: TTreeView;

    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    fVideoImage: TVideoImage;

    procedure NewVideoFrameEvent(Sender: TObject; Width, Height: integer; DataPtr: pointer);



  public
    { Public declarations }
  end;

var
  Form2: TForm2;

  qrcode1:string;
  qrcode2:String;

implementation

{$R *.dfm}

uses
 ZXing.ReadResult,
 ZXing.BarCodeFormat,
 ZXing.ScanManager,
 System.NetEncoding,
 System.RegularExpressions;

procedure TForm2.Button1Click(Sender: TObject);
var
  listcams: TStringList;
begin

  qrcode1 := 'nada';
  qrcode2 := 'ningunqr';  //para que no coincidan en la primer iteracion
  listcams := TStringList.Create;
  try
    fVideoImage.GetListOfDevices(listcams);
    if not(listcams.count = 0) then
    begin
      fVideoImage.VideoStart(listcams[0]);
    end;
  finally
    listcams.Free;
  end;


end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  fVideoImage.VideoStop;



end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  fVideoImage := TVideoImage.Create();
  fVideoImage.OnNewVideoFrame := NewVideoFrameEvent;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  fVideoImage.Free;
end;

procedure TForm2.NewVideoFrameEvent(Sender: TObject; Width, Height: integer; DataPtr: pointer);
var
  bitmap: TBitmap;

  ReadResult: TReadResult;
  ScanManager: TScanManager;



  s1,s2:string;
  pos_offset:integer;

begin
  bitmap := TBitmap.Create;
  try
    bitmap.PixelFormat := pf24bit;
    fVideoImage.GetBitmap(bitmap);
    Image1.Picture.Assign(bitmap);

    // scan code
    try
      ScanManager := TScanManager.Create(TBarcodeFormat.AUTO, nil);
      ReadResult := ScanManager.Scan(bitmap);
      if ReadResult<>nil then
        //Memo1.Lines.Insert(0, FormatFloat('000', Memo1.Lines.Count+1) + ':  ' + ReadResult.text);

        qrcode1:=ReadResult.text;
        //Veo si es valido el string
        if pos('?p=',qrcode1)>0 then begin

          qrcode1:=copy(qrcode1, pos('?p=',qrcode1)+3, 1000);

          //Tecnica "anti-rebotes" de captura
          if qrcode1=qrcode2 then begin
            //Encontre un codigo valido
            qrcode1 := TNetEncoding.Base64.Decode(qrcode1);
            Memo1.Lines.Insert(0, qrcode1 );

            //paro la camara
            fVideoImage.VideoStop;

            //armo el treeview:
            with TreeView1 do begin
              Items.AddChild(nil,'AFIP QR');
              //elimino las {}
              if pos('{',qrcode1)>0 then delete(qrcode1, pos('{',qrcode1),1);
              if pos('}',qrcode1)>0 then delete(qrcode1, pos('}',qrcode1),1);


              while pos(',',qrcode1)>0 do begin
                pos_offset :=  pos(',',qrcode1);
                Items.AddChild(TreeView1.Items[0], copy(qrcode1,1,pos_offset-1));
                delete(qrcode1,1,pos_offset);
              end;
              Items.AddChild(TreeView1.Items[0], qrcode1); //ultimo item

              FullExpand;
            end;


          end else begin
            //Sigo buscando
            qrcode2:=qrcode1;

          end;
        end;

    finally
      FreeAndNil(ScanManager);
      FreeAndNil(ReadResult);
    end;
  finally
    bitmap.Free;
  end;

  Application.ProcessMessages;
end;

end.
