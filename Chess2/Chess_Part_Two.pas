PROGRAM Chess2(INPUT, OUTPUT);

CONST
  Max = 15;

TYPE    
  Coord = RECORD
            x: INTEGER;
            y: INTEGER;
          END;    

VAR
  Bishop, Rook, Knight: ARRAY[1..Max] of Coord;
  Board: ARRAY[1..Max, 1..Max] OF CHAR;
  i, j, M, N, b, r, k, d, e, f: INTEGER;
  Ch: CHAR;
  FIn: TEXT;
  
PROCEDURE CheckForKnight();
BEGIN
   FOR i := 1 TO M DO
    FOR j := 1 TO N DO
      IF (Board[i, j] = '.') THEN
        FOR d:=1 TO k DO
          BEGIN
            IF ((abs(Knight[d].y - i) = 2) AND (abs(Knight[d].x - j) = 1)) THEN
              Board[i, j] := '#';
            IF ((abs(Knight[d].y - i) = 1) AND (abs(Knight[d].x - j) = 2)) THEN
              Board[i, j] := '#'
          END;  
END;

PROCEDURE CheckLine(VAR dir1, dir2: INTEGER);
VAR
  ytemp, xtemp: INTEGER;
BEGIN
  xtemp := Rook[e].x;
  ytemp := Rook[e].y;
  WHILE ((Board[ytemp + dir1, xtemp + dir2] = '.') OR (Board[ytemp + dir1, xtemp + dir2] = '#')) DO
    BEGIN
      Board[ytemp + dir1, xtemp + dir2] := '#';
      ytemp := ytemp + dir1;
      xtemp := xtemp + dir2
    END
END;

PROCEDURE CheckForRook();
VAR
  dir1, dir2: INTEGER;
BEGIN
  FOR e := 1 TO r DO
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
END;


PROCEDURE CheckDiagonal(VAR dir1, dir2: INTEGER);
VAR
  ytemp, xtemp: INTEGER;
BEGIN
  xtemp := Bishop[f].x;
  ytemp := Bishop[f].y;
  WHILE ((Board[ytemp + dir1, xtemp + dir2] = '.') OR (Board[ytemp + dir1, xtemp + dir2] = '#')) DO
    BEGIN
      Board[ytemp + dir1, xtemp + dir2]:='#';
      xtemp := xtemp + dir2;
      ytemp := ytemp + dir1;
    END; 
END;

PROCEDURE CheckForBishop();
VAR
  dir1, dir2: INTEGER;
BEGIN
  FOR f:=1 TO b DO
    BEGIN
      dir1 := 1; 
      dir2 := 1;
      CheckDiagonal(dir1, dir2);
      dir2 := -1;
      CheckDiagonal(dir1, dir2);
      dir1 := -1;
      CheckDiagonal(dir1, dir2);
      dir2 := 1;
      CheckDiagonal(dir1, dir2);
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
  FOR i := 1 TO M DO
    BEGIN
      FOR j := 1 TO N DO
        BEGIN
          READ(FIn, Board[i, j]);
          IF Board[i, j] = 'B'
          THEN
            BEGIN
              b := b + 1;
              Bishop[b].x := j;
              Bishop[b].y := i
            END;
          IF Board[i, j] = 'K'
          THEN
            BEGIN
              k := k + 1;
              Knight[k].x := j;
              Knight[k].y := i
            END;
          IF Board[i, j] = 'R'
          THEN
            BEGIN
              r := r + 1;
              Rook[r].x := j;
              Rook[r].y := i
            END    
        END;      
      READLN(FIn)  
    END;
  {Вывод поля с фигурами, но без отметки клеток под боем}    
  FOR i := 1 TO M DO
    BEGIN
      FOR j := 1 TO N DO
        WRITE(Board[i, j], ' ');
      WRITELN      
    END;
   
  CheckForKnight; //Определение клеток, которые бьют Кони
  CheckForRook;   //Определение клеток, которые бьют Ладьи
  CheckForBishop; //Определение клеток, которые бьют Слоны
    
  //Вывод координат слонов    
  FOR i:=1 to b DO
    WRITE('i=', i, ': ', Bishop[i].y, ' ', Bishop[i].x, '   ');
  WRITELN;
  //Вывод координат коней  
  FOR i:=1 to k DO
    WRITE('i=', i, ': ', Knight[i].y, ' ', Knight[i].x, '   ');
  WRITELN;  
  //Вывод координат ладей
  FOR i:=1 to r DO
    WRITE('i=', i, ': ', Rook[i].y, ' ', Rook[i].x, '   ');
  WRITELN;        
  {Вывод поля с фигурами и с отмеченными клетками под боем}
  FOR i:=1 TO M DO
    BEGIN
      FOR j:=1 TO N DO
        WRITE(Board[i, j],' ');
      WRITELN      
    END; 
END.  
