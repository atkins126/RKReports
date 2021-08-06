unit dmuSysImages;

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Controls, cxGraphics;

type
  TdmSysImages = class(TDataModule)
    ImageList: TImageList;
    imOperType: TImageList;
    ImagesBase: TcxImageList;
    ImageListPNG: TcxImageList;
    ImagesBase24: TcxImageList;
    ImagesList16: TcxImageList;
    cxImageList1: TcxImageList;
  private
  public
  end;

var
  dmSysImages: TdmSysImages;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
