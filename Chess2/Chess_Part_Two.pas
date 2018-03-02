{ 14.16 Шахматы 2 (5)
  Шахматная доска состоит из M строк и N столбцов (1 <= M, N <= 15).
  На доске расставлены кони, слоны и ладьи. По заданному расположению фигур 
  требуется определить количество клеток доски, находящихся под боем.
  Клетки, занятые фигурами, не учитываются. }
  
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
  {Начальные индексы для фигур}
  RBIndex := 0; //для Слонов и Ладей
  KIndex := 0;  //для Коней
  
  //Считывание координат всех фигур
  FOR i := 1 TO M DO
    BEGIN
      FOR j := 1 TO N DO
        BEGIN
          READ(FIn, Board[i, j]);
          //Считывание координат Слонов и Ладей
          IF (Board[i, j] = 'B') OR (Board[i, j] = 'R') THEN
            BEGIN
              RBIndex := RBIndex + 1;
              Figure[RBIndex].x := j;
              Figure[RBIndex].y := i
            END;
          //Считывание координат Коней  
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
    
  //Вывод в консоль поля с фигурами, но без отметки клеток под боем}    
  {FOR i := 1 TO M DO
    BEGIN
      FOR j := 1 TO N DO
        WRITE(Board[i, j], ' ');
      WRITELN      
    END;}
   
  CheckForKnight;        //Определение клеток, которые бьют Кони
  CheckForRookAndBishop; //Определение клеток, которые бьют Слоны и Ладьи
    
          
  //Вывод в консоль поля с фигурами и с отмеченными клетками под боем}
  {FOR i:=1 TO M DO
    BEGIN
      FOR j:=1 TO N DO
        WRITE(Board[i, j],' ');
      WRITELN      
    END;}
  
  //Проход полученного массива с подсчетом количества клеток под боем  
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
