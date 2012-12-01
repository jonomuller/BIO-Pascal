program shuffling;

uses
  sysutils, strutils;

var
  cards:array[1..16] of integer = (1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0);
  n,p,q,r,s,t,u,close,open,count:integer;
  inputstring,outputstring:string;

function break:integer;
begin
  cards[9] := cards[1];
  for n := 1 to 8 do cards[n] := cards[n+1];
end;

function outRiffle:integer;
begin
  for n := 1 to 8 do cards[n+8] := cards[n];
  cards[1] := cards[9];
  cards[2] := cards[13];
  cards[3] := cards[10];
  cards[4] := cards[14];
  cards[5] := cards[11];
  cards[6] := cards[15];
  cards[7] := cards[12];
  cards[8] := cards[16];
end;

function inRiffle:integer;
begin
  for n := 1 to 8 do cards[n+8] := cards[n];
  cards[1] := cards[13];
  cards[2] := cards[9];
  cards[3] := cards[14];
  cards[4] := cards[10];
  cards[5] := cards[15];
  cards[6] := cards[11];
  cards[7] := cards[16];
  cards[8] := cards[12];
end;

procedure check;
begin
  for n := 1 to length(inputstring) do
  begin
    case midstr(inputstring, n, 1) of
      'b' : outputstring := outputstring + midstr(inputstring, n, 1);
      'i' : outputstring := outputstring + midstr(inputstring, n, 1);
      'o' : outputstring := outputstring + midstr(inputstring, n, 1);
      '2' : for p := 1 to strtoint(midstr(inputstring, n, 1)) - 1 do outputstring := outputstring + midstr(inputstring, n+1, 1);
      '3' : for p := 1 to strtoint(midstr(inputstring, n, 1)) - 1 do outputstring := outputstring + midstr(inputstring, n+1, 1);
      '4' : for p := 1 to strtoint(midstr(inputstring, n, 1)) - 1 do outputstring := outputstring + midstr(inputstring, n+1, 1);
      '5' : for p := 1 to strtoint(midstr(inputstring, n, 1)) - 1 do outputstring := outputstring + midstr(inputstring, n+1, 1);
      '6' : for p := 1 to strtoint(midstr(inputstring, n, 1)) - 1 do outputstring := outputstring + midstr(inputstring, n+1, 1);
      '7' : for p := 1 to strtoint(midstr(inputstring, n, 1)) - 1 do outputstring := outputstring + midstr(inputstring, n+1, 1);
      '8' : for p := 1 to strtoint(midstr(inputstring, n, 1)) - 1 do outputstring := outputstring + midstr(inputstring, n+1, 1);
      '9' : for p := 1 to strtoint(midstr(inputstring, n, 1)) - 1 do outputstring := outputstring + midstr(inputstring, n+1, 1);
    end;
  end;
end;

procedure search;
label search1, search2, search3;
begin
  for count := 1 to length(inputstring) + 100 do
  begin
    while midstr(inputstring, count, 1) = ')' do
    begin

    for n := length(inputstring) downto 1 do
    begin
      if midstr(inputstring, n, 1) = ')' then goto search1;
      outputstring := outputstring + midstr(inputstring, n, 1);
    end;

    search1:
    for p := n downto 1 do
    begin
      if midstr(inputstring, p, 1) = '(' then
      begin
        open := p;
        goto search2;
      end;
    end;

    search2:
    for q := p to length(inputstring) do
    begin
      if midstr(inputstring, q, 1) = ')' then
      begin
        close := q;
        goto search3;
      end;
    end;

    search3:
    for r := n downto close+1 do
    begin
      outputstring := outputstring + midstr(inputstring, r, 1);
    end;

    for s := 1 to strtoint(midstr(inputstring, open-1, 1)) do
    begin
      for t := close-1 downto open+1 do
      begin
        outputstring := outputstring + midstr(inputstring, t, 1);
      end;
    end;

    for u := open-2 downto 1 do
    begin
      outputstring := outputstring + midstr(inputstring, u, 1);
    end;

    inputstring := reversestring(outputstring);
    outputstring := '';
    end;
  end;

  outputstring := '';
  check;
end;

procedure initialise;
begin
  readln(inputstring);

  if pos(')', inputstring) > 0 then search
  else check;
end;

procedure shuffle;
begin
  for q := 1 to length(outputstring) do
  begin
    case midstr(outputstring, q, 1) of
    'b' : break;
    'o' : outRiffle;
    'i' : inRiffle;
    end;
  end;

  for n := 1 to 7 do write(cards[n], ' ');
  write(cards[8]);
end;

begin
  initialise;
  shuffle;
  Readln;
end.

