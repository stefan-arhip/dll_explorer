unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImageHlp, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure ListDLLExports(const FileName: string; List: TStrings);
Type TDWordArray = Array [0..$FFFFF] Of DWORD;
Var imageinfo: LoadedImage;
    pExportDirectory: PImageExportDirectory;
    dirsize: Cardinal;
    pDummy: PImageSectionHeader;
    i: Cardinal;
    pNameRVAs: ^TDWordArray;
    Name: String;
begin
  List.Clear;
  If MapAndLoad(PChar(FileName), nil, @imageinfo, True, True) Then
    Begin
      Try
        pExportDirectory := ImageDirectoryEntryToData(imageinfo.MappedAddress, False, IMAGE_DIRECTORY_ENTRY_EXPORT, dirsize);
        If (pExportDirectory <> Nil) Then
          Begin
            pNameRVAs := ImageRvaToVa(imageinfo.FileHeader, imageinfo.MappedAddress, DWORD(pExportDirectory^.AddressOfNames), pDummy);
            For i:= 0 To pExportDirectory^.NumberOfNames - 1 Do
              Begin
                Name := PChar(ImageRvaToVa(imageinfo.FileHeader, imageinfo.MappedAddress, pNameRVAs^[i], pDummy));
                List.Add(Name);
              End;
          End;
      Finally
        UnMapAndLoad(@imageinfo);
      End;
    End;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  List: TStrings;
  i: Integer;
  s: String;
begin
  If OpenDialog1.Execute Then
    Begin
      List:= TStringList.Create;
      Try
        ListDLLExports(OpenDialog1.FileName, List);
        //ShowMessage(IntToStr(list.Count) + ' functions in '+OpenDialog1.FileName+' dll');
        s:= 'List of functions from <'+ OpenDialog1.FileName+ '>';
        For i:= 1 To List.Count Do
          s:= s + #13#10 + List[i- 1];
        Memo1.Lines.Add(s);
      Finally
        List.Free;
      End;
    End;
end;

end.
