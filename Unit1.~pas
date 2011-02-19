unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ArrayS, ToolWin, ComCtrls, XPMan, ActnMan,
  ActnCtrls, ActnMenus;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Classes: TGroupBox;
    CheckCar: TCheckBox;
    CheckCarForSale: TCheckBox;
    CheckUsedCar: TCheckBox;
    CheckNewCar: TCheckBox;
    CheckMotorcycle: TCheckBox;
    ListBox1: TListBox;
    Quit: TButton;
    TestMemo: TMemo;
    Label6: TLabel;
    StatusBar1: TStatusBar;
    GlobalPageControl: TPageControl;
    WorkTab: TTabSheet;
    SettingsTab: TTabSheet;
    WorkPageControl: TPageControl;
    SQLTab: TTabSheet;
    ClearButton: TButton;
    SQLToBucket: TButton;
    GeneratedQuery: TMemo;
    Attribs: TGroupBox;
    Model: TCheckBox;
    SearchModel: TEdit;
    SearchCategory: TEdit;
    Category: TCheckBox;
    Year: TCheckBox;
    Price: TCheckBox;
    CheckAll: TCheckBox;
    GenerateButton: TButton;
    GroupBox1: TGroupBox;
    ProductReview: TCheckBox;
    SellerContact: TCheckBox;
    Restrictions: TGroupBox;
    YearCaption: TLabel;
    PriceCaption: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Restriction1min: TComboBox;
    Restriction2min: TComboBox;
    Restriction1max: TComboBox;
    Restriction2max: TComboBox;
    SetRestrictionsToAny: TButton;
    RestrictionInc1max: TCheckBox;
    RestrictionInc2max: TCheckBox;
    RestrictionInc1min: TCheckBox;
    RestrictionInc2min: TCheckBox;
    TestMemo2: TMemo;
    CreateBucket: TButton;
    ClearLog: TButton;
    ClassList: TCheckListBox;
    BucketTab: TTabSheet;
    SettingsPageControl: TPageControl;
    SourcesTab: TTabSheet;
    QueryPlanTab: TTabSheet;
    ResultsTab: TTabSheet;
    CapabilitiesTab: TTabSheet;
    ClassesTab: TTabSheet;
    procedure ListBox1Click(Sender: TObject);
    procedure QuitClick(Sender: TObject);
    procedure CheckCarClick(Sender: TObject);
    procedure GenerateButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure SearchModelEnter(Sender: TObject);
    procedure SearchModelExit(Sender: TObject);
    procedure SearchCategoryEnter(Sender: TObject);
    procedure SearchCategoryExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ModelClick(Sender: TObject);
    procedure CategoryClick(Sender: TObject);
    procedure CheckAllClick(Sender: TObject);
    procedure CheckCarForSaleClick(Sender: TObject);
    procedure CheckUsedCarClick(Sender: TObject);
    procedure CheckNewCarClick(Sender: TObject);
    procedure SetRestrictionsToAnyClick(Sender: TObject);
    procedure CreateBucketClick(Sender: TObject);
    procedure ClearLogClick(Sender: TObject);
    procedure SQLToBucketClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  GeneratedQueryString: AnsiString;
  NewQueryString: AnsiString;
  QueryCount: integer;

  StartMemory: integer;

  i,q,c,count: integer;

  ArrSourceCapabilities: array [1..10] of AnsiString;  // ВВОД: возможности источников
  ArrQueryWhat: array [1..10] of AnsiString; // Что будем выбирать - какие поля в таблицах источников
  StrQueryWhat: AnsiString;  // Строковое значение полей для SQL-запроса
  ArrSourceClass: array [1..10] of AnsiString; // ВВОД: список исходных классов, возможных в источниках
  ArrQueryClass: array [1..10] of AnsiString; // Какие выбираем классы
  StrQueryClass: AnsiString;  // Строковое значение классов для SQL-запроса
  ArrQueryRestrictions: array [1..10] of AnsiString; // Пользовательские ограничения для запроса
  StrQueryRestrictions: AnsiString;  // Строковое значение ограничений для SQL-запроса
  ArrQuerySearches: array [1..10] of AnsiString;  // Пользовательские ограничения для текстовых полей - текстовый поиск для запроса
  StrQuerySearches: AnsiString;  // Строковое значение поиска для SQL-запроса

  ArrDisjointClasses: array [1..6,1..6] of integer; // Таблица отношений классов - бинарные джойнт и дисджойнт
  ArrDisjointClassesMatrix: IMltArray; // Ассоциативный массив бинарных отношений, стоится на Таблице отношений классов и Списке исходных классов
                                       // Формат ArrDisjointClassesMatrix[classname1][classname2] = DjointOrNot{0,1}


  IntArr: IIntArray;
  StrArr: IStrArray;
  VarArr: IVarArray;
  MltArr: IMltArray;

  
  Source1: IMltArray; // Описания Источников
  Source2: IMltArray; // Формат Source#['inclass'][i] = ArrSourceClass[j]; // = Motorcycle;
  Source3: IMltArray; // Формат Source#['capability'][i] = ArrSourceCapabilities[j]; // = SellerContact;
  Source4: IMltArray; // Формат (обязательное значение) Source#['name'][0] = 'Motorcycles for sale'; // SOURCE NAME
  Source5: IMltArray;
  SourceClassesCapabilities: IMltArray; // Описание Классов.
                                        // Формат SourceClassesCapabilities[ArrSourceClass[j]][i] =  ArrSourceCapabilities[k]; //= Model;


  Sources: array [1..100] of IMltArray; // Список всех Источников - для циклов

  Bucket: array [1..100] of Integer;  // Ведро с номерами источников. Источники, отобранные для текущего запроса
                                      // Формат Bucket[i] = Source_number , где Source_number = k из Sources[k]
//SourceBucketRating: array [1..100] of integer; // Ретинг Источников для сортировки и выполнения в порядке понижения рейтинга
                                                 // Считается из разности в Ограничениях, из количества совпадений полей в Запросе и Источнике


  SourceRestrictions: IMltArray; // ВВОД: ограничения в источниках
                                 // Формат SourceRestrictions[Source#['name'][0]][ArrSourceCapabilities[j]][<,>,=,>=,<=] = IntValue // = 20000, = 1950

  ArrQueryRestrictionsMatrix:  IMltArray; // Ограничения в Запросе в виде ассоциативного массива - для обработки в Ведре
                                          // Формат ArrQueryRestrictionsMatrix[ArrQueryRestrictions[i]]['>,<,=,>=,<='] = IntValue // = 2000, = 1960



implementation

{$R *.dfm}

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  Edit1.Text:=ListBox1.Items[ListBox1.ItemIndex];
end;

procedure TForm1.QuitClick(Sender: TObject);
begin
close;
end;

procedure TForm1.CheckCarClick(Sender: TObject);
begin
      // Если отмечается Car, отмечаются все вложенные классы
      if CheckCar.Checked = true
      then
        begin
        CheckCarForSale.Checked := true;
        CheckUsedCar.checked := true;
        CheckNewCar.Checked := true;
        end;
      
end;

procedure TForm1.GenerateButtonClick(Sender: TObject);
var CanEquals: String;
CurrentMemory,kick: integer;
begin
      // Очистка значений по умолчанию (заглушек)
       if SearchCategory.Text = '<Category>'
       then SearchCategory.Clear;
       if SearchModel.Text = '<Name of Model>'
       then SearchModel.Clear;

       StrQueryRestrictions := '';
       StrQueryClass := '';
       StrQuerySearches := '';

      // Проверка минимумов и максимумов всех ограничений
       for i:=1 to high(ArrQueryRestrictions) do
       begin
          if (((FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text = 'any') OR ((FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text = 'any'))
          then break
          else begin
            if ((FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text > (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text) then
            begin
            // Если пользователь указал бред. Например, что ему надо больше 100, но меньше 10
            Application.MessageBox ('Maximum of restriction > restriction minimum', 'Restriction Error', mb_Ok + mb_IconExclamation);
            exit;
            end;
          end;
       end;



      // Оформление номера сгенерированного запроса
      NewQueryString :=  '------ WroldView SQL Query #' + IntToStr(QueryCount) + ' ------';
      GeneratedQuery.Lines.Add(NewQueryString);

// Генерирование SQL запроса
   // ---НАЧАЛО СБОРА ЦЕЛЕВЫХ ПОЛЕЙ ArrQueryWhat[]---
      c := 0; // счетчик для массива ArrQueryWhat[]
      // Определяем, где установлены флажки. Поля - из массива ArrSourceCapabilities, имена чекбоксов должны совпадать с полями в массиве
      for q:=1 to high(ArrSourceCapabilities) do
      begin
        if (ArrSourceCapabilities[q]<>'') then
        begin
          if (FindComponent(ArrSourceCapabilities[q]) as TCheckBox).Checked = true
          then begin
          c := c + 1;
          // Добавляем отмеченые чекбоксами поля в массив ArrQueryWhat[]
          ArrQueryWhat[c] := ArrSourceCapabilities[q];
          end;
        end;
        if (c = 0) then ArrQueryWhat[1] := '*';
      end;
      q:=0; c:=0;

      i:=0;


      // Подсчитаем количество непустых элементов в массиве
      count := 0;
      for i:=1 to high(ArrQueryWhat) do if ArrQueryWhat[i]<>'' then count := count + 1;

      // Собираем поля, которые надо будет выбрать - select WHAT from ...
      for i:=1 to count do
        begin
          if (ArrQueryWhat[i]<>'') then StrQueryWhat := StrQueryWhat + ArrQueryWhat[i];
          if (ArrQueryWhat[i+1]<>'') then StrQueryWhat := StrQueryWhat + ', ';
        end;
        // TestMemo.Lines.Add(StrQueryWhat);
   // ---КОНЕЦ СБОРА ЦЕЛЕВЫХ ПОЛЕЙ StrQueryWhat---





   // ---НАЧАЛО СБОРА ОГРАНИЧЕНИЙ (RESTRICTIONS) ArrQueryRestrictions[]---
      //ArrQueryRestrictions[1] := 'Year';
      //ArrQueryRestrictions[2] := 'Price';

      ArrQueryRestrictionsMatrix := CreateArray; // Матрица ограничений пользователя ArrQueryRestrictionsMatrix[restrictionname][<>=]=value

      // Подсчитаем количество непустых элементов в массиве
      count := 0;
      for i:=1 to high(ArrQueryRestrictions) do if ArrQueryRestrictions[i]<>'' then count := count + 1;

      // Кодирование в SQL
      CanEquals:='';
      kick:=0;
      for i:=1 to count do
      begin
      if ((FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text = 'any') AND ((FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text = 'any')
          then
            begin
            kick := kick +1;
            if (kick = count) then StrQueryRestrictions := '';  // Если везде стоит any
            end
          else begin
              if ((FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text = 'any')
              then begin
              if (StrQueryRestrictions <> '') then begin StrQueryRestrictions := StrQueryRestrictions + ' AND ';  end;
              if ((FindComponent('RestrictionInc' + IntToStr(i) + 'max') as TCheckBox).Checked = true) then CanEquals:= '=';
              StrQueryRestrictions := StrQueryRestrictions +  ' ' + ArrQueryRestrictions[i] + '<' + CanEquals + (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text;

              // добавляем ограничение в матрицу для дальнейшей обработки в ведре
              ArrQueryRestrictionsMatrix[ArrQueryRestrictions[i]]['<'+ CanEquals].AsString := (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text;
              // Пишем в лог о том, что добавлено ограничение
              TestMemo2.Lines.Add('Restriction added: [' + ArrQueryRestrictions[i] + '][<' + CanEquals + '] = ' + (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text);

              CanEquals:='';
              end;

              if ((FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text = 'any')
              then begin
              if (StrQueryRestrictions <> '') then begin StrQueryRestrictions := StrQueryRestrictions + ' AND '; end;
              if ((FindComponent('RestrictionInc' + IntToStr(i) + 'min') as TCheckBox).Checked = true) then begin CanEquals := '='; end;
              StrQueryRestrictions := StrQueryRestrictions + ' ' + ArrQueryRestrictions[i] + '>' + CanEquals + (FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text;

              // добавляем ограничение в матрицу для дальнейшей обработки в ведре
              ArrQueryRestrictionsMatrix[ArrQueryRestrictions[i]]['>'+ CanEquals].AsString := (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text;
              // Пишем в лог о том, что добавлено ограничение
              TestMemo2.Lines.Add('Restriction added: [' + ArrQueryRestrictions[i] + '][>' + CanEquals + '] = ' + (FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text);

              CanEquals:='';
              end;

              if ((FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text <> 'any') AND ((FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text <> 'any')
              then begin
              if (StrQueryRestrictions <> '') then begin StrQueryRestrictions := StrQueryRestrictions + ' AND ';  end;
              if ((FindComponent('RestrictionInc' + IntToStr(i) + 'max') as TCheckBox).Checked = true) AND ((FindComponent('RestrictionInc' + IntToStr(i) + 'min') as TCheckBox).Checked = true) then begin CanEquals := '='; end;
              StrQueryRestrictions := StrQueryRestrictions + ArrQueryRestrictions[i] + '>' + CanEquals + (FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text + ' AND ' + ArrQueryRestrictions[i] + '<' + CanEquals + (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text;

              // добавляем ограничение в матрицу для дальнейшей обработки в ведре
              ArrQueryRestrictionsMatrix[ArrQueryRestrictions[i]]['>'+ CanEquals].AsString := (FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text;
              ArrQueryRestrictionsMatrix[ArrQueryRestrictions[i]]['<'+ CanEquals].AsString := (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text;
              // Пишем в лог о том, что добавлено ограничение
              TestMemo2.Lines.Add('Restriction added: [' + ArrQueryRestrictions[i] + '][>' + CanEquals + '] = ' + (FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text);
              TestMemo2.Lines.Add('Restriction added: [' + ArrQueryRestrictions[i] + '][<' + CanEquals + '] = ' + (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text);

              CanEquals:='';
              end;
          end;
      end;
   // ---КОНЕЦ СБОРА ОГРАНИЧЕНИЙ (RESTRICTIONS) StrQueryRestrictions---


   // ---НАЧАЛО ПОИСКА StrQuerySearches---


      // Подсчитаем количество непустых элементов в массиве
      count := 0;
      for i:=0 to high(ArrQuerySearches) do begin if ArrQuerySearches[i]<>'' then count := count + 1; end;

      // Ищем текстовые ограничения, добавляем в строковый параметр
      for i:=1 to count do begin
        if ((FindComponent('Search' + ArrQuerySearches[i]) as TEdit).Text <> '') AND ((FindComponent(ArrQuerySearches[i]) as TCheckBox).Checked = true)
              then begin
                  if (StrQueryRestrictions <> '') OR (StrQuerySearches <> '') then StrQuerySearches := StrQuerySearches + ' AND ';
                  StrQuerySearches := StrQuerySearches + ArrQuerySearches[i] + ' LIKE ' + '''%' + (FindComponent('Search' + ArrQuerySearches[i]) as TEdit).Text + '%'' ';
                  //if (ArrQuerySearches[i+1] <> '') then StrQuerySearches := StrQuerySearches + ' AND ';

              end;
      end;
    //  TestMemo.Lines.Add(StrQuerySearches);
   // ---КОНЕЦ ПОИСКА StrQuerySearches---


      // ---НАЧАЛО СБОРА ЦЕЛЕВЫХ КЛАССОВ (ТИПОВ) ArrQueryClass[]---

      ClassList.MultiSelect := true; // для правильной обработки
      // Подсчитаем количество непустых элементов в массиве
      q := 0;
      count := 0;
      for i:=1 to high(ArrSourceClass) do begin if ArrSourceClass[i]<>'' then count := count + 1; end;

      for i:=0 to (ClassList.Items.Count-1) do begin
         if (ClassList.Checked[i] = true) then
         begin
         q := q + 1;
         ArrQueryClass[q] := ArrSourceClass[i+1];
         //TestMemo.Lines.Add(ArrSourceClass[i+1] + ' checked');
         end;
      end;

      // Кодирование в SQL
      if (ClassList.SelCount >= 0) then
      begin
          for i:=1 to q do begin
              if ((StrQueryClass = '') AND ((StrQueryRestrictions <> '') OR (StrQuerySearches <> ''))) then
              begin
              StrQueryClass := StrQueryClass + ' AND ';
              end;

              if (StrQueryClass <> '') AND (StrQueryClass <> ' AND ') then
              begin
              StrQueryClass := StrQueryClass + ' OR ';
              end;

              StrQueryClass := StrQueryClass + 'type = ''' + ArrQueryClass[i] + ''' ';
          end;
      end;

     // TestMemo.Lines.Add(StrQueryClass);


   // ---КОНЕЦ СБОРА ЦЕЛЕВЫХ КЛАССОВ (ТИПОВ) StrQueryClass---





      // Собираем готовый SQL запрос
      GeneratedQueryString := 'SELECT ' + StrQueryWhat + ' FROM WorldView';
      if ((StrQueryRestrictions <> '') OR (StrQueryClass <> '') OR (StrQuerySearches <> '')) then GeneratedQueryString := GeneratedQueryString + ' WHERE ';
          // добавляем ограничения
      if (StrQueryRestrictions <> '') then GeneratedQueryString := GeneratedQueryString + StrQueryRestrictions;
          // добавляем поисковые строки
      if (StrQuerySearches <> '') then GeneratedQueryString := GeneratedQueryString + StrQuerySearches;
          // добавляем классы
      if (StrQueryClass <> '') then GeneratedQueryString := GeneratedQueryString + StrQueryClass;

      // Выводим готовый SQL запрос
      GeneratedQuery.Lines.Add(GeneratedQueryString);

      // Следующий номер запроса (только для отображения в программе)
      QueryCount:=QueryCount+1;

      // Опустошим массив и строки на всякий случай для следующих запросов
      for i:=1 to length(ArrQueryWhat) do
      begin
          ArrQueryWhat[i] := '';
      end;
      StrQueryWhat := '';

      // Поставим обратно заглушки, если пользователь так ничего и не вписал
      if SearchCategory.Text = ''
       then SearchCategory.Text := '<Category>';
      if SearchModel.Text = ''
       then SearchModel.Text := '<Name of Model>';


CurrentMemory := AllocMemSize - StartMemory;
StatusBar1.SimpleText := 'Memory leak after Generating SQL: ' + IntToStr(CurrentMemory) + ' bytes';

end;

procedure TForm1.ClearButtonClick(Sender: TObject);
begin
GeneratedQuery.Clear;
end;

procedure TForm1.SearchModelEnter(Sender: TObject);
begin
       if SearchModel.Text = '<Name of Model>'
       then SearchModel.Clear;
end;

procedure TForm1.SearchModelExit(Sender: TObject);
begin
       if SearchModel.Text = ''
       then SearchModel.Text:='<Name of Model>';
end;

procedure TForm1.SearchCategoryEnter(Sender: TObject);
begin
         if SearchCategory.Text = '<Category>'
       then SearchCategory.Clear;
end;

procedure TForm1.SearchCategoryExit(Sender: TObject);
begin
            if SearchCategory.Text = ''
       then SearchCategory.Text:='<Category>';
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  CurrentMemory,EndMemory,j,k: integer;
begin
 StartMemory := AllocMemSize;
 StatusBar1.SimpleText := 'Memory allocated at start: ' + IntToStr(StartMemory) + ' bytes';
 if Category.Checked = false
 then SearchCategory.Enabled := false;

 if Model.Checked = false
 then SearchModel.Enabled := false;

// ВВОД: ОПИСАНИЕ ВХОДНЫХ ДАННЫХ
      // Массив со всеми возможными полями источников, все возможности источников
      ArrSourceCapabilities[1] := 'Model';
      ArrSourceCapabilities[2] := 'Category';
      ArrSourceCapabilities[3] := 'Year';
      ArrSourceCapabilities[4] := 'Price';
      ArrSourceCapabilities[5] := 'SellerContact';
      ArrSourceCapabilities[6] := 'ProductReview';

      // Массив со всеми возможными классами в источниках
      ArrSourceClass[1] := 'Car';
      ArrSourceClass[2] := 'CarForSale';
      ArrSourceClass[3] := 'UsedCar';
      ArrSourceClass[4] := 'NewCar';
      ArrSourceClass[5] := 'Motorcycle';
      ArrSourceClass[6] := 'Product';

          // Загружаем классы  в ListBox
          for i:=1 to high(ArrSourceClass) do begin
               if (ArrSourceClass[i] <> '') then
               ClassList.Items.Add('(' + IntToStr(i) + ') ' + ArrSourceClass[i]);
          end;

      // Djoint and Disjoint classes
      ArrDisjointClasses[1,1]:= 1;
      ArrDisjointClasses[1,2]:= 1;
      ArrDisjointClasses[1,3]:= 1;
      ArrDisjointClasses[1,4]:= 1;
      ArrDisjointClasses[1,5]:= 0;
      ArrDisjointClasses[1,6]:= 1;
      ArrDisjointClasses[2,1]:= 1;
      ArrDisjointClasses[2,2]:= 1;
      ArrDisjointClasses[2,3]:= 1;
      ArrDisjointClasses[2,4]:= 1;
      ArrDisjointClasses[2,5]:= 0;
      ArrDisjointClasses[2,6]:= 1;
      ArrDisjointClasses[3,1]:= 1;
      ArrDisjointClasses[3,2]:= 1;
      ArrDisjointClasses[3,3]:= 1;
      ArrDisjointClasses[3,4]:= 0;
      ArrDisjointClasses[3,5]:= 0;
      ArrDisjointClasses[3,6]:= 0;
      ArrDisjointClasses[4,1]:= 1;
      ArrDisjointClasses[4,2]:= 1;
      ArrDisjointClasses[4,3]:= 0;
      ArrDisjointClasses[4,4]:= 1;
      ArrDisjointClasses[4,5]:= 0;
      ArrDisjointClasses[4,6]:= 1;
      ArrDisjointClasses[5,1]:= 0;
      ArrDisjointClasses[5,2]:= 0;
      ArrDisjointClasses[5,3]:= 0;
      ArrDisjointClasses[5,4]:= 0;
      ArrDisjointClasses[5,5]:= 1;
      ArrDisjointClasses[6,1]:= 1;
      ArrDisjointClasses[6,2]:= 1;
      ArrDisjointClasses[6,3]:= 1;
      ArrDisjointClasses[6,4]:= 1;
      ArrDisjointClasses[6,5]:= 1;
      ArrDisjointClasses[6,6]:= 1;

      // Массив со всеми возможными ограничениями в Запросе
      ArrQueryRestrictions[1] := 'Year';
      ArrQueryRestrictions[2] := 'Price';

      // Массив с полями, которые ищутся строковыми запросами
      ArrQuerySearches[1] := 'Model';
      ArrQuerySearches[2] := 'Category';
      ArrQuerySearches[3] := 'ProductReview';

      // Альтернативная запись таблицы отношений классов - в ассоциативном массиве.
      ArrDisjointClassesMatrix := CreateArray;
      for j:=1 to high (ArrSourceClass) do
      begin
         if (ArrSourceClass[j] <> '') then
         begin
            for k:=1 to high (ArrSourceClass) do
            begin
                 if (ArrSourceClass[k] <> '') then
                 begin
                      ArrDisjointClassesMatrix[ArrSourceClass[j]][ArrSourceClass[k]].AsInteger := ArrDisjointClasses[j,k];
                      TestMemo2.Lines.Add('[' + ArrSourceClass[j] + '][' + ArrSourceClass[k] + '] = ' + IntToStr(ArrDisjointClassesMatrix[ArrSourceClass[j]][ArrSourceClass[k]].AsInteger));
                 end
                 else break;
            end;
          end
          else break;
      end;


// ОПИСАНИЕ ИСТОЧНИКОВ
      Source1 := CreateArray;
      Source2 := CreateArray;
      Source3 := CreateArray;
      Source4 := CreateArray;
      Source5 := CreateArray;
      SourceRestrictions := CreateArray;

      Sources[1] := Source1;
      Sources[2] := Source2;
      Sources[3] := Source3;
      Sources[4] := Source4;
      Sources[5] := Source5;

      Source1.Clear;
      Source1['inclass'][1].AsString := ArrSourceClass[2]; // = CarForSale;
      Source1['inclass'][2].AsString := ArrSourceClass[3]; // = UsedCar;
      Source1['name'][0].AsString := 'Used cars for sale'; // SOURCE NAME

      Source2.Clear;
      Source2['inclass'][1].AsString := ArrSourceClass[2]; // = CarForSale;
      Source2['name'][0].AsString := 'Lux cars for sale'; // SOURCE NAME

      Source3.Clear;
      Source3['inclass'][1].AsString := ArrSourceClass[2]; // = CarForSale;
      Source3['name'][0].AsString := 'Vintage cars for sale'; // SOURCE NAME

      Source4.Clear;
      Source4['inclass'][1].AsString := ArrSourceClass[5]; // = Motorcycle;
      Source4['capability'][1].AsString := ArrSourceCapabilities[5]; // = SellerContact;
      Source4['capability'][2].AsString := ArrSourceCapabilities[4]; // = Price;
      Source4['name'][0].AsString := 'Motorcycles for sale'; // SOURCE NAME

      Source5.Clear;
      Source5['inclass'][1].AsString := ArrSourceClass[6]; // = Product;
      Source5['capability'][3].AsString := ArrSourceCapabilities[6]; // = ProductReview;
      Source5['name'][0].AsString := 'Car reviews'; // SOURCE NAME

        // Ограничения источников формат SourceRestrictions[source][capability][<,>,=,>=,<=] = value
        SourceRestrictions[Source2['name'][0].AsString][ArrSourceCapabilities[4]]['>='].AsInteger := 20000;  // = Price;
        SourceRestrictions[Source3['name'][0].AsString][ArrSourceCapabilities[3]]['<='].AsInteger := 1950;  // = Year;

// ОПИСАНИЕ КЛАССОВ SourceClassesCapabilities[classname][i] = capability
      SourceClassesCapabilities := CreateArray;

      // Class CAR
      SourceClassesCapabilities[ArrSourceClass[1]][1].AsString :=  ArrSourceCapabilities[1]; //= Model;
      SourceClassesCapabilities[ArrSourceClass[1]][2].AsString :=  ArrSourceCapabilities[3]; //= Year;
      SourceClassesCapabilities[ArrSourceClass[1]][3].AsString :=  ArrSourceCapabilities[2]; //= Category;

      // Class CarForSale
      SourceClassesCapabilities[ArrSourceClass[2]][1].AsString :=  ArrSourceCapabilities[1]; //= Model;
      SourceClassesCapabilities[ArrSourceClass[2]][2].AsString :=  ArrSourceCapabilities[3]; //= Year;
      SourceClassesCapabilities[ArrSourceClass[2]][3].AsString :=  ArrSourceCapabilities[2]; //= Category;
      SourceClassesCapabilities[ArrSourceClass[2]][4].AsString :=  ArrSourceCapabilities[5]; //= SellerContact;
      SourceClassesCapabilities[ArrSourceClass[2]][5].AsString :=  ArrSourceCapabilities[4]; //= Price;

      // Class UsedCar
      SourceClassesCapabilities[ArrSourceClass[3]][1].AsString :=  ArrSourceCapabilities[1]; //= Model;
      SourceClassesCapabilities[ArrSourceClass[3]][2].AsString :=  ArrSourceCapabilities[3]; //= Year;
      SourceClassesCapabilities[ArrSourceClass[3]][3].AsString :=  ArrSourceCapabilities[2]; //= Category;

      // Class NewCar
      SourceClassesCapabilities[ArrSourceClass[4]][1].AsString :=  ArrSourceCapabilities[1]; //= Model;
      SourceClassesCapabilities[ArrSourceClass[4]][2].AsString :=  ArrSourceCapabilities[3]; //= Year;
      SourceClassesCapabilities[ArrSourceClass[4]][3].AsString :=  ArrSourceCapabilities[2]; //= Category;

      // Class Motorcycle
      SourceClassesCapabilities[ArrSourceClass[5]][1].AsString :=  ArrSourceCapabilities[1]; //= Model;
      SourceClassesCapabilities[ArrSourceClass[5]][2].AsString :=  ArrSourceCapabilities[3]; //= Year;

      // Class Product
      SourceClassesCapabilities[ArrSourceClass[6]][1].AsString :=  ArrSourceCapabilities[1]; //= Model;
      SourceClassesCapabilities[ArrSourceClass[6]][2].AsString :=  ArrSourceCapabilities[3]; //= Year;



end;

procedure TForm1.ModelClick(Sender: TObject);
begin
  // Если не отмечена галочка, то поле неактивно
 if Model.Checked = true
 then SearchModel.Enabled := true;
  if Model.Checked = false
 then SearchModel.Enabled := false;
end;

procedure TForm1.CategoryClick(Sender: TObject);
begin
 // Если не отмечена галочка, то поле неактивно
 if Category.Checked = true
 then SearchCategory.Enabled := true;
  if Category.Checked = false
 then SearchCategory.Enabled := false;
end;

procedure TForm1.CheckAllClick(Sender: TObject);
begin
    if CheckAll.Checked = true      // Галочка Show All - отметить все поля
    then
    begin
        Model.Checked := true;
        Category.Checked := true;
        Year.Checked := true;
        Price.Checked := true;
        ProductReview.Checked := true;
        SellerContact.Checked := true;

    end;
end;

procedure TForm1.CheckCarForSaleClick(Sender: TObject);
begin
// Снимаем отметку с Car, если внутри ничего не отмечено.
if ((CheckCarForSale.Checked = false) AND (CheckUsedCar.Checked = false) AND (CheckNewCar.Checked = false))
then begin
    if (CheckCar.Checked = true) then CheckCar.Checked := false;
end;
// Отмечаем Car, если все внутри отмечаено
if ((CheckCarForSale.Checked = true) AND (CheckUsedCar.Checked = true) AND (CheckNewCar.Checked = true))
then begin
    if (CheckCar.Checked = false) then CheckCar.Checked := true;
end;
end;

procedure TForm1.CheckUsedCarClick(Sender: TObject);
begin
// Снимаем отметку с Car, если внутри ничего не отмечено.
if ((CheckUsedCar.Checked = false) AND (CheckCarForSale.Checked = false) AND (CheckNewCar.Checked = false))
then begin
    if (CheckCar.Checked = true) then CheckCar.Checked := false;
end;
// Отмечаем Car, если все внутри отмечаено
if ((CheckCarForSale.Checked = true) AND (CheckUsedCar.Checked = true) AND (CheckNewCar.Checked = true))
then begin
    if (CheckCar.Checked = false) then CheckCar.Checked := true;
end;
end;

procedure TForm1.CheckNewCarClick(Sender: TObject);
begin
// Снимаем отметку с Car, если внутри ничего не отмечено.
if ((CheckNewCar.Checked = false) AND (CheckUsedCar.Checked = false) AND (CheckCarForSale.Checked = false))
then begin
    if (CheckCar.Checked = true) then CheckCar.Checked := false;
end;
// Отмечаем Car, если все внутри отмечено
if ((CheckCarForSale.Checked = true) AND (CheckUsedCar.Checked = true) AND (CheckNewCar.Checked = true))
then begin
    if (CheckCar.Checked = false) then CheckCar.Checked := true;
end;
end;

procedure TForm1.SetRestrictionsToAnyClick(Sender: TObject);
begin
      // Подсчитаем количество непустых элементов в массиве
      count := 0;
      for i:=0 to high(ArrQueryRestrictions) do if ArrQueryRestrictions[i]<>'' then count := count + 1;

      // Кодирование в SQL
      for i:=1 to count do
      begin
      (FindComponent('Restriction' + IntToStr(i) + 'min') as TComboBox).Text := 'any';
      (FindComponent('Restriction' + IntToStr(i) + 'max') as TComboBox).Text := 'any';
      end;
end;

procedure TForm1.CreateBucketClick(Sender: TObject);
var
CurrentMemory,srs,j,k,classtest,x,test,SrsCount, d: integer;  // всякие счетчики
CurrentSrc: String; // текущий источник - для упрощения конструкции в цикле
ComparsionMarkSource: String; // знак сравнения в ограничениях Источника =, <, >
ComparsionMarkQuery: String;  // знак сравнения в ограничениях Запроса =, <, >
DjointOrNot: array [1..100] of integer; // Отношение классов по Матрице отношения классов
RestrictOrNot: array [1..100] of integer;  // Подходит ли источник по Ограничениям
begin
if GeneratedQueryString = '' then  // Пользователю предлагается для начала сделать Запрос, а потом уже Ведро
begin
Application.MessageBox ('Make sure SQL Query generated before', 'Generate SQL before creating bucket', mb_Ok + mb_IconExclamation);
exit;
end;

// СОЗДАНИЕ ВЕДРА
      TestMemo2.Lines.Add('---BUCKET TEST---');

      // Выбранные классы - ПРОВЕРКА, вывод
      // TestMemo2.Lines.Add('---selected classes for bucket---');
      for i:=1 to high(ArrQueryClass) do
      begin
        if (ArrQueryClass[i]<>'') then TestMemo2.Lines.Add(ArrQueryClass[i] + ' class found in Query')
        else break;
      end;

// Проверяем источники на джойнт-дисдойнт
      count := 0;
      x := 1;


                          // 0. Проверяем существование в нашем описании классов, которые дал пользователь в запросе
                          classtest := 0;
                          for j:=1 to high(ArrQueryClass) do   // по всем классам в запросе
                          begin
                               if (ArrQueryClass[j] <> '') then   // если элемент массива не пустой
                               begin
                                    for k:=1 to high(ArrSourceClass) do  // по всем классам в описании
                                    begin
                                       if (ArrSourceClass[k] <> '') then
                                       begin
                                          // По идее, если такого класса нет в описании, то даст 0
                                          if (ArrQueryClass[j]=ArrSourceClass[k]) then classtest := classtest + 1;
                                       end
                                       else break;
                                    end;
                               end
                               else break;
                          end;
                          // Пусть пользователь удивится!
                          if (classtest = 0) then Application.MessageBox ('Class in your Query was not found in our Sources', 'No such class found', mb_Ok + mb_IconExclamation);
                          TestMemo2.Lines.Add('Test for Class existence: ' + IntToStr(classtest));


    // Проверяем отношения классов в запросе (ArrQueryClass) и в источниках SourceN[inclass][i]
    for d:=0 to length(DjointOrNot) do
    begin
           DjointOrNot[d] := 0; // Убить ведро! Убить!
    end;

    srs := 1;
    Sources[srs].First;
    for srs:=1 to high(Sources) do     // Смотрим по всем источникам
    begin
         if (Sources[srs] <> nil) then   // Если источник существует в массиве источников, а то массив большой
         begin
              Sources[srs].First;
              //TestMemo2.Lines.Add(IntToStr(srs) + ' источник сработал (1 цикл)');
              while not Sources[srs].Eof do   // Проходим все описание источника
              begin
                   // TestMemo2.Lines.Add(IntToStr(srs) + ' источник сработал (2 цикл)');
                    Sources[srs].CurrentValue.First;
                    while Sources[srs].CurrentKey = 'inclass' do  // Если в описании встречаем запись inclass
                    begin
                       // TestMemo2.Lines.Add(IntToStr(srs) + ' источник сработал (пред-inclass цикл)');
                        while not Sources[srs].CurrentValue.Eof do
                        begin

                          // 1. Проверяем отношения классов в запросе и в источниках по матрице джойнт-дисджойнт
                          for j:=1 to high(ArrQueryClass) do   // по всем классам в запросе
                          begin
                               if (ArrQueryClass[j] <> '') then   // если элемент массива не пустой
                               begin
                                    TestMemo2.Lines.Add('DjointOrNot[' + ArrQueryClass[j] + '][' + Sources[srs].CurrentValue.CurrentValue.AsString + ']: ' + IntToStr(ArrDisjointClassesMatrix[ArrQueryClass[j]][Sources[srs].CurrentValue.CurrentValue.AsString].AsInteger));

                                    // Прибавим к элементу с номером источника результат проверки отношений
                                    DjointOrNot[srs] := DjointOrNot[srs] + ArrDisjointClassesMatrix[ArrQueryClass[j]][Sources[srs].CurrentValue.CurrentValue.AsString].AsInteger;
                                    //TestMemo2.Lines.Add('DjointOrNot[' + IntToStr(srs) + '] = ' + IntToStr(DjointOrNot[srs]));
                               end
                               else break;

                          end;



                          // 2. Проверяем и отсекаем источники по критериям-ограничениям (Restrictions)
                          CurrentSrc:= Sources[srs]['name'][0].AsString; // Имя текущего источника - чтобы не тащить всю конструкцию дальше
                          ArrQueryRestrictionsMatrix.First;

                          while not ArrQueryRestrictionsMatrix.Eof do // Все ограничения в запросе пользователя
                          begin
                                SourceRestrictions.First; // probably SourceRestrictions.CurrentValue.First
                                while not SourceRestrictions.Eof do
                                begin

                                      if (SourceRestrictions.CurrentKey = CurrentSrc) then
                                      begin
                                            //TestMemo2.Lines.Add('sources worked, current: ' + CurrentSrc);
                                            SourceRestrictions.CurrentValue.First;
                                            while not SourceRestrictions.CurrentValue.Eof do
                                            begin
                                                  if (ArrQueryRestrictionsMatrix.CurrentKey = SourceRestrictions.CurrentValue.CurrentKey) then
                                                  begin
                                                        //TestMemo2.Lines.Add('restrictions worked, current: ' + ArrQueryRestrictionsMatrix.CurrentKey);
                                                        ArrQueryRestrictionsMatrix.CurrentValue.First;
                                                        while not ArrQueryRestrictionsMatrix.CurrentValue.Eof do
                                                        begin
                                                              //TestMemo2.Lines.Add('while ARQM worked, current: ' + ArrQueryRestrictionsMatrix.CurrentValue.CurrentKey);
                                                              SourceRestrictions.CurrentValue.CurrentValue.First;
                                                              while not SourceRestrictions.CurrentValue.CurrentValue.Eof do
                                                              begin
                                                                    ComparsionMarkQuery := ArrQueryRestrictionsMatrix.CurrentValue.CurrentKey;
                                                                    ComparsionMarkSource := SourceRestrictions.CurrentValue.CurrentValue.CurrentKey;
                                                                    TestMemo2.Lines.Add(ComparsionMarkSource[1] + '= mark in Source, in Query is: ' + IntToStr(srs) + ' ' + ComparsionMarkQuery[1]);
                                                                    if (ComparsionMarkSource[1] = ComparsionMarkQuery[1]) then
                                                                    begin
                                                                          TestMemo2.Lines.Add('Source restricted by: ' + SourceRestrictions.CurrentValue.CurrentKey);

                                                                    end;      
                                                                    // PROFIT  проверить знаки, отсеять источники, проранжировать оставшиеся

                                                                    SourceRestrictions.CurrentValue.CurrentValue.Next;
                                                              end;
                                                              ArrQueryRestrictionsMatrix.CurrentValue.Next;
                                                        end; // while ARQM.CV.Eof
                                                        
                                                  end; // if ARQM.CK = SR.CV.CK
                                                  SourceRestrictions.CurrentValue.Next;
                                            end; // while SR.CV.Eof
                                      end; // If SR.CK = CurrSRC
                                      SourceRestrictions.Next
                                end; // while SR.Eof
                                ArrQueryRestrictionsMatrix.Next;
                          end; // while ARQM.Eof

                        //  ArrQueryRestrictionsMatrix[ArrQueryRestrictions[i]]['>'+ CanEquals].AsString
                        //  SourceRestrictions[Sources[2].AsString][ArrSourceCapabilities[4]]['>='].AsInteger := 20000;  // = Price;



                     // SourceRestrictions[Sources[2].AsString][ArrSourceCapabilities[4]]['>='].AsInteger := 20000;  // = Price;

                          // 3. Проверяем возможности источников выдать параметры запроса и сортируем по количеству требуемых потенциально полезных полей- ArrQueryWhat & SourceCapabilities

                          // ТУТ НЕ ГОТОВО

                     //     ArrQueryClass
                     //     Sources[srs].CurrentValue.CurrentValue.AsString
                     //     ArrDisjointClassesMatrix[ArrSourceClass[j]][ArrSourceClass[k]].AsInteger
                     //     Bucket[]
                     //     DjointOrNot

                     //     TestMemo2.Lines.Add('In Source ' + IntToStr(srs) + ' found class: ' + Sources[srs].CurrentValue.CurrentValue.AsString);

                          // Вывод списка джойнед-источников
                          SrsCount := 0;
                          TestMemo2.Lines.Add('----# Sources selected by disjoint matrix: iteration-srs: ' + IntToStr(srs) +  '#----');
                          for j:=0 to high(DjointOrNot) do   // по всем классам в запросе
                          begin
                                // надо ограничить условие, а то гоняет 100 раз!
                               if (DjointOrNot[j] <> 0) then   // если элемент массива не пустой
                               begin
                                    TestMemo2.Lines.Add('Source #' + IntToStr(j));
                                    SrsCount := SrsCount + 1;
                               end;
                          end;

                          Sources[srs].CurrentValue.Next;
                        end;
                        Sources[srs].Next;
                    end;
              Sources[srs].Next;
              end;
              Sources[srs].First;
         end
         else break;
    end;



      TestMemo2.Lines.Add('>>> Num of Sources: ' + IntToStr(srs-1) + ', in Bucket by Disjoint matrix: ' + IntToStr(SrsCount));

CurrentMemory := AllocMemSize - StartMemory;
StatusBar1.SimpleText := 'Memory leak after Generating SQL: ' + IntToStr(CurrentMemory) + ' bytes';
end;

procedure TForm1.ClearLogClick(Sender: TObject);
begin
TestMemo2.Clear;
end;

procedure TForm1.SQLToBucketClick(Sender: TObject);
begin
WorkPageControl.SelectNextPage(true);
end;

end.
