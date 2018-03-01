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
  i, j, M, N, Index, r, k, d, e, f, Count: INTEGER;
  Ch: CHAR;
  FIn, FOut: TEXT;
  
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
  xtemp := Figure[e].x;
  ytemp := Figure[e].y;
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
  FOR e := 1 TO Index DO
    BEGIN
      IF (Board[Figure[e].y, Figure[e].x] = 'R') THEN
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
  {Начальные индексы для фигур:}
  Index := 0;
  k := 0;
  
  //Считывание координат всех фигур
  FOR i := 1 TO M DO
    BEGIN
      FOR j := 1 TO N DO
        BEGIN
          READ(FIn, Board[i, j]);
          IF (Board[i, j] = 'B') OR (Board[i, j] = 'R') THEN
            BEGIN
              Index := Index + 1;
              Figure[Index].x := j;
              Figure[Index].y := i
            END;
          IF (Board[i, j] = 'K') THEN
            BEGIN
              k := k + 1;
              Knight[k].x := j;
              Knight[k].y := i
            END   
        END;      
      READLN(FIn)  
    END;
  CLOSE(FIn);
    
  //Вывод поля с фигурами, но без отметки клеток под боем}    
  {FOR i := 1 TO M DO
    BEGIN
      FOR j := 1 TO N DO
        WRITE(Board[i, j], ' ');
      WRITELN      
    END;}
   
  CheckForKnight;        //Определение клеток, которые бьют Кони
  CheckForRookAndBishop; //Определение клеток, которые бьют Слоны и Ладьи
    
  //Вывод координат не слонов, а всех    
  {FOR i := 1 to Index DO
    WRITE('i=', i, ': ', Figure[i].y, ' ', Figure[i].x, '   ');
  WRITELN; }
  //Вывод координат коней  
  {FOR i:=1 to k DO
    WRITE('i=', i, ': ', Knight[i].y, ' ', Knight[i].x, '   ');
  WRITELN; } 
  //Вывод координат ладей
  {FOR i:=1 to r DO
    WRITE('i=', i, ': ', Rook[i].y, ' ', Rook[i].x, '   ');
  WRITELN;}        
  //Вывод поля с фигурами и с отмеченными клетками под боем}
  FOR i:=1 TO M DO
    BEGIN
      FOR j:=1 TO N DO
        WRITE(Board[i, j],' ');
      WRITELN      
    END;
    
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
