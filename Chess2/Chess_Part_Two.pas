PROGRAM Chess2(INPUT, OUTPUT);

CONST
  Max = 15;

TYPE
  Coord=RECORD
         x: INTEGER;
         y: INTEGER;
       END;    

VAR
  Bishop, Rook, Knight: ARRAY[1..Max] of Coord;
  Board: ARRAY[1..Max,1..Max] OF CHAR;
  i, j, M, N, b,r,k,d,e,f,Ci,Cj:INTEGER;
  Ch: CHAR;
  FIn: TEXT;
  
PROCEDURE CheckForKnight();
BEGIN
   FOR i:=1 TO M DO
    FOR j:=1 TO N DO
      IF (Board[i,j] = '.') THEN
        FOR d:=1 TO k DO
          BEGIN
            IF ((abs(Knight[d].y - i) = 2) AND (abs(Knight[d].x - j) = 1)) THEN
              Board[i,j]:= '#';
            IF ((abs(Knight[d].y - i) = 1) AND (abs(Knight[d].x - j) = 2)) THEN
              Board[i,j]:= '#'
          END;  
END;

PROCEDURE CheckForRook();
VAR
  ytemp, xtemp: INTEGER;
BEGIN
  FOR e:=1 TO r DO
    BEGIN
      FOR i:=1 TO M DO
        BEGIN
          IF (Rook[e].y=i) THEN
            BEGIN
              ytemp:=Rook[e].y;
              WHILE ((Board[ytemp-1,Rook[e].x] = '.') OR (Board[ytemp-1,Rook[e].x] = '#')) DO
                BEGIN
                  Board[ytemp-1,Rook[e].x] := '#';
                  ytemp:=ytemp-1
                END;
              ytemp:=Rook[e].y;
              WHILE ((Board[ytemp+1,Rook[e].x] = '.') OR (Board[ytemp+1,Rook[e].x] = '#')) DO
                BEGIN
                  Board[ytemp+1,Rook[e].x] := '#';
                  ytemp:=ytemp+1
                END;   
            END    
        END;
      FOR j:=1 TO M DO
        BEGIN
          IF (Rook[e].x=j) THEN
            BEGIN
              xtemp:=Rook[e].x;
              WHILE ((Board[Rook[e].y,xtemp-1] = '.') OR (Board[Rook[e].y,xtemp-1] = '#')) DO
                BEGIN
                  Board[Rook[e].y,xtemp-1] := '#';
                  xtemp:=xtemp-1
                END;
              xtemp:=Rook[e].x;
              WHILE ((Board[Rook[e].y,xtemp+1] = '.') OR (Board[Rook[e].y,xtemp+1] = '#')) DO
                BEGIN
                  Board[Rook[e].y,xtemp+1] := '#';
                  xtemp:=xtemp+1
                END;   
            END    
        END  
    END
END;


PROCEDURE CheckForBishop();
VAR
  ytemp, xtemp: INTEGER;
BEGIN
  FOR f:=1 TO b DO
    FOR i:=1 TO M DO
      FOR j:=1 TO N DO 
        BEGIN
          IF (abs(Bishop[f].y-i) = abs(Bishop[f].x-j)) THEN
            BEGIN
              xtemp:=Bishop[f].x;
              ytemp:=Bishop[f].y;
              WHILE ((Board[ytemp+1,xtemp+1] = '.') OR (Board[ytemp+1,xtemp+1] = '#')) DO
                BEGIN
                  Board[ytemp+1,xtemp+1]:='#';
                  xtemp:=xtemp+1;
                  ytemp:=ytemp+1;
                END;
              xtemp:=Bishop[f].x;
              ytemp:=Bishop[f].y;
              WHILE ((Board[ytemp+1,xtemp-1] = '.') OR (Board[ytemp+1,xtemp-1] = '#')) DO
                BEGIN
                  Board[ytemp+1,xtemp-1]:='#';
                  xtemp:=xtemp-1;
                  ytemp:=ytemp+1;
                END;
              xtemp:=Bishop[f].x;
              ytemp:=Bishop[f].y;
              WHILE ((Board[ytemp-1,xtemp+1] = '.') OR (Board[ytemp-1,xtemp+1] = '#')) DO
                BEGIN
                  Board[ytemp-1,xtemp+1]:='#';
                  xtemp:=xtemp+1;
                  ytemp:=ytemp-1;
                END;
              xtemp:=Bishop[f].x;
              ytemp:=Bishop[f].y;
              WHILE ((Board[ytemp-1,xtemp-1] = '.') OR (Board[ytemp-1,xtemp-1] = '#')) DO
                BEGIN
                  Board[ytemp-1,xtemp-1]:='#';
                  xtemp:=xtemp-1;
                  ytemp:=ytemp-1;
                END;      
            END
        END
END;


  
  
BEGIN
  ASSIGN(FIn, 'field.txt');
  RESET(FIn);
  READLN(FIn, M, N);
  {Начальные индексы для фигур:}
  b:=0; //Для слонов
  r:=0; //Для ладей
  k:=0; //Для коней
  
  //Считывание координат всех фигур
  FOR i:=1 TO M DO
    BEGIN
      FOR j:=1 TO N DO
        BEGIN
          READ(FIn, Board[i, j]);
          IF Board[i,j] = 'B'
          THEN
            BEGIN
              b:=b+1;
              Bishop[b].x:=j;
              Bishop[b].y:=i
            END;
          IF Board[i,j] = 'K'
          THEN
            BEGIN
              k:=k+1;
              Knight[k].x:=j;
              Knight[k].y:=i
            END;
          IF Board[i,j] = 'R'
          THEN
            BEGIN
              r:=r+1;
              Rook[r].x:=j;
              Rook[r].y:=i
            END    
        END;      
      READLN(FIn)  
    END;
  {Вывод поля с фигурами, но без отметки клеток под боем}    
  FOR i:=1 TO M DO
    BEGIN
      FOR j:=1 TO N DO
        WRITE(Board[i,j], ' ');
      WRITELN      
    END;
   
  CheckForKnight;
  CheckForRook;
  CheckForBishop;
    
  
  
  //Вывод координат слонов    
  FOR i:=1 to b DO
    WRITE('i=',i,': ',Bishop[i].y,' ',Bishop[i].x,'   ');
  WRITELN;
  //Вывод координат коней  
  FOR i:=1 to k DO
    WRITE('i=',i,': ',Knight[i].y,' ',Knight[i].x,'   ');
  WRITELN;  
  //Вывод координат ладей
  FOR i:=1 to r DO
    WRITE('i=',i,': ',Rook[i].y,' ',Rook[i].x,'   ');
  WRITELN;        
  {Вывод поля с фигурами и с отмеченными клетками под боем}
  FOR i:=1 TO M DO
    BEGIN
      FOR j:=1 TO N DO
        WRITE(Board[i,j],' ');
      WRITELN      
    END; 
  
      
    
END.  
