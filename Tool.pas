Unit Tool;

Interface

Type
    TFullName = Record
        FirstName: String[10];
        SecondName: String[10];
        MiddleName: String[15];
    End;

    TTask = Record
        Name: String[30];
        Task: String[30];
        Implementers: String[4];
        Director: String[4];
        Date: TDateTime;
        Period: Integer;
    End;

    TEmployee = Record
        Code: String[4];
        FullName: TFullName;
        Post: String[20];
        WorkingHours: Integer;
        Director: String[4];
    End;

    TPWork = ^TTaskNode;

    TTaskNode = Record
        Data: TTask;
        Next: TPWork;
        Prev: TPWork;
    End;

    TPEmployee = ^TEmployeeNode;

    TEmployeeNode = Record
        Data: TEmployee;
        Next: TPEmployee;
        Prev: TPEmployee;
    End;

    TEmployeeList = Class
    Private
        FHead: TPEmployee;
        FSize: Integer;
        FTail: TPEmployee;
    Public
        Property Size: Integer Read FSize;
        Property HBegin: TPEmployee Read FHead;
        Constructor Create();
        Destructor Destroy;
        Procedure Add(Person: TEmployee);
        Procedure Delete(Person: TEmployee);
        Procedure Clear;
        Function EmployeeExists(Emp: TEmployee): Boolean;
        Function NameExists(Name: String): Boolean;
        Function WorkerCodeExists(Code: String): Boolean;
        Function DirectorCodeExists(Code: String): Boolean;
        Function FindDirectorCode(Name: String): String;
        Function FindPrjct(Code: String): TEmployee;
        Procedure ChangePrjct(Index: Integer; E: TEmployee);
        Procedure Save(Path: String);
        Procedure Chng(Code1, Code2: String);
        Procedure DeleteWorker(Code: String);
    End;

    TTasksList = Class
    Private
        FHead: TPWork;
        FSize: Integer;
        FTail: TPWork;
    Public
        Property Size: Integer Read FSize;
        Property HBegin: TPWork Read FHead;
        Constructor Create();
        Destructor Destroy;
        Procedure Add(Work: TTask);
        Procedure Delete(Work: TTask);
        Procedure Clear;
        Function FindDirectorProject(Name: String): TTasksList;
        Function FindWorkProject(Name, Implementers: String): TTasksList;
        Function FindProjectsByDate(): TTasksList;
        Function WorkExists(Work: TTask): Boolean;
        Procedure Sort;
        Function FindWrk(TempWork: TTask): TTask;
        Procedure ChangeWork(Index: Integer; W: TTask);
        Procedure Save(Path: String);
        Procedure ChgDir(Code1, Code2: String);
        Procedure DeleteDir(Code: String);
        Procedure ChgWork(Code1, Code2: String);
        Procedure DeleteWork(Code: String);
    End;

Function Work(Name: String; Task: String; Implementers: String;
  Director: String; Date: TDateTime; Period: Integer): TTask;

Function Employee(Code: String; FullName: TFullName; Post: String;
  WorkingHours: Integer; Director: String): TEmployee;

Function WorksIsSame(Work1: TTask; Work2: TTask): Boolean;

Function EmplIsSame(Emp1: TEmployee; Emp2: TEmployee): Boolean;

Implementation

Uses Main, ListUnit;

Function FullNameIsSame(Name1, Name2: TFullName): Boolean;
Begin
    Result := (Name1.FirstName = Name2.FirstName) And
      (Name1.SecondName = Name2.SecondName) And
      (Name1.MiddleName = Name2.MiddleName);
End;

Function Work(Name: String; Task: String; Implementers: String;
  Director: String; Date: TDateTime; Period: Integer): TTask;
Var
    W: TTask;
Begin
    W.Name := Name;
    W.Task := Task;
    W.Implementers := Implementers;
    W.Director := Director;
    W.Date := Date;
    W.Period := Period;
    Result := W;
End;

Function Employee(Code: String; FullName: TFullName; Post: String;
  WorkingHours: Integer; Director: String): TEmployee;
Var
    E: TEmployee;
Begin
    E.Code := Code;
    E.FullName := FullName;
    E.Post := Post;
    E.WorkingHours := WorkingHours;
    E.Director := Director;
    Result := E;
End;

Function WorksIsSame(Work1: TTask; Work2: TTask): Boolean;
Begin
    If (Work1.Name = Work2.Name) And (Work1.Task = Work2.Task) And
      (Work1.Implementers = Work2.Implementers) And
      (Work1.Director = Work2.Director) And (Work1.Date = Work2.Date) And
      (Work1.Period = Work2.Period) Then
        Result := True
    Else
        Result := False;
End;

Function EmplIsSame(Emp1: TEmployee; Emp2: TEmployee): Boolean;
Begin
    If (Emp1.Code = Emp2.Code) And FullNameIsSame(Emp1.FullName, Emp2.FullName)
      And (Emp1.Post = Emp2.Post) And (Emp1.WorkingHours = Emp2.WorkingHours)
      And (Emp1.Director = Emp2.Director) Then
        Result := True
    Else
        Result := False;
End;
{ TEmployeeList }

Procedure TEmployeeList.Add(Person: TEmployee);
Var
    Temp, TempList: TPEmployee;
Begin
    New(Temp);
    Temp^.Data := Person;
    Temp^.Next := Nil;
    If FSize = 0 Then
    Begin
        Temp^.Prev := Nil;
        FHead := Temp;
    End
    Else
    Begin
        TempList := FHead;
        While TempList^.Next <> Nil Do
        Begin
            TempList := TempList^.Next;
        End;
        New(TempList^.Next);
        Temp^.Prev := TempList;
        TempList^.Next := Temp;
    End;
    FTail := Temp;
    Inc(FSize);
    ListForm.UpdateEmpList(FormMain.EmployeeList);
    FormMain.FSave := False;
End;

Procedure TEmployeeList.ChangePrjct(Index: Integer; E: TEmployee);
Var
    Temp: TPEmployee;
    I: Integer;
Begin
    Temp := FHead;
    If Index > 1 Then
    Begin
        For I := 1 To Index - 1 Do
        Begin
            Temp := Temp^.Next;
        End;
    End;
    Temp^.Data := E;
    ListForm.UpdateEmpList(FormMain.EmployeeList);
    FormMain.FSave := False;
End;

Procedure TEmployeeList.Chng(Code1, Code2: String);
Var
    Temp: TPEmployee;
Begin
    Temp := FHead;
    While (Temp <> Nil) Do
    Begin
        If (Temp^.Data.Director = Code1) Then
            Temp^.Data.Director := Code2;
        Temp := Temp^.Next;
    End;
End;

Procedure TEmployeeList.Clear;
Var
    Temp: TPEmployee;
Begin
    If FSize <> 0 Then
    Begin
        While FSize <> 1 Do
        Begin
            Temp := FHead;
            FHead := FHead^.Next;
            Dispose(Temp);
            Dec(FSize);
        End;
        Dispose(FHead);
        Dec(FSize);
    End;
    ListForm.UpdateEmpList(FormMain.EmployeeList);
End;

Constructor TEmployeeList.Create;
Begin
    FHead := Nil;
    FTail := Nil;
    FSize := 0;
End;

Procedure TEmployeeList.Delete(Person: TEmployee);
Var
    Temp: TPEmployee;
    Flag: Boolean;
Begin
    Temp := FHead;
    Flag := False;
    If EmplIsSame(Temp^.Data, Person) Then
    Begin
        If FSize = 1 Then
        Begin
            FHead := Nil;
            FTail := Nil;
        End
        Else
        Begin
            FHead := Temp^.Next;
            Temp^.Next^.Prev := Nil;
        End;
        Dispose(Temp);
        Dec(FSize);
        Flag := True;
    End;
    While (Temp^.Next <> Nil) And Not(Flag) Do
    Begin
        If EmplIsSame(Temp^.Data, Person) Then
        Begin
            Begin
                Temp^.Prev^.Next := Temp^.Next;
                Temp^.Next^.Prev := Temp^.Prev;
                Dispose(Temp);
                Dec(FSize);
                Flag := True;
            End;
        End
        Else
            Temp := Temp^.Next;
    End;
    If EmplIsSame(Temp^.Data, Person) And Not(Flag) Then
    Begin
        If FSize = 1 Then
        Begin
            FHead := Nil;
            FTail := Nil;
        End
        Else
        Begin
            FTail := Temp^.Prev;
            Temp^.Prev^.Next := Nil;
        End;
        Dispose(Temp);
        Dec(FSize);;
    End;
    ListForm.UpdateEmpList(FormMain.EmployeeList);
    FormMain.FSave := False;
End;

Procedure TEmployeeList.DeleteWorker(Code: String);
Var
    Temp: TPEmployee;
Begin
    Temp := FHead;
    While (Temp <> Nil) Do
    Begin
        If (Temp^.Data.Director = Code) Then
            Delete(Temp^.Data);
        Temp := Temp^.Next;
    End;
End;

Destructor TEmployeeList.Destroy;
Begin
    Clear;
End;

Function TEmployeeList.DirectorCodeExists(Code: String): Boolean;
Var
    Temp: TPEmployee;
    F: Boolean;
Begin
    Temp := FHead;
    F := False;
    While (Temp <> Nil) And Not(F) Do
    Begin
        If (Temp^.Data.Code = Code) And (Temp^.Data.Post = 'Руководитель') Then
            F := True;
        Temp := Temp^.Next;
    End;
    Result := F;
End;

Function TEmployeeList.EmployeeExists(Emp: TEmployee): Boolean;
Var
    Temp: TPEmployee;
    F: Boolean;
Begin
    Temp := FHead;
    F := False;
    While (Temp <> Nil) And Not(F) Do
    Begin
        If (Temp^.Data.Code = Emp.Code) And FullNameIsSame(Temp^.Data.FullName,
          Emp.FullName) And (Temp^.Data.Post = Emp.Post) And
          (Temp^.Data.WorkingHours = Emp.WorkingHours) And
          (Temp^.Data.Director = Emp.Director) Then
            F := True;
        Temp := Temp^.Next;
    End;
    Result := F;
End;

Function TEmployeeList.FindDirectorCode(Name: String): String;
Var
    Temp: TPEmployee;
Begin
    Temp := FHead;
    While Temp <> Nil Do
    Begin
        If (Temp^.Data.FullName.SecondName = Name) And
          (Temp^.Data.Post = 'Руководитель') Then
            Result := Temp^.Data.Code;
        Temp := Temp^.Next;
    End;
End;

Function TEmployeeList.FindPrjct(Code: String): TEmployee;
Var
    Temp: TPEmployee;
    F: Boolean;
Begin
    F := False;
    Temp := FHead;
    While Not(F) And (Temp <> Nil) Do
    Begin
        If (Temp^.Data.Code = Code) Then
            F := True
        Else
            Temp := Temp^.Next;
    End;
    Result := Temp^.Data;
End;

Function TEmployeeList.NameExists(Name: String): Boolean;
Var
    Temp: TPEmployee;
    F: Boolean;
Begin
    F := False;
    Temp := FHead;
    While (Temp <> Nil) And Not(F) Do
    Begin
        If (Temp^.Data.FullName.SecondName = Name) Then
            F := True;
        Temp := Temp^.Next;
    End;
    Result := F;
End;

Procedure TEmployeeList.Save(Path: String);
Var
    TempEmp: TPEmployee;
    EmpFile: File Of TEmployee;
Begin
    ReWrite(EmpFile, Path);
    Try
        TempEmp := FormMain.EmployeeList.HBegin;
        While TempEmp <> Nil Do
        Begin
            Write(EmpFile, TempEmp^.Data);
            TempEmp := TempEmp^.Next;
        End;
    Finally
        CloseFile(EmpFile);
    End;
End;

Function TEmployeeList.WorkerCodeExists(Code: String): Boolean;
Var
    Temp: TPEmployee;
    F: Boolean;
Begin
    F := False;
    Temp := FHead;
    While (Temp <> Nil) And Not(F) Do
    Begin
        If (Temp^.Data.Code = Code) Then
            F := True;
        Temp := Temp^.Next;
    End;
    Result := F;
End;

{ TWorkList }

Procedure TTasksList.Add(Work: TTask);
Var
    Temp, TempList: TPWork;
Begin

    // Выделение памяти для нового элемента
    New(Temp);
    // Добавление в поле информации запись о задаче
    Temp^.Data := Work;
    // Установка указателя на следующий элемент как нулевой указатель
    Temp^.Next := Nil;
    // Если длина списка равна 0
    If FSize = 0 Then
    Begin
    // Предыдущий элемент добавляемого неопеределён
        Temp^.Prev := Nil;
    // Установить голову списка на добавляемый элемент
        FHead := Temp;
    End
    // Если длина списка не равна 0
    Else
    Begin
    // Установка первоначального значения для перемещения по списку
        TempList := FHead;
    // Пока указатель на следующий элемент не нулевой указатель
        While TempList^.Next <> Nil Do
        Begin
    //Обновить указатель
            TempList := TempList^.Next;
        End;
    //Выделение памяти для элемента, следующего за последним
        New(TempList^.Next);
    // Задать новые значения для полей: предыдущий и следующий
        Temp^.Prev := TempList;
        TempList^.Next := Temp;
    End;
    //Обновить указатель на последний элемент списка
    FTail := Temp;
    // Увеличить размер списка
    Inc(FSize);
    //Обновить содержимое в таблице
    ListForm.UpdateWorkList(FormMain.WorkList);
    FormMain.FSave := False;
End;

Procedure TTasksList.ChangeWork(Index: Integer; W: TTask);
Var
    Temp: TPWork;
    I: Integer;
Begin
    Temp := FHead;
    If Index > 1 Then
    Begin
        For I := 1 To Index - 1 Do
        Begin
            Temp := Temp^.Next;
        End;
    End;
    Temp^.Data := W;
    ListForm.UpdateWorkList(FormMain.WorkList);
    FormMain.FSave := False;
End;

Procedure TTasksList.ChgDir(Code1, Code2: String);
Var
    Temp: TPWork;
Begin
    Temp := FHead;
    While Temp <> Nil Do
    Begin
        If Temp.Data.Director = Code1 Then
            Temp.Data.Director := Code2;
        Temp := Temp^.Next;
    End;
End;

Procedure TTasksList.ChgWork(Code1, Code2: String);
Var
    Temp: TPWork;
Begin
    Temp := FHead;
    While Temp <> Nil Do
    Begin
        If Temp.Data.Implementers = Code1 Then
            Temp.Data.Implementers := Code2;
        Temp := Temp^.Next;
    End;
End;

Procedure TTasksList.Clear;
Var
    Temp: TPWork;
Begin
    If FSize <> 0 Then
    Begin
        While FSize <> 1 Do
        Begin
            Temp := FHead;
            FHead := FHead^.Next;
            Dispose(Temp);
            Dec(FSize);
        End;
        Dispose(FHead);
        Dec(FSize);
    End;
    ListForm.UpdateWorkList(FormMain.WorkList);
End;

Constructor TTasksList.Create;
Begin
    FHead := Nil;
    FTail := Nil;
    FSize := 0;
End;

Procedure TTasksList.Delete(Work: TTask);
Var
    Temp: TPWork;
    Flag: Boolean;
Begin
    //Установка указателя перемещения на начальный элемент списка
    Temp := FHead;
    Flag := False;
    //Если промежуточный элемент равен исходному
    If WorksIsSame(Temp^.Data, Work) Then
    Begin
    //Если список состоит из одного элмента
        If FSize = 1 Then
        Begin
    //Устанавливаем начало и конец списка на нулевой указатель
            FHead := Nil;
            FTail := Nil;
        End
    //Изменить начальный элемент
        Else
        Begin
            FHead := Temp^.Next;
            Temp^.Next^.Prev := Nil;
        End;
    //Освободить память временного элемента
        Dispose(Temp);
    //Уменьшить длину списка
        Dec(FSize);
    //Установить флаг поиска в истину
        Flag := True;
    End;
    //Пока следующий элемент не является нулевым указателем или флаг поиска ложный
    While (Temp^.Next <> Nil) And Not(Flag) Do
    Begin
    //Если промежуточный элемент равен исходному
        If WorksIsSame(Temp^.Data, Work) Then
        Begin
            Begin
    //Изменить указатели на следующий и предыдущий элемент
                Temp^.Prev^.Next := Temp^.Next;
                Temp^.Next^.Prev := Temp^.Prev;
                Temp := Temp^.Next;
    //Освободить память временного элемента
                Dispose(Temp^.Prev);
    //Уменьшить длину списка
                Dec(FSize);
    //Установить флаг поиска в истину
                Flag := True;
            End;
        End
        Else
            Temp := Temp^.Next;
    End;
    //Промежуточный элемент равен исходному и флаг поиска ложный
    If WorksIsSame(Temp^.Data, Work) And Not(Flag) Then
    Begin
    //Если список состоит из одного элмента
        If FSize = 1 Then
        Begin
    //Устанавливаем начало и конец списка на нулевой указатель
            FHead := Nil;
            FTail := Nil;
        End
        Else
    //Изменить начальный элемент
        Begin
            FTail := Temp^.Prev;
            Temp^.Prev^.Next := Nil;
        End;
    //Освободить память временного элемента
        Dispose(Temp);
    //Уменьшить длину
        Dec(FSize);
    End;
    //Обновить отображаемый список
    ListForm.UpdateWorkList(FormMain.WorkList);
    FormMain.FSave := False;
End;

Procedure TTasksList.DeleteDir(Code: String);
Var
    Temp: TPWork;
Begin
    Temp := FHead;
    While Temp <> Nil Do
    Begin
        If Temp.Data.Director = Code Then
            Delete(Temp.Data);
        Temp := Temp^.Next;
    End;
End;

Procedure TTasksList.DeleteWork(Code: String);
Var
    Temp: TPWork;
Begin
    Temp := FHead;
    While Temp <> Nil Do
    Begin
        If Temp.Data.Implementers = Code Then
            Delete(Temp.Data);
        Temp := Temp^.Next;
    End;
End;

Destructor TTasksList.Destroy;
Begin
    Clear;
End;

Function TTasksList.FindDirectorProject(Name: String): TTasksList;
Var
    FindingProject: TTasksList;
    TempPTask: TPWork;
Begin
    FindingProject := TTasksList.Create;
    TempPTask := FHead;
    While TempPTask <> Nil Do
    Begin
        If TempPTask^.Data.Name = Name Then
        Begin
            FindingProject.Add(TempPTask^.Data);
        End;
        TempPTask := TempPTask^.Next;
    End;
    Result := FindingProject;
End;

Function TTasksList.FindProjectsByDate(): TTasksList;
Var
    L: TTasksList;
    Temp: TPWork;
Begin
    L := TTasksList.Create;
    Temp := FHead;
    While Temp <> Nil Do
    Begin
        If Temp^.Data.Period < 32 Then
        Begin
            L.Add(Temp^.Data);
        End;
        Temp := Temp^.Next;
    End;
    Result := L;
End;


Function TTasksList.FindWorkProject(Name, Implementers: String): TTasksList;
Var
    L: TTasksList;
    Temp: TPWork;
Begin
    L := TTasksList.Create;
    Temp := FHead;
    While Temp <> Nil Do
    Begin
        If (Temp^.Data.Implementers = Implementers) And
          (Temp^.Data.Name = Name) Then
        Begin
            L.Add(Temp^.Data);
        End;
        Temp := Temp^.Next;
    End;
    If L.Size > 1 Then
        L.Sort;
    Result := L;
End;

Function TTasksList.FindWrk(TempWork: TTask): TTask;
Var
    Temp: TPWork;
    F: Boolean;
Begin
    F := False;
    Temp := FHead;
    While Not(F) And (Temp <> Nil) Do
    Begin
        If (Temp.Data.Implementers = TempWork.Implementers) And
          (Temp.Data.Name = TempWork.Name) And (Temp.Data.Task = TempWork.Task)
          And (Temp.Data.Director = TempWork.Director) And
          (Temp.Data.Date = TempWork.Date) And
          (Temp.Data.Period = TempWork.Period) Then
            F := True
        Else
            Temp := Temp^.Next;
    End;
    Result := Temp^.Data;
End;

Procedure TTasksList.Save(Path: String);
Var
    WorkFile: File Of TTask;
    TempWork: TPWork;
Begin
    ReWrite(WorkFile, Path);
    Try
        TempWork := FormMain.WorkList.HBegin;
        While TempWork <> Nil Do
        Begin
            Write(WorkFile, TempWork^.Data);
            TempWork := TempWork^.Next;
        End;
    Finally
        CloseFile(WorkFile);
    End;
End;

Procedure TTasksList.Sort;
Var
    Temp: TPWork;
    TempWork: TTask;
    I, J: Integer;
Begin
    For I := 1 To FSize Do
    Begin
        Temp := FHead;
        For J := 1 To FSize - 1 Do
        Begin
            If (Temp^.Data.Date + Temp^.Data.Period > Temp^.Next^.Data.Date +
              Temp^.Next^.Data.Period) Then
            Begin
                TempWork := Temp^.Next^.Data;
                Temp^.Next^.Data := Temp^.Data;
                Temp^.Data := TempWork;
            End;
            Temp := Temp^.Next;
        End;
    End;
End;

Function TTasksList.WorkExists(Work: TTask): Boolean;
Var
    Temp: TPWork;
    F: Boolean;
Begin
    F := False;
    Temp := FHead;
    While (Temp <> Nil) And Not(F) Do
    Begin
        If (Temp^.Data.Name = Work.Name) And (Temp^.Data.Task = Work.Task) And
          (Temp^.Data.Implementers = Work.Implementers) And
          (Temp^.Data.Director = Work.Director) And
          (Temp^.Data.Date = Work.Date) And
          (Temp^.Data.Period = Work.Period) Then
            F := True;
        Temp := Temp^.Next;
    End;
    Result := F;
End;

End.
