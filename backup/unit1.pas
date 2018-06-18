unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, TypInfo;

type

  { TTemperatureCalculateApp }

  TTemperatureCalculateApp = class(TForm)
    GenerateTempBtn: TButton;
    TempsCmbBox: TComboBox;
    NumberOfTempEdit: TEdit;
    CelTempLabel: TLabel;
    KelTempLabel: TLabel;
    FarTempLabel: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure GenerateTempBtnClick(Sender: TObject);
  private
    function CountCelTemp(tempNumber: extended; tempSource: string): string;
    function CountKelTemp(tempNumber: extended; tempSource: string): string;
    function CountFarTemp(tempNumber: extended; tempSource: string): string;
  public
    constructor Create(AOwner: TComponent); override;
  end;

type
  Temperatures = (Celsius, Kelvin, Farenheit);

var
  TemperatureCalculateApp: TTemperatureCalculateApp;

implementation

{$R *.lfm}
constructor TTemperatureCalculateApp.Create(AOwner: TComponent);
var
  index: integer;
begin
  inherited Create(AOwner);
  for index := Ord(Low(Temperatures)) to Ord(High(Temperatures)) do
  begin
    TempsCmbBox.Items.Add(GetEnumName(TypeInfo(Temperatures), index));
  end;
  TempsCmbBox.Text := GetEnumName(TypeInfo(Temperatures), 0);
end;


function TTemperatureCalculateApp.CountCelTemp(tempNumber: extended; tempSource: string): string;
var
  temp: string;
begin
  if (CompareStr(tempSource, 'Celsius') = 0) then
  begin
    temp := 'Celsius'+#13#10+FloatToStr(tempNumber);
  end
  else if (CompareStr(tempSource, 'Kelvin') = 0) then
  begin
    temp := 'Celsius'+#13#10+FloatToStr(tempNumber - 273.15);
  end
  else
  begin
    temp := 'Celsius'+#13#10+FloatToStr((tempNumber - 32) / 1.8);
  end;
  CountCelTemp := temp;
end;

function TTemperatureCalculateApp.CountKelTemp(tempNumber: extended; tempSource: string): string;
var
  temp: string;
begin
  if (CompareStr(tempSource, 'Celsius') = 0) then
  begin
    temp := 'Kelvin'+#13#10+FloatToStr(tempNumber + 273.15);
  end
  else if (CompareStr(tempSource, 'Kelvin') = 0) then
  begin
    temp := 'Kelvin'+ #13#10+FloatToStr(tempNumber);
  end
  else
  begin
    temp := 'Kelvin'+#13#10+FloatToStr((tempNumber +459.67)*5/9);
  end;
  CountKelTemp := temp;
end;

function TTemperatureCalculateApp.CountFarTemp(tempNumber: extended; tempSource: string): string;
var
  temp: string;
begin
  if (CompareStr(tempSource, 'Celsius') = 0) then
  begin
    temp := 'Farenheit'+#13#10+FloatToStr((1.8 * tempNumber) +32);
  end
  else if (CompareStr(tempSource, 'Kelvin') = 0) then
  begin
    temp := 'Farenheit'+#13#10+FloatToStr((1.8*tempNumber) - 459.67);
  end
  else
  begin
    temp := 'Farenheit'+#13#10+FloatToStr(tempNumber);
  end;
  CountFarTemp := temp;
end;

procedure TTemperatureCalculateApp.GenerateTempBtnClick(Sender: TObject);
var
  tempNumber: string;
  tempNumberFloat: extended;
  tempSource: string;
begin
  tempNumber := NumberOfTempEdit.Text;
  try
  tempNumberFloat:= StrToFloat(tempNumber);
  tempSource := TempsCmbBox.Text;
  CelTempLabel.Caption := TemperatureCalculateApp.CountCelTemp(tempNumberFloat, tempSource);
  KelTempLabel.Caption := TemperatureCalculateApp.CountKelTemp(tempNumberFloat, tempSource);
  FarTempLabel.Caption := TemperatureCalculateApp.CountFarTemp(tempNumberFloat, tempSource);
  except
  on E: EConvertError do ShowMessage('Please enter a numeric value');
  on E: Exception do ShowMessage('Something went terribly wrong. Please contact support. Message:'+ E.Message);
  end;
end;
end.
