program Zielen;

uses
  Forms,
  Spiegel in 'Spiegel.pas' {SiegelGolf};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TSiegelGolf, SiegelGolf);
  Application.Run;
end.
