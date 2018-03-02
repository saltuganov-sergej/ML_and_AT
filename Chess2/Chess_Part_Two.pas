{ 14.16 ������� 2 (5)
  ��������� ����� ������� �� M ����� � N �������� (1 <= M, N <= 15).
  �� ����� ����������� ����, ����� � �����. �� ��������� ������������ ����� 
  ��������� ���������� ���������� ������ �����, ����������� ��� ����.
  ������, ������� ��������, �� �����������. }
  
//Saltuganov S.N.
//Dev+GNU Pascal 1.9.4.13  


PROGRAM Chess2(INPUT, OUTPUT);

CONST
  Max = 100;

TYPE    
  Coord = RECORD
            x: INTEGER;
            y: INTEGER;
          END;    

VAR
  Figure, Knight: ARRAY[1..Max] of Coord;
  Board: ARRAY[1..Max, 1..Max] OF CHAR;
  i, j, k, M, N, RBIndex, KIndex, Count: INTEGER;
  Ch: CHAR;
  FIn, FOut: TEXT;
  
PROCEDURE CheckForKnight();
BEGIN
   FOR i := 1 TO M DO
    FOR j := 1 TO N DO
      IF (Board[i, j] = '.') THEN
        FOR k := 1 TO KIndex DO
          BEGIN
            IF ((abs(Knight[k].y - i) = 2) AND (abs(Knight[k].x - j) = 1)) THEN
              Board[i, j] := '#';
            IF ((abs(Knight[k].y - i) = 1) AND (abs(Knight[k].x - j) = 2)) THEN
              Board[i, j] := '#'
          END;  
END;

PROCEDURE CheckLine(VAR dir1, dir2: INTEGER);
VAR
  ytemp, xtemp: INTEGER;
BEGIN
  xtemp := Figure[i].x;
  ytemp := Figure[i].y;
  WHILE ((Board[ytemp + dir1, xtemp + dir2] = '.') OR (Board[ytemp + dir1, xtemp + dir2] = '#')) DO
    BEGIN
      Board[ytemp + dir1, xtemp + dir2] := '#';
      ytemp := ytemp + dir1;
      xtemp := xtemp + dir2
    END
END;

PROCEDURE CheckForRookAndBishop();
VAR
  dir1, dir2: INTEGER;
BEGIN
  FOR i := 1 TO RBIndex DO
    BEGIN
      IF (Board[Figure[i].y, Figure[i].x] = 'R') THEN
        BEGIN
          dir1 := 0;
          dir2 := 1;
          CheckLine(dir1, dir2);
          dir2 := -1;
          CheckLine(dir1, dir2);
          dir1 := 1;
          dir2 := 0;
          CheckLine(dir1, dir2);
          dir1 := -1;
          CheckLine(dir1, dir2);   
        END
      ELSE
        BEGIN
          dir1 := 1; 
          dir2 := 1;
          CheckLine(dir1, dir2);
          dir2 := -1;
          CheckLine(dir1, dir2);
          dir1 := -1;
          CheckLine(dir1, dir2);
          dir2 := 1;
          CheckLine(dir1, dir2);
        END  
    END    
END;
  
BEGIN
  ASSIGN(FIn, 'input.txt');
  RESET(FIn);
  READLN(FIn, M, N);
  {��������� ������� ��� �����}
  RBIndex := 0; //��� ������ � �����
  KIndex := 0;  //��� �����
  
  //���������� ��������� ���� �����
  FOR i := 1 TO M DO
    BEGIN
      FOR j := 1 TO N DO
        BEGIN
          READ(FIn, Board[i, j]);
          //���������� ��������� ������ � �����
          IF (Board[i, j] = 'B') OR (Board[i, j] = 'R') THEN
            BEGIN
              RBIndex := RBIndex + 1;
              Figure[RBIndex].x := j;
              Figure[RBIndex].y := i
            END;
          //���������� ��������� �����  
          IF (Board[i, j] = 'K') THEN
            BEGIN
              KIndex := KIndex + 1;
              Knight[KIndex].x := j;
              Knight[KIndex].y := i
            END   
        END;      
      READLN(FIn)  
    END;
  CLOSE(FIn);
    
  //����� � ������� ���� � ��������, �� ��� ������� ������ ��� ����}    
  {FOR i := 1 TO M DO
    BEGIN
      FOR j := 1 TO N DO
        WRITE(Board[i, j], ' ');
      WRITELN      
    END;}
   
  CheckForKnight;        //����������� ������, ������� ���� ����
  CheckForRookAndBishop; //����������� ������, ������� ���� ����� � �����
    
          
  //����� � ������� ���� � �������� � � ����������� �������� ��� ����}
  {FOR i:=1 TO M DO
    BEGIN
      FOR j:=1 TO N DO
        WRITE(Board[i, j],' ');
      WRITELN      
    END;}
  
  //������ ����������� ������� � ��������� ���������� ������ ��� ����  
  Count:=0;
  FOR i := 1 TO M DO
    FOR j := 1 TO N DO
      IF Board[i, j] = '#' THEN
        Count := Count + 1;
        
  ASSIGN(FOut, 'output.txt');
  REWRITE(FOut);
  WRITELN(FOut, Count);
  CLOSE(FOut)       
END.  
