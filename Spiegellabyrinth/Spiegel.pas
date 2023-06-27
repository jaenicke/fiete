unit Spiegel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Grids, Buttons;

 const Rand=11;

type
  TSpielFeld=Array[-1..Rand+1,-1..Rand+1]of Integer;
  TListe=Array[1..2]of TPoint;

  TSiegelGolf = class(TForm)
    Ausgabe: TDrawGrid;
    LabelFG: TLabel;
    SpinEditG: TSpinEdit;
    ButtonNT: TButton;
    LabelStufe: TLabel;
    BarWahl: TScrollBar;
    Hinweise: TMemo;
    BBRechts: TBitBtn;
    BBLinks: TBitBtn;
    BBRunter: TBitBtn;
    BBHoch: TBitBtn;
    LabelInfo: TLabel;
    Start: TButton;
    BBAbbruch: TBitBtn;
    Speichern: TButton;
    Laden: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    procedure SpinEditGChange(Sender: TObject);
    procedure AusgabeDrawCell(Sender: TObject; ACol, ARow: Integer;
                              Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure ButtonNTClick(Sender: TObject);
    procedure BarWahlChange(Sender: TObject);
    procedure BBHochClick(Sender: TObject);
    procedure BBRunterClick(Sender: TObject);
    procedure BBLinksClick(Sender: TObject);
    procedure BBRechtsClick(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure BBAbbruchClick(Sender: TObject);
    procedure SpeichernClick(Sender: TObject);
    procedure LadenClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    FeldBreite,KugelAnzahl,Grad,Mitte:Integer;
    Feld,Kopie,TestFeld:TSpielFeld;
    KugelListe,KopieListe:TListe;
    Ende,Geladen,SpielEnde:Boolean;
    SpielListe:TStrings;

    procedure BlauesFeld;
    procedure Init;
    function Fertig:Boolean;
    procedure Loben;
    function Zusammenhaengend:Boolean;
    procedure MusterSuche(x,y:Integer);

  public
    { Public-Deklarationen }
  end;

var
  SiegelGolf: TSiegelGolf;

implementation

{$R *.dfm}
{$R+,Q+}

 const Leer=0;GKugel=13;GZiel=2;Verboten=1;RKugel=17;RZiel=16;
       LobN=10;TadelN=10;
       GradWahl:Array[1..3]of String=('leicht','normal','schwer');
       Lob:Array[1..LobN]of String=('sehr gut!','fabelhaft!','wunderbar!',
                                    'ICH bin stolz auf dich!','gut gemacht!',
                                    'du hast es geschafft!','du kannst es ja!',
                                    'noch einmal so!','toll gemacht!',
                                    'feiner Zug!');
       Tadel:Array[1..TadelN]of String=('aber ganz nett!','alles umsonst!','zu schlecht!',
                                        'mehr Glück das nächste Mal!',
                                        'noch einmal versuchen!','nicht aufgeben!',
                                        'probiers noch einmal!','bemühe dich doch!!',
                                        'versuch es wieder!',
                                        'beim nächsten Zug klappt es bestimmt!');

 procedure TSiegelGolf.BlauesFeld;
  var Rect:TGridRect;
  begin
   Rect.Left  :=-1;
   Rect.Top   :=-1;
   Rect.Right :=-1;
   Rect.Bottom:=-1;
   Ausgabe.Selection:=Rect;
  end;

 procedure TSiegelGolf.MusterSuche(x,y:Integer); // rekursive Durchmusterung
  begin
   if TestFeld[x,y]=Leer then
    begin
     TestFeld[x,y]:=100; // Feld blockieren
     MusterSuche(x-1,y);
     MusterSuche(x,y+1);
     MusterSuche(x+1,y);
     MusterSuche(x,y-1);
    end;
  end;

 function TSiegelGolf.Zusammenhaengend:Boolean;
  var OK:Boolean;
      x,y,xStart,yStart:Integer;
  begin
   // zusammenhängendes Gebiet?
   xStart:=0;yStart:=0;
   TestFeld:=Feld;OK:=True;
   for y:=0 to FeldBreite-1 do
    for x:=0 to FeldBreite-1 do
     if TestFeld[x,y]=Leer then begin xStart:=x;yStart:=y end;
   MusterSuche(xStart,yStart);
   for y:=0 to FeldBreite-1 do
    for x:=0 to FeldBreite-1 do
     if TestFeld[x,y]=Leer then OK:=False;
   Zusammenhaengend:=OK
  end;

 procedure TSiegelGolf.Init;
  var x,y,K:Integer;
  begin
   FeldBreite:=SpinEditG.Value;
   for x:=-1 to Rand+1 do
    for y:=-1 to Rand+1 do Feld[x,y]:=Verboten;
    for x:=0 to FeldBreite-1 do
     for y:=0 to FeldBreite-1 do Feld[x,y]:=Leer;
    for K:=1 to (FeldBreite*FeldBreite)div (6-Grad)+4 do
     begin
      repeat
       x:=random(FeldBreite);y:=random(FeldBreite);
      until Feld[x,y]=Leer;
      Feld[x,y]:=Verboten;
      if not Zusammenhaengend then Feld[x,y]:=Leer;
     end;
   Feld[0,0]:=GKugel;KugelListe[1].X:=0;KugelListe[1].Y:=0;
   Feld[FeldBreite-1,FeldBreite-1]:=RKugel;
   KugelListe[2].X:=FeldBreite-1;KugelListe[2].Y:=FeldBreite-1;
   KugelAnzahl:=2;Mitte:=(FeldBreite-1)div 2;
   Feld[Mitte,Mitte]:=GZiel;Feld[Mitte+1,Mitte+1]:=RZiel;
   KeyPreview:=True;
  end;

 procedure TSiegelGolf.SpinEditGChange(Sender: TObject);
  begin
   if SpinEditG.Text='' then SpinEditG.Text:='6';
   if SpinEditG.Value<4 then SpinEditG.Value:=4;
   FeldBreite:=SpinEditG.Value;
   Ausgabe.DefaultColWidth:=(556-2*FeldBreite-2)div FeldBreite;
   Ausgabe.DefaultRowHeight:=(556-2*FeldBreite-2)div FeldBreite;
   Ausgabe.ColCount:=FeldBreite;
   Ausgabe.RowCount:=FeldBreite;
   Ausgabe.Width:=FeldBreite*(Ausgabe.DefaultColWidth+2)+4;
   Ausgabe.Height:=FeldBreite*(Ausgabe.DefaultColWidth+2)+4;
   if not Geladen then ButtonNTClick(Self);
  end;

 procedure TSiegelGolf.AusgabeDrawCell(Sender: TObject; ACol, ARow: Integer;
                                   Rect: TRect; State: TGridDrawState);
  var DX:Integer;
  begin
   BlauesFeld;
   DX:=16-FeldBreite;
   with Ausgabe.Canvas do
    begin
     Brush.Style:=bsSolid;
     if Feld[ACol,ARow]=Verboten then Brush.Color:=clBlack;
     if Feld[ACol,ARow] in [Leer,GKugel,GZiel,RKugel,RZiel] then Brush.Color:=clWhite;
     FillRect(Rect);
     if Feld[ACol,ARow]=GZiel then
      begin
       Brush.Style:=bsClear;Pen.Color:=clLime;Pen.Width:=3;
       Ellipse(Rect.Left+DX,Rect.Top+DX,Rect.Right-DX,Rect.Bottom-DX);
      end;
     if Feld[ACol,ARow]=RZiel then
      begin
       Brush.Style:=bsClear;Pen.Color:=clRed;Pen.Width:=3;
       Ellipse(Rect.Left+DX,Rect.Top+DX,Rect.Right-DX,Rect.Bottom-DX);
      end;
     Pen.Width:=2;
     if Feld[ACol,ARow]=GKugel then
      begin
       Brush.Color:=clGreen;Brush.Style:=bsSolid;
       Pen.Color:=clBlack;
       Ellipse(Rect.Left+DX,Rect.Top+DX,Rect.Right-DX,Rect.Bottom-DX);
      end;
     if Feld[ACol,ARow]=RKugel then
      begin
       Brush.Color:=clRed;Brush.Style:=bsSolid;
       Pen.Color:=clBlack;
       Ellipse(Rect.Left+DX,Rect.Top+DX,Rect.Right-DX,Rect.Bottom-DX);
      end;
     if Feld[ACol,ARow]=GKugel+GZiel then
      begin
       Pen.Color:=clLime;
       Brush.Color:=clGreen;Brush.Style:=bsSolid;
       Ellipse(Rect.Left+DX,Rect.Top+DX,Rect.Right-DX,Rect.Bottom-DX);
      end;
     if Feld[ACol,ARow]=RKugel+RZiel then
      begin
       Pen.Color:=clFuchsia;
       Brush.Color:=clRed;Brush.Style:=bsSolid;
       Ellipse(Rect.Left+DX,Rect.Top+DX,Rect.Right-DX,Rect.Bottom-DX);
      end;
     if Feld[ACol,ARow]=GKugel+RZiel then
      begin
       Pen.Color:=clFuchsia;
       Brush.Color:=clGreen;Brush.Style:=bsSolid;
       Ellipse(Rect.Left+DX,Rect.Top+DX,Rect.Right-DX,Rect.Bottom-DX);
      end;
     if Feld[ACol,ARow]=RKugel+GZiel then
      begin
       Pen.Color:=clLime;
       Brush.Color:=clRed;Brush.Style:=bsSolid;
       Ellipse(Rect.Left+DX,Rect.Top+DX,Rect.Right-DX,Rect.Bottom-DX);
      end;
    end;
  end;

 procedure TSiegelGolf.FormCreate(Sender: TObject);
  var Jahr,Monat,Tag:Word;
      Pfad:String;
  begin
   randomize;Grad:=1;
   KeyPreview:=False;
   DecodeDate(Now,Jahr,Monat,Tag);
   Caption:='SpiegelGolf  © Fiete   Anno '+IntToStr(Jahr)+'  -   Schwierigkeit  leicht';
   Pfad:=ExtractFilePath(Application.ExeName);
   if not DirectoryExists(Pfad+'Puzzles') then MkDir(Pfad+'Puzzles');
   OpenDialog.InitialDir:=Pfad+'Puzzles\';
   SaveDialog.InitialDir:=Pfad+'Puzzles\';
   SpielListe:=TStringList.Create;
   SpinEditGChange(Self);
   ButtonNTClick(Self);Geladen:=False;
  end;

 procedure TSiegelGolf.ButtonNTClick(Sender: TObject);
  var Zeile:String;
      x,y:Integer;
      Jahr,Monat,Tag:Word;
  begin
   Init;
   Ausgabe.Repaint;
   LabelInfo.Caption:='Moin Tüftler, viel Erfolg!';
   Ende:=False;Start.Caption:='Start';
   Kopie:=Feld;KopieListe:=KugelListe;
   // Muster speichern
   SpielListe.Clear;
   SpielListe.Add(IntToStr(FeldBreite));
   SpielListe.Add(IntToStr(Grad+1));
   for y:=0 to FeldBreite-1 do
    begin
     Zeile:='';
     for x:=0 to FeldBreite-1 do
      begin
       if Kopie[x,y]<10 then Zeile:=Zeile+IntToStr(Kopie[x,y]);
       if Kopie[x,y]=13 then Zeile:=Zeile+'A';
       if Kopie[x,y]=16 then Zeile:=Zeile+'B';
       if Kopie[x,y]=17 then Zeile:=Zeile+'C';
      end;
     SpielListe.Add(Zeile);
    end;
   DecodeDate(Now,Jahr,Monat,Tag);
   Caption:='SpiegelGolf  © Fiete   Anno '+IntToStr(Jahr)+'  -  Schwierigkeit '+GradWahl[Grad];
  end;

 procedure TSiegelGolf.BarWahlChange(Sender: TObject);
  var Jahr,Monat,Tag:Word;
  begin
   if BarWahl.Position=0 then
    begin
     Grad:=1;BarWahl.Hint:='Schwierigkeit leicht';
    end
   else if BarWahl.Position=50 then
    begin
     Grad:=2;BarWahl.Hint:='Schwierigkeit normal';
    end
   else if BarWahl.Position=100 then
    begin
     Grad:=3;BarWahl.Hint:='Schwierigkeit schwer';
    end;
   DecodeDate(Now,Jahr,Monat,Tag);
   Caption:='SpiegelGolf  © Fiete   Anno '+IntToStr(Jahr)+'  -  Schwierigkeit '+GradWahl[Grad];
   if not Geladen then ButtonNTClick(Self);
  end;

 function TSiegelGolf.Fertig:Boolean;
  var OK:Boolean;
      K:Integer;
  begin
   OK:=True;
   for K:=1 to KugelAnzahl do
    if K=1 then
     OK:=OK and (Feld[KugelListe[K].X,KugelListe[K].Y]=GKugel+GZiel)
    else OK:=OK and (Feld[KugelListe[K].X,KugelListe[K].Y]=RKugel+RZiel); 
   Result:=OK
  end;

 procedure TSiegelGolf.BBAbbruchClick(Sender: TObject);
  var Zeile:String;
  begin
   if MessageDlg('Willst Du aufgeben?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
     Zeile:='Schade, '+Tadel[random(TadelN)+1];
     LabelInfo.Caption:=Zeile;
     MessageDlg(Zeile,mtInformation,[mbOk],0);
     BBHoch.Enabled:=False;
     BBLinks.Enabled:=False;
     BBRechts.Enabled:=False;
     BBRunter.Enabled:=False;
     BBAbbruch.Enabled:=False;
     ButtonNT.Enabled:=True;
     SpinEditG.Enabled:=True;
     BarWahl.Enabled:=True;
     Laden.Enabled:=True;
     Speichern.Enabled:=True;
     Ende:=True;Start.Caption:='Neustart';SpielEnde:=True;
     KeyPreView:=False; // keine Tasteneingabe möglich
    end;
  end;

 procedure TSiegelGolf.BBHochClick(Sender: TObject);
  var K:Integer;
  begin
   for K:=1 to KugelAnzahl do
    if K=1 then
     begin
      if Feld[KugelListe[K].X,KugelListe[K].Y-1] in [Leer,GZiel,RZiel] then
       begin
        dec(Feld[KugelListe[K].X,KugelListe[K].Y],GKugel);
        if (KugelListe[K].X=Mitte) and (KugelListe[K].Y=Mitte) then
         if Feld[Mitte,Mitte] in [Leer,GKugel,RKugel] then inc(Feld[Mitte,Mitte],GZiel);
        Feld[KugelListe[K].X,KugelListe[K].Y-1]:=Feld[KugelListe[K].X,KugelListe[K].Y-1]+GKugel;
        dec(KugelListe[K].Y);
       end
     end
    else
     begin
      if Feld[KugelListe[K].X,KugelListe[K].Y+1] in [Leer,GZiel,RZiel] then
       begin
        dec(Feld[KugelListe[K].X,KugelListe[K].Y],RKugel);
        if (KugelListe[K].X=Mitte+1) and (KugelListe[K].Y=Mitte+1) then
         if Feld[Mitte+1,Mitte+1] in [Leer,GKugel,RKugel] then inc(Feld[Mitte+1,Mitte+1],RZiel);
        Feld[KugelListe[K].X,KugelListe[K].Y+1]:=Feld[KugelListe[K].X,KugelListe[K].Y+1]+RKugel;
        inc(KugelListe[K].Y);
       end
     end;
   Ausgabe.Repaint;
   if Fertig then Loben
  end;

 procedure TSiegelGolf.BBRunterClick(Sender: TObject);
  var K:Integer;
  begin
   for K:=1 to KugelAnzahl do
    if K=1 then
     begin
      if Feld[KugelListe[K].X,KugelListe[K].Y+1] in [Leer,GZiel,RZiel] then
       begin
        dec(Feld[KugelListe[K].X,KugelListe[K].Y],GKugel);
        if (KugelListe[K].X=Mitte) and (KugelListe[K].Y=Mitte) then
         if Feld[Mitte,Mitte] in [Leer,GKugel,RKugel] then inc(Feld[Mitte,Mitte],GZiel);
        Feld[KugelListe[K].X,KugelListe[K].Y+1]:=Feld[KugelListe[K].X,KugelListe[K].Y+1]+GKugel;
        inc(KugelListe[K].Y);
       end
     end
    else
     begin
      if Feld[KugelListe[K].X,KugelListe[K].Y-1] in [Leer,GZiel,RZiel] then
       begin
        dec(Feld[KugelListe[K].X,KugelListe[K].Y],RKugel);
        if (KugelListe[K].X=Mitte+1) and (KugelListe[K].Y=Mitte+1) then
         if Feld[Mitte+1,Mitte+1] in [Leer,GKugel,RKugel] then inc(Feld[Mitte+1,Mitte+1],RZiel);
        Feld[KugelListe[K].X,KugelListe[K].Y-1]:=Feld[KugelListe[K].X,KugelListe[K].Y-1]+RKugel;
        dec(KugelListe[K].Y);
       end
     end;
   Ausgabe.Repaint;
   if Fertig then Loben
  end;

 procedure TSiegelGolf.BBLinksClick(Sender: TObject);
  var K:Integer;
  begin
   for K:=1 to KugelAnzahl do
    if K=1 then
     begin
      if Feld[KugelListe[K].X-1,KugelListe[K].Y] in [Leer,GZiel,RZiel] then
       begin
        dec(Feld[KugelListe[K].X,KugelListe[K].Y],GKugel);
        if (KugelListe[K].X=Mitte) and (KugelListe[K].Y=Mitte) then
         if Feld[Mitte,Mitte] in [Leer,GKugel,RKugel] then inc(Feld[Mitte,Mitte],GZiel);
        Feld[KugelListe[K].X-1,KugelListe[K].Y]:=Feld[KugelListe[K].X-1,KugelListe[K].Y]+GKugel;
        dec(KugelListe[K].X);
       end
     end
   else
    begin
     if Feld[KugelListe[K].X+1,KugelListe[K].Y] in [Leer,GZiel,RZiel] then
      begin
       dec(Feld[KugelListe[K].X,KugelListe[K].Y],RKugel);
       if (KugelListe[K].X=Mitte+1) and (KugelListe[K].Y=Mitte+1) then
        if Feld[Mitte+1,Mitte+1] in [Leer,GKugel,RKugel] then inc(Feld[Mitte+1,Mitte+1],RZiel);
       Feld[KugelListe[K].X+1,KugelListe[K].Y]:=Feld[KugelListe[K].X+1,KugelListe[K].Y]+RKugel;
       inc(KugelListe[K].X);
      end;
    end;
   Ausgabe.Repaint;
   if Fertig then Loben
  end;

 procedure TSiegelGolf.BBRechtsClick(Sender: TObject);
  var K:Integer;
  begin
   for K:=1 to KugelAnzahl do
    if K=1 then
     begin
      if Feld[KugelListe[K].X+1,KugelListe[K].Y] in [Leer,GZiel,RZiel] then
       begin
        dec(Feld[KugelListe[K].X,KugelListe[K].Y],GKugel);
        if (KugelListe[K].X=Mitte) and (KugelListe[K].Y=Mitte) then
         if Feld[Mitte,Mitte] in [Leer,GKugel,RKugel] then inc(Feld[Mitte,Mitte],GZiel);
        Feld[KugelListe[K].X+1,KugelListe[K].Y]:=Feld[KugelListe[K].X+1,KugelListe[K].Y]+GKugel;
        inc(KugelListe[K].X);
       end
     end
   else
    begin
     if Feld[KugelListe[K].X-1,KugelListe[K].Y] in [Leer,GZiel,RZiel] then
      begin
       dec(Feld[KugelListe[K].X,KugelListe[K].Y],RKugel);
       if (KugelListe[K].X=Mitte+1) and (KugelListe[K].Y=Mitte+1) then
        if Feld[Mitte+1,Mitte+1] in [Leer,GKugel,RKugel] then inc(Feld[Mitte+1,Mitte+1],RZiel);
       Feld[KugelListe[K].X-1,KugelListe[K].Y]:=Feld[KugelListe[K].X-1,KugelListe[K].Y]+RKugel;
       dec(KugelListe[K].X);
      end
    end;
   Ausgabe.Repaint;
   if Fertig then Loben
  end;

 procedure TSiegelGolf.Loben;
  var Zeile:String;
  begin
   Zeile:='Du bist ein Super-Tüftler, '+Lob[random(LobN)+1];
   LabelInfo.Caption:=Zeile;
   MessageDlg(Zeile,mtInformation,[mbOk],0);
   BBHoch.Enabled:=False;
   BBLinks.Enabled:=False;
   BBRechts.Enabled:=False;
   BBRunter.Enabled:=False;
   BBAbbruch.Enabled:=False;
   ButtonNT.Enabled:=True;
   SpinEditG.Enabled:=True;
   BarWahl.Enabled:=True;
   Laden.Enabled:=True;
   Speichern.Enabled:=True;
   Ende:=True;Start.Caption:='Neustart';SpielEnde:=True;
   KeyPreView:=False; // keine Tasteneingabe möglich
  end;

 procedure TSiegelGolf.StartClick(Sender: TObject);
  begin
   if Ende then
    begin
     Feld:=Kopie;Ausgabe.Repaint;
     KugelListe:=KopieListe;
    end;
   BBHoch.Enabled:=True;
   BBLinks.Enabled:=True;
   BBRechts.Enabled:=True;
   BBRunter.Enabled:=True;
   BBAbbruch.Enabled:=True;
   LabelInfo.Caption:='Moin Tüftler, versuch Dein Glück!?';
   ButtonNT.Enabled:=False;
   SpinEditG.Enabled:=False;
   BarWahl.Enabled:=False;
   Laden.Enabled:=False;
   Speichern.Enabled:=False;
   Start.Caption:='Neustart';Ende:=True;SpielEnde:=False;
   KeyPreView:=True;
   Hinweise.SetFocus
  end;


 procedure TSiegelGolf.SpeichernClick(Sender: TObject);
  begin
   with SaveDialog do
    begin
     Title:='Dein SpiegelGolfMuster';
     Filename:='SGolf_'+IntToStr(FeldBreite)+'_Nr_';
     Filter:='SpiegelGolf (*.sgf)|*.sgf';
     DefaultExt:='sgf';
     Options:=[ofOverwritePrompt];
     if Execute then SpielListe.SaveToFile(Filename)
     else MessageDlg('Das SpiegelGolfmuster wurde nicht gespeichert!',mtWarning,[mbOk],0);
    end
  end;

 procedure TSiegelGolf.LadenClick(Sender: TObject);
  var Zeile,DatName:String;
      K,x,y:Integer;
      Jahr,Monat,Tag:Word;
  begin
   DecodeDate(Now,Jahr,Monat,Tag);
   with OpenDialog do
    begin
     Title:='Dein GolfMuster';
     Filter:='SpiegelGolf (*.sgf)|*.sgf';
     DefaultExt:='sgf';
     if Execute then
      begin
       SpielListe.LoadFromFile(Filename);
       DatName:=ExtractFileName(FileName);
       K:=0;Zeile:=SpielListe[K];
       FeldBreite:=StrToInt(Zeile);
       inc(K);Zeile:=SpielListe[K];
       Grad:=StrToInt(Zeile);
       inc(K);
       for x:=-1 to Rand+1 do
        for y:=-1 to Rand+1 do Feld[x,y]:=Verboten;
       Geladen:=True;
       SpinEditG.Value:=FeldBreite; // aktualisieren
       KugelAnzahl:=2;
       for y:=0 to FeldBreite-1 do
        begin
         Zeile:=SpielListe[K+y];
         for x:=0 to FeldBreite-1 do
          begin
           if Zeile[x+1]='A' then Feld[x,y]:=13
           else if Zeile[x+1]='B' then Feld[x,y]:=16
           else if Zeile[x+1]='C' then Feld[x,y]:=17
           else Feld[x,y]:=StrToInt(Zeile[x+1]);
          end;
         Feld[0,0]:=GKugel;KugelListe[1].X:=0;KugelListe[1].Y:=0;
         Feld[FeldBreite-1,FeldBreite-1]:=RKugel;
         KugelListe[2].X:=FeldBreite-1;KugelListe[2].Y:=FeldBreite-1;
         KugelAnzahl:=2;Mitte:=(FeldBreite-1)div 2;
         Feld[Mitte,Mitte]:=GZiel;Feld[Mitte+1,Mitte+1]:=RZiel;
         KopieListe:=KugelListe;
        end;
       Ausgabe.Repaint;Kopie:=Feld;
       BarWahl.Position:=(Grad-1)*50;
       BarWahlChange(Self);
       Geladen:=False;
       Caption:='SpiegelGolf  © Fiete   Anno '+IntToStr(Jahr)+'  -  Schwierigkeit '+GradWahl[Grad]+'   '+DatName;
       Start.Caption:='Start';
      end
     else MessageDlg('Es wurde KEIN Golfmuster geladen!',mtWarning,[mbOk],0);
    end;
  end;

 procedure TSiegelGolf.FormDestroy(Sender: TObject);
  begin
   SpielListe.Free;
  end;

 procedure TSiegelGolf.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
  begin
   if SpielEnde then
    begin
     MessageDlg('Das Spiel muß erst gestartet werden!!!',mtError,[mbRetry],0);
     exit;
    end;
   if not(Key in[VK_Escape,VK_Left,VK_Up,VK_Right,VK_Down]) then exit; // falsche Taste
   if Key=VK_Escape then
    begin
     BBAbbruchClick(Self);
     exit;
    end;
   if Key=VK_Left  then BBLinksClick(Self);
   if Key=VK_Up    then BBHochClick(Self);
   if Key=VK_Right then BBRechtsClick(Self);
   if Key=VK_Down  then BBRunterClick(Self);
  end;

end.

