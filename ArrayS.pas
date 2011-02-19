
{*******************************************************}
{                                                       }
{       SDGroup Runtime Library                         }
{       Associative Arrays Unit (static version)        }
{                                                       }
{       Copyright (c) Dmitry Ryabov AKA Dimk            }
{       Contact info: dimk@perm.ru, 2:5054/45@fidonet   }
{                                                       }
{*******************************************************}

{$IFDEF VER140}
  {$DEFINE ABOVE_D5}
{$ENDIF}
{$IFDEF VER150}
  {$DEFINE ABOVE_D5}
{$ENDIF}

unit ArrayS;

interface

uses
  SysUtils{$IFDEF ABOVE_D5}, Variants{$ENDIF};

resourcestring
  SArrayInternalIndexError = '¬нутренн€€ ошибка поиска индекса';
  SArrayIndexOutOfBounds = '»ндекс за пределами массива (%d)';

const
  MaxPointerArraySize = MaxInt div SizeOf(Pointer) - 1;
  IID_IVariantArray  = '{96E20FBD-FAFA-4293-AC67-4AC2C1CF8C49}';
  IID_IBooleanArray  = '{01922EBC-E4EF-418A-874F-65612BB54152}';
  IID_IIntegerArray  = '{89A2C073-E8B3-420D-A70C-A1749FB99DB2}';
  IID_IInt64Array    = '{0682DD05-27F4-4445-89E2-7CF5AFAE3053}';
  IID_IFloatArray    = '{E286780F-BF91-4F5A-B44E-E11A4AC43419}';
  IID_IDateTimeArray = '{AAE8C57C-0629-4CC7-99A0-F0005E882B54}';
  IID_IStringArray   = '{16600785-3623-46D2-8926-1D74A5F5674A}';
  IID_IPointerArray  = '{92247F95-2645-4909-AC0B-B6627D6D09F4}';
  IID_IObjectArray   = '{BC05B745-81E9-438C-B27E-ED93A75CDAEF}';
  IID_IClassArray    = '{B5575CEC-0B6B-4C86-BD30-8D081410033D}';
  IID_IMultiArray    = '{92130C3F-B614-49D6-9AC1-99AA468A6A3D}';
  IID_IArray = IID_IVariantArray;

  varEmpty      = $0000; { vt_empty        0 }
  varNull       = $0001; { vt_null         1 }
  varSmallint   = $0002; { vt_i2           2 }
  varInteger    = $0003; { vt_i4           3 }
  varSingle     = $0004; { vt_r4           4 }
  varDouble     = $0005; { vt_r8           5 }
  varCurrency   = $0006; { vt_cy           6 }
  varDate       = $0007; { vt_date         7 }
  varOleStr     = $0008; { vt_bstr         8 }
  varDispatch   = $0009; { vt_dispatch     9 }
  varError      = $000A; { vt_error       10 }
  varBoolean    = $000B; { vt_bool        11 }
  varVariant    = $000C; { vt_variant     12 }
  varUnknown    = $000D; { vt_unknown     13 }
//varDecimal    = $000E; { vt_decimal     14 } {UNSUPPORTED as of v6.x code base}
//varUndef0F    = $000F; { undefined      15 } {UNSUPPORTED per Microsoft}
  varShortInt   = $0010; { vt_i1          16 }
  varByte       = $0011; { vt_ui1         17 }
  varWord       = $0012; { vt_ui2         18 }
  varLongWord   = $0013; { vt_ui4         19 }
  varInt64      = $0014; { vt_i8          20 }
//varWord64     = $0015; { vt_ui8         21 } {UNSUPPORTED as of v6.x code base}
  varStrArg     = $0048; { vt_clsid       72 }
  varString     = $0100; { Pascal string 256 } {not OLE compatible }
  varAny        = $0101; { Corba any     257 } {not OLE compatible }
  varTypeMask   = $0FFF;
  varArray      = $2000;
  varByRef      = $4000;
  varPointer    = $4000;
  extClass      = $00010000 or varPointer;
  extMultiArray = $00020000 or varPointer;
  extObject     = $00040000 or varPointer;

type
  TArray = class;
  EArrayError = class(Exception);

  IVariantArray = interface
    ['{96E20FBD-FAFA-4293-AC67-4AC2C1CF8C49}']
    function GetBof: Boolean;
    function GetCapacity: Integer;
    function GetCount: Integer;
    function GetCurrentIndex: Integer;
    function GetCurrentKey: Variant;
    function GetCurrentValue: Variant;
    function GetEof: Boolean;
    function GetInstance: TArray;
    function GetItem(Key: Variant): Variant;
    function GetKey(Index: Integer): Variant;
    function GetKeyCaseSensitive: Boolean;
    function GetRefCount: Integer;
    function GetSorted: Boolean;
    function GetValue(Index: Integer): Variant;
    procedure SetCapacity(const Value: Integer);
    procedure SetCurrentIndex(const Value: Integer);
    procedure SetItem(Key: Variant; const Value: Variant);
    procedure SetKeyCaseSensitive(const Value: Boolean);
    procedure SetSorted(Value: Boolean);
  //
    function Exchange(const Key1, Key2: Variant): Boolean;
    function Exist(const Key: Variant): Boolean;
    function FindKey(const Key: Variant; var Index: Integer): Boolean;
    function FindValue(const Value: Variant; var Index: Integer): Boolean;
    function Remove(const Key: Variant): Boolean;
    function Rename(const Key, NewKey: Variant): Boolean;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure First;
    procedure Last;
    procedure Next;
    procedure Pack;
    procedure Prior;
    procedure Sort;
    property Bof: Boolean read GetBof;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount;
    property CurrentIndex: Integer read GetCurrentIndex write SetCurrentIndex;
    property CurrentKey: Variant read GetCurrentKey;
    property CurrentValue: Variant read GetCurrentValue;
    property Eof: Boolean read GetEof;
    property Instance: TArray read GetInstance;
    property Item[Key: Variant]: Variant read GetItem write SetItem; default;
    property Key[Index: Integer]: Variant read GetKey;
    property KeyCaseSensitive: Boolean read GetKeyCaseSensitive write SetKeyCaseSensitive;
    property RefCount: Integer read GetRefCount;
    property Sorted: Boolean read GetSorted write SetSorted;
    property Value[Index: Integer]: Variant read GetValue;
  end;

  IBooleanArray = interface(IVariantArray)
    ['{01922EBC-E4EF-418A-874F-65612BB54152}']
    function GetCurrentValue: Boolean;
    function GetItem(Key: Variant): Boolean;
    function GetValue(Index: Integer): Boolean;
    procedure SetItem(Key: Variant; const Value: Boolean);
  //
    function FindValue(const Value: Boolean; var Index: Integer): Boolean;
    property CurrentValue: Boolean read GetCurrentValue;
    property Item[Key: Variant]: Boolean read GetItem write SetItem; default;
    property Value[Index: Integer]: Boolean read GetValue;
  end;

  IIntegerArray = interface(IVariantArray)
    ['{89A2C073-E8B3-420D-A70C-A1749FB99DB2}']
    function GetCurrentValue: Integer;
    function GetItem(Key: Variant): Integer;
    function GetValue(Index: Integer): Integer;
    procedure SetItem(Key: Variant; const Value: Integer);
  //
    function FindValue(const Value: Integer; var Index: Integer): Boolean;
    property CurrentValue: Integer read GetCurrentValue;
    property Item[Key: Variant]: Integer read GetItem write SetItem; default;
    property Value[Index: Integer]: Integer read GetValue;
  end;

  IInt64Array = interface(IVariantArray)
    ['{0682DD05-27F4-4445-89E2-7CF5AFAE3053}']
    function GetCurrentValue: Int64;
    function GetItem(Key: Variant): Int64;
    function GetValue(Index: Integer): Int64;
    procedure SetItem(Key: Variant; const Value: Int64);
  //
    function FindValue(const Value: Int64; var Index: Integer): Boolean;
    property CurrentValue: Int64 read GetCurrentValue;
    property Item[Key: Variant]: Int64 read GetItem write SetItem; default;
    property Value[Index: Integer]: Int64 read GetValue;
  end;

  IFloatArray = interface(IVariantArray)
    ['{E286780F-BF91-4F5A-B44E-E11A4AC43419}']
    function GetCurrentValue: Double;
    function GetItem(Key: Variant): Double;
    function GetValue(Index: Integer): Double;
    procedure SetItem(Key: Variant; const Value: Double);
  //
    function FindValue(const Value: Double; var Index: Integer): Boolean;
    property CurrentValue: Double read GetCurrentValue;
    property Item[Key: Variant]: Double read GetItem write SetItem; default;
    property Value[Index: Integer]: Double read GetValue;
  end;

  IDateTimeArray = interface(IVariantArray)
    ['{AAE8C57C-0629-4CC7-99A0-F0005E882B54}']
    function GetCurrentValue: TDateTime;
    function GetItem(Key: Variant): TDateTime;
    function GetValue(Index: Integer): TDateTime;
    procedure SetItem(Key: Variant; const Value: TDateTime);
  //
    function FindValue(const Value: TDateTime; var Index: Integer): Boolean;
    property CurrentValue: TDateTime read GetCurrentValue;
    property Item[Key: Variant]: TDateTime read GetItem write SetItem; default;
    property Value[Index: Integer]: TDateTime read GetValue;
  end;

  IStringArray = interface(IVariantArray)
    ['{16600785-3623-46D2-8926-1D74A5F5674A}']
    function GetCurrentValue: string;
    function GetItem(Key: Variant): string;
    function GetValue(Index: Integer): string;
    procedure SetItem(Key: Variant; const Value: string);
  //
    function FindValue(const Value: string; var Index: Integer): Boolean;
    property CurrentValue: string read GetCurrentValue;
    property Item[Key: Variant]: string read GetItem write SetItem; default;
    property Value[Index: Integer]: string read GetValue;
  end;

  IPointerArray = interface(IVariantArray)
    ['{92247F95-2645-4909-AC0B-B6627D6D09F4}']
    function GetCurrentValue: Pointer;
    function GetItem(Key: Variant): Pointer;
    function GetValue(Index: Integer): Pointer;
    procedure SetItem(Key: Variant; const Value: Pointer);
  //
    function FindValue(const Value: Pointer; var Index: Integer): Boolean;
    property CurrentValue: Pointer read GetCurrentValue;
    property Item[Key: Variant]: Pointer read GetItem write SetItem; default;
    property Value[Index: Integer]: Pointer read GetValue;
  end;

  IObjectArray = interface(IVariantArray)
    ['{BC05B745-81E9-438C-B27E-ED93A75CDAEF}']
    function GetCurrentValue: TObject;
    function GetItem(Key: Variant): TObject;
    function GetOwnsObjects: Boolean;
    function GetValue(Index: Integer): TObject;
    procedure SetItem(Key: Variant; const Value: TObject);
    procedure SetOwnsObjects(const Value: Boolean);
  //
    function FindValue(const Value: TObject; var Index: Integer): Boolean;
    property CurrentValue: TObject read GetCurrentValue;
    property Item[Key: Variant]: TObject read GetItem write SetItem; default;
    property OwnsObjects: Boolean read GetOwnsObjects write SetOwnsObjects;
    property Value[Index: Integer]: TObject read GetValue;
  end;

  IClassArray = interface(IVariantArray)
    ['{B5575CEC-0B6B-4C86-BD30-8D081410033D}']
    function GetCurrentValue: TClass;
    function GetItem(Key: Variant): TClass;
    function GetValue(Index: Integer): TClass;
    procedure SetItem(Key: Variant; const Value: TClass);
  //
    function FindValue(const Value: TClass; var Index: Integer): Boolean;
    property CurrentValue: TClass read GetCurrentValue;
    property Item[Key: Variant]: TClass read GetItem write SetItem; default;
    property Value[Index: Integer]: TClass read GetValue;
  end;

  IMultiArray = interface(IVariantArray)
    ['{92130C3F-B614-49D6-9AC1-99AA468A6A3D}']
    function GetAsBoolean: Boolean;
    function GetAsClass: TClass;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: Double;
    function GetAsInt64: Int64;
    function GetAsInteger: Integer;
    function GetAsObject: TObject;
    function GetAsString: string;
    function GetAsVariant: Variant;
    function GetCurrentValue: IMultiArray;
    function GetItem(Key: Variant): IMultiArray;
    function GetValue(Index: Integer): IMultiArray;
    procedure SetAsBoolean(const Value: Boolean);
    procedure SetAsClass(const Value: TClass);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsFloat(const Value: Double);
    procedure SetAsInt64(const Value: Int64);
    procedure SetAsInteger(const Value: Integer);
    procedure SetAsObject(const Value: TObject);
    procedure SetAsString(const Value: string);
    procedure SetAsVariant(const Value: Variant);
    procedure SetItem(Key: Variant; const Value: IMultiArray);
  //
    function FindValue(const Value: IMultiArray; var Index: Integer): Boolean;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsClass: TClass read GetAsClass write SetAsClass;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsObject: TObject read GetAsObject write SetAsObject;
    property AsString: string read GetAsString write SetAsString;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property CurrentValue: IMultiArray read GetCurrentValue;
    property Item[Key: Variant]: IMultiArray read GetItem write SetItem; default;
    property Value[Index: Integer]: IMultiArray read GetValue;
  end;

  // Aliases
  IArray     = IVariantArray;
  IVArray    = IVariantArray;
  IBArray    = IBooleanArray;
  IIArray    = IIntegerArray;
  II64Array  = IInt64Array;
  IFArray    = IFloatArray;
  IDArray    = IDateTimeArray;
  ITArray    = IDateTimeArray;
  ISArray    = IStringArray;
  IPArray    = IPointerArray;
  IOArray    = IObjectArray;
  ICArray    = IClassArray;
  IMArray    = IMultiArray;
  IVarArray  = IVariantArray;
  IBoolArray = IBooleanArray;
  IIntArray  = IIntegerArray;
  IFltArray  = IFloatArray;
  IDateArray = IDateTimeArray;
  ITimeArray = IDateTimeArray;
  IStrArray  = IStringArray;
  IPtrArray  = IPointerArray;
  IObjArray  = IObjectArray;
  IClsArray  = IClassArray;
  IMltArray  = IMultiArray;

  TExtData = packed record
    VExtType: LongWord;
    Reserved: LongWord;
    VPointer: Pointer;
    Dummy: LongWord;
  end;

  TObjData = packed record
    VExtType: LongWord;
    Reserved: LongWord;
    VObject: TObject;
    Dummy: LongWord;
  end;

  TClsData = packed record
    VExtType: LongWord;
    Reserved: LongWord;
    VClass: TClass;
    Dummy: LongWord;
  end;

  TMltData = packed record
    VExtType: LongWord;
    Reserved: LongWord;
    VMultiArray: IMultiArray;
    Dummy: LongWord;
  end;

  TI64Data = packed record
    VType: Word;
    Reserved1, Reserved2, Reserved3: Word;
    VInt64: Int64;
  end;

  TVariantCompare = function(const Var1, Var2: Variant): Integer;
  TVarItem = record
    Key, Value: Variant;
  end;
  PVarItem = ^TVarItem;
  TVarItemArray = array[0..MaxPointerArraySize] of PVarItem;
  PVarItemArray = ^TVarItemArray;

  TArray = class(TInterfacedObject, IVariantArray, IBooleanArray, IIntegerArray, IInt64Array,
    IFloatArray, IDateTimeArray, IStringArray, IPointerArray, IObjectArray, IClassArray, IMultiArray)
  private
    FBof: Boolean;
    FCapacity: Integer;
    FValueCompare: TVariantCompare;
    FCount: Integer;
    FCurrentIndex: Integer;
    FEof: Boolean;
    FKeyCaseSensitive: Boolean;
    FKeys: PVarItemArray;
    FOwnsObjects: Boolean;
    FSorted: Boolean;
    FValue: Variant;
    FValues: PVarItemArray;
  //
    function IBooleanArray.FindValue = FindValueB;
    function IBooleanArray.GetCurrentValue = GetCurrentValueB;
    function IBooleanArray.GetItem = GetItemB;
    function IBooleanArray.GetValue = GetValueB;
    function IClassArray.FindValue = FindValueC;
    function IClassArray.GetCurrentValue = GetCurrentValueC;
    function IClassArray.GetItem = GetItemC;
    function IClassArray.GetValue = GetValueC;
    function IDateTimeArray.FindValue = FindValueD;
    function IDateTimeArray.GetCurrentValue = GetCurrentValueD;
    function IDateTimeArray.GetItem = GetItemD;
    function IDateTimeArray.GetValue = GetValueD;
    function IFloatArray.FindValue = FindValueF;
    function IFloatArray.GetCurrentValue = GetCurrentValueF;
    function IFloatArray.GetItem = GetItemF;
    function IFloatArray.GetValue = GetValueF;
    function IInt64Array.FindValue = FindValueI64;
    function IInt64Array.GetCurrentValue = GetCurrentValueI64;
    function IInt64Array.GetItem = GetItemI64;
    function IInt64Array.GetValue = GetValueI64;
    function IIntegerArray.FindValue = FindValueI;
    function IIntegerArray.GetCurrentValue = GetCurrentValueI;
    function IIntegerArray.GetItem = GetItemI;
    function IIntegerArray.GetValue = GetValueI;
    function IMultiArray.FindValue = FindValueM;
    function IMultiArray.GetCurrentValue = GetCurrentValueM;
    function IMultiArray.GetItem = GetItemM;
    function IMultiArray.GetValue = GetValueM;
    function IObjectArray.FindValue = FindValueO;
    function IObjectArray.GetCurrentValue = GetCurrentValueO;
    function IObjectArray.GetItem = GetItemO;
    function IObjectArray.GetValue = GetValueO;
    function IPointerArray.FindValue = FindValueP;
    function IPointerArray.GetCurrentValue = GetCurrentValueP;
    function IPointerArray.GetItem = GetItemP;
    function IPointerArray.GetValue = GetValueP;
    function IStringArray.FindValue = FindValueS;
    function IStringArray.GetCurrentValue = GetCurrentValueS;
    function IStringArray.GetItem = GetItemS;
    function IStringArray.GetValue = GetValueS;
    procedure IBooleanArray.SetItem = SetItemB;
    procedure IClassArray.SetItem = SetItemC;
    procedure IDateTimeArray.SetItem = SetItemD;
    procedure IFloatArray.SetItem = SetItemF;
    procedure IInt64Array.SetItem = SetItemI64;
    procedure IIntegerArray.SetItem = SetItemI;
    procedure IMultiArray.SetItem = SetItemM;
    procedure IObjectArray.SetItem = SetItemO;
    procedure IPointerArray.SetItem = SetItemP;
    procedure IStringArray.SetItem = SetItemS;
  //
    function FindValueB(const Value: Boolean; var Index: Integer): Boolean;
    function FindValueC(const Value: TClass; var Index: Integer): Boolean;
    function FindValueD(const Value: TDateTime; var Index: Integer): Boolean;
    function FindValueF(const Value: Double; var Index: Integer): Boolean;
    function FindValueI(const Value: Integer; var Index: Integer): Boolean;
    function FindValueI64(const Value: Int64; var Index: Integer): Boolean;
    function FindValueM(const Value: IMultiArray; var Index: Integer): Boolean;
    function FindValueO(const Value: TObject; var Index: Integer): Boolean;
    function FindValueP(const Value: Pointer; var Index: Integer): Boolean;
    function FindValueS(const Value: string; var Index: Integer): Boolean;
    function GetAsBoolean: Boolean;
    function GetAsClass: TClass;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: Double;
    function GetAsInt64: Int64;
    function GetAsInteger: Integer;
    function GetAsObject: TObject;
    function GetAsString: string;
    function GetAsVariant: Variant;
    function GetBof: Boolean;
    function GetCapacity: Integer;
    function GetCount: Integer;
    function GetCurrentIndex: Integer;
    function GetCurrentKey: Variant;
    function GetCurrentValue: Variant;
    function GetCurrentValueB: Boolean;
    function GetCurrentValueC: TClass;
    function GetCurrentValueD: TDateTime;
    function GetCurrentValueF: Double;
    function GetCurrentValueI: Integer;
    function GetCurrentValueI64: Int64;
    function GetCurrentValueM: IMultiArray;
    function GetCurrentValueO: TObject;
    function GetCurrentValueP: Pointer;
    function GetCurrentValueS: string;
    function GetEof: Boolean;
    function GetInstance: TArray;
    function GetItem(Key: Variant): Variant;
    function GetItemB(Key: Variant): Boolean;
    function GetItemC(Key: Variant): TClass;
    function GetItemD(Key: Variant): TDateTime;
    function GetItemF(Key: Variant): Double;
    function GetItemI(Key: Variant): Integer;
    function GetItemI64(Key: Variant): Int64;
    function GetItemM(Key: Variant): IMultiArray;
    function GetItemO(Key: Variant): TObject;
    function GetItemP(Key: Variant): Pointer;
    function GetItemS(Key: Variant): string;
    function GetKey(Index: Integer): Variant;
    function GetKeyCaseSensitive: Boolean;
    function GetOwnsObjects: Boolean;
    function GetRefCount: Integer;
    function GetSorted: Boolean;
    function GetValue(Index: Integer): Variant;
    function GetValueB(Index: Integer): Boolean;
    function GetValueC(Index: Integer): TClass;
    function GetValueD(Index: Integer): TDateTime;
    function GetValueF(Index: Integer): Double;
    function GetValueI(Index: Integer): Integer;
    function GetValueI64(Index: Integer): Int64;
    function GetValueM(Index: Integer): IMultiArray;
    function GetValueO(Index: Integer): TObject;
    function GetValueP(Index: Integer): Pointer;
    function GetValueS(Index: Integer): string;
    procedure SetAsBoolean(const Value: Boolean);
    procedure SetAsClass(const Value: TClass);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsFloat(const Value: Double);
    procedure SetAsInt64(const Value: Int64);
    procedure SetAsInteger(const Value: Integer);
    procedure SetAsObject(const Value: TObject);
    procedure SetAsString(const Value: string);
    procedure SetAsVariant(const Value: Variant);
    procedure SetCapacity(const Value: Integer);
    procedure SetCurrentIndex(const Value: Integer);
    procedure SetItem(Key: Variant; const Value: Variant);
    procedure SetItemB(Key: Variant; const Value: Boolean);
    procedure SetItemC(Key: Variant; const Value: TClass);
    procedure SetItemD(Key: Variant; const Value: TDateTime);
    procedure SetItemF(Key: Variant; const Value: Double);
    procedure SetItemI(Key: Variant; const Value: Integer);
    procedure SetItemI64(Key: Variant; const Value: Int64);
    procedure SetItemM(Key: Variant; const Value: IMultiArray);
    procedure SetItemO(Key: Variant; const Value: TObject);
    procedure SetItemP(Key: Variant; const Value: Pointer);
    procedure SetItemS(Key: Variant; const Value: string);
    procedure SetKeyCaseSensitive(const Value: Boolean);
    procedure SetOwnsObjects(const Value: Boolean);
    procedure SetSorted(Value: Boolean);
  //
    function FindInternalKeyIndex(const Key: Variant; var InternalKeyIndex: Integer): Boolean;
    function GetInternalValueIndex(InternalKeyIndex: Integer): Integer;
    function KeyCompare(const Var1, Var2: Variant): Integer;
    procedure FreeItem(var pItem: PVarItem);
    procedure Grow;
    procedure QuickSort(L, R: Integer);
  public
    constructor Create; overload;
    constructor Create(CustomCompare: TVariantCompare); overload;
    destructor Destroy; override;
    function Exchange(const Key1, Key2: Variant): Boolean;
    function Exist(const Key: Variant): Boolean;
    function FindKey(const Key: Variant; var Index: Integer): Boolean;
    function FindValue(const Value: Variant; var Index: Integer): Boolean;
    function Remove(const Key: Variant): Boolean;
    function Rename(const Key, NewKey: Variant): Boolean;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure First;
    procedure Last;
    procedure Next;
    procedure Pack;
    procedure Prior;
    procedure Sort;
  //property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
  //property AsClass: TClass read GetAsClass write SetAsClass;
  //property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
  //property AsFloat: Double read GetAsFloat write SetAsFloat;
  //property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
  //property AsInteger: Integer read GetAsInteger write SetAsInteger;
  //property AsObject: TObject read GetAsObject write SetAsObject;
  //property AsString: string read GetAsString write SetAsString;
  //property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property Bof: Boolean read GetBof;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount;
    property CurrentIndex: Integer read GetCurrentIndex write SetCurrentIndex;
    property CurrentKey: Variant read GetCurrentKey;
    property CurrentValue: Variant read GetCurrentValue;
    property Eof: Boolean read GetEof;
    property Instance: TArray read GetInstance;
    property Item[Key: Variant]: Variant read GetItem write SetItem; default;
    property Key[Index: Integer]: Variant read GetKey;
    property KeyCaseSensitive: Boolean read GetKeyCaseSensitive write SetKeyCaseSensitive;
  //property OwnsObjects: Boolean read GetOwnsObjects write SetOwnsObjects;
    property Sorted: Boolean read GetSorted write SetSorted;
    property Value[Index: Integer]: Variant read GetValue;
  end;

function CreateArray: TArray; overload;
function CreateArray(CustomCompare: TVariantCompare): TArray; overload;

implementation

function CreateArray: TArray;
begin
  Result := TArray.Create;
end;

function CreateArray(CustomCompare: TVariantCompare): TArray;
begin
  Result := TArray.Create(CustomCompare);
end;

function ExtType(const Value: Variant): LongWord;
begin
  if TVarData(Value).VType and varTypeMask <> 0 then
    Result := TVarData(Value).VType
  else
    Result := TExtData(Value).VExtType;
end;

procedure AssignVar(out Dest: Variant; const Source: Variant);
begin
  if TVarData(Source).VType and varTypeMask <> 0 then
    Dest := Source
  else
    TVarData(Dest) := TVarData(Source);
end;

function DefaultValueCompare(const Var1, Var2: Variant): Integer;
begin
  if ExtType(Var1) = ExtType(Var2) then
    case ExtType(Var1) of
      extObject:
        if not Assigned(TObjData(Var1).VObject) then
          Result := -1
        else if not Assigned(TObjData(Var2).VObject) then
          Result := 1
        else
          Result := DefaultValueCompare(TObjData(Var1).VObject.ClassName,
                                        TObjData(Var2).VObject.ClassName);
      extMultiArray:
        if not Assigned(TMltData(Var1).VMultiArray) then
          Result := -1
        else if not Assigned(TMltData(Var2).VMultiArray) then
          Result := 1
        else if (TMltData(Var1).VMultiArray.Count = 0) and
                (TMltData(Var2).VMultiArray.Count = 0) then
          Result := DefaultValueCompare(TMltData(Var1).VMultiArray.AsVariant,
                                        TMltData(Var2).VMultiArray.AsVariant)
        else
          Result := DefaultValueCompare(TMltData(Var1).VMultiArray.Count,
                                        TMltData(Var2).VMultiArray.Count);
      extClass:
        if not Assigned(TClsData(Var1).VClass) then
          Result := -1
        else if not Assigned(TClsData(Var2).VClass) then
          Result := 1
        else
          Result := DefaultValueCompare(TClsData(Var1).VClass.ClassName,
                                        TClsData(Var2).VClass.ClassName);
    else
      if Var1 = Var2 then
        Result := 0
      else if Var1 > Var2 then
        Result := 1
      else
        Result := -1
    end
  else if ExtType(Var1) > ExtType(Var2) then
    Result := 1
  else
    Result := -1;
end;

{ TArray }

constructor TArray.Create;
begin
  SetCurrentIndex(-1);
  FValueCompare := DefaultValueCompare;
end;

constructor TArray.Create(CustomCompare: TVariantCompare);
begin
  SetCurrentIndex(-1);
  FValueCompare := CustomCompare;
end;

destructor TArray.Destroy;
var
  Index: Integer;
begin
  if FCount > 0 then
    for Index := FCount - 1 downto 0 do
      FreeItem(FKeys^[Index]);
  FCount := 0;
  SetCapacity(0);
end;

function TArray.Exchange(const Key1, Key2: Variant): Boolean;
var
  Index1, Index2: Integer;
  _Item: PVarItem;
  _Key: Variant;
begin
  Result := FindInternalKeyIndex(Key1, Index1) and FindInternalKeyIndex(Key2, Index2);
  if Result then
  begin
    _Item := FKeys^[Index1];
    _Key := FKeys^[Index2]^.Key;
    FKeys^[Index1] := FKeys^[Index2];
    FKeys^[Index1]^.Key := _Item^.Key;
    FKeys^[Index2] := _Item;
    FKeys^[Index2]^.Key := _Key;
  end;
end;

function TArray.Exist(const Key: Variant): Boolean;
var
  Index: Integer;
begin
  Result := FindInternalKeyIndex(Key, Index);
end;

function TArray.FindKey(const Key: Variant; var Index: Integer): Boolean;
var
  KeyIndex: Integer;
begin
  Result := FindInternalKeyIndex(Key, KeyIndex);
  if Result then
    Index := GetInternalValueIndex(KeyIndex)
  else
    Index := -1;
end;

function TArray.FindValue(const Value: Variant; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FCount - 1;
  if FSorted then
  begin
    while L <= H do
    begin
      I := (L + H) shr 1;
      C := FValueCompare(FValues^[I]^.Value, Value);
      if C < 0 then
        L := I + 1
      else
      begin
        H := I - 1;
        if C = 0 then
        begin
          Result := True;
//        L := I; // дл€ неуникальных значений не нужно
        end;
      end;
    end;
    if L > 0 then
      repeat
        Dec(L);
        C := FValueCompare(FValues^[L]^.Value, Value);
        if C <> 0 then
          L := L + 1;
      until (C <> 0) or (L = 0);
  end
  else
  begin
    while (L <= H) and (FValueCompare(FValues^[L]^.Value, Value) <> 0) do
      Inc(L);
    Result := (L <= H);
  end;
  Index := L;
end;

function TArray.Remove(const Key: Variant): Boolean;
var
  Index, KeyIndex: Integer;
begin
  Result := FindInternalKeyIndex(Key, KeyIndex);
  if Result then
  begin
    Index := GetInternalValueIndex(KeyIndex);
    Dec(FCount);
    FreeItem(FKeys^[KeyIndex]);
    if KeyIndex < FCount then
      Move(FKeys^[KeyIndex + 1], FKeys^[KeyIndex], (FCount - KeyIndex) * SizeOf(PVarItem));
    if Index < FCount then
      Move(FValues^[Index + 1], FValues^[Index], (FCount - Index) * SizeOf(PVarItem));
    if Index < FCurrentIndex then
      SetCurrentIndex(FCurrentIndex - 1)
    else
      SetCurrentIndex(FCurrentIndex);
  end;
end;

function TArray.Rename(const Key, NewKey: Variant): Boolean;
var
  NewIndex, Index: Integer;
  _Item: PVarItem;
begin
  Result := FindInternalKeyIndex(Key, Index) and not FindInternalKeyIndex(NewKey, NewIndex);
  if Result then
  begin
    _Item := FKeys^[Index];
    if NewIndex > Index then
    begin
      Dec(NewIndex);
      if Index < NewIndex then
        Move(FKeys^[Index + 1], FKeys^[Index], (NewIndex - Index) * SizeOf(PVarItem));
    end
    else if NewIndex < Index then
      Move(FKeys^[NewIndex], FKeys^[NewIndex + 1], (Index - NewIndex) * SizeOf(PVarItem));
    FKeys^[NewIndex] := _Item;
    _Item^.Key := NewKey;
  end;
end;

procedure TArray.Clear;
var
  Index: Integer;
begin
  if FCount > 0 then
  begin
    for Index := FCount - 1 downto 0 do
      FreeItem(FKeys^[Index]);
    FCount := 0;
    SetCapacity(0);
    SetCurrentIndex(-1);
  end;
end;

procedure TArray.Delete(Index: Integer);
var
  KeyIndex: Integer;
begin
  if (Index >= 0) and (Index < FCount) then
    if FindInternalKeyIndex(FValues^[Index]^.Key, KeyIndex) then
    begin
      Dec(FCount);
      FreeItem(FKeys^[KeyIndex]);
      if KeyIndex < FCount then
        Move(FKeys^[KeyIndex + 1], FKeys^[KeyIndex], (FCount - KeyIndex) * SizeOf(PVarItem));
      if Index < FCount then
        Move(FValues^[Index + 1], FValues^[Index], (FCount - Index) * SizeOf(PVarItem));
      if Index < FCurrentIndex then
        SetCurrentIndex(FCurrentIndex - 1)
      else
        SetCurrentIndex(FCurrentIndex);
    end
    else
      raise EArrayError.CreateRes(@SArrayInternalIndexError)
  else
    raise EArrayError.CreateResFmt(@SArrayIndexOutOfBounds, [Index]);
end;

procedure TArray.First;
begin
  SetCurrentIndex(0);
  FBof := True;
end;

procedure TArray.Last;
begin
  SetCurrentIndex(FCount - 1);
  FEof := True;
end;

procedure TArray.Next;
begin
  SetCurrentIndex(FCurrentIndex + 1);
end;

procedure TArray.Pack;
begin
  SetCapacity(FCount);
end;

procedure TArray.Prior;
begin
  SetCurrentIndex(FCurrentIndex - 1);
end;

procedure TArray.Sort;
begin
  if not FSorted and (FCount > 1) then
    QuickSort(0, FCount - 1);
end;

function TArray.FindInternalKeyIndex(const Key: Variant; var InternalKeyIndex:
  Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := KeyCompare(FKeys^[I]^.Key, Key);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  InternalKeyIndex := L;
end;

function TArray.GetInternalValueIndex(InternalKeyIndex: Integer): Integer;
begin
  if FSorted then
    FindValue(FKeys^[InternalKeyIndex]^.Value, Result)
  else
    Result := 0;
  while FValues^[Result] <> FKeys^[InternalKeyIndex] do
  begin
    Inc(Result);
    if Result >= FCount then
      raise EArrayError.CreateRes(@SArrayInternalIndexError);
  end;
end;

function TArray.KeyCompare(const Var1, Var2: Variant): Integer;
begin
  if VarType(Var1) = VarType(Var2) then
    if not FKeyCaseSensitive and (VarType(Var1) = varString) then
      Result := AnsiCompareText(Var1, Var2)
    else if Var1 = Var2 then
      Result := 0
    else if Var1 > Var2 then
      Result := 1
    else
      Result := -1
  else if VarType(Var1) > VarType(Var2) then
    Result := 1
  else
    Result := -1;
end;

procedure TArray.FreeItem(var pItem: PVarItem);
begin
  case ExtType(pItem^.Value) of
    extObject:
      if FOwnsObjects then
        TObjData(pItem^.Value).VObject.Free;
    extMultiArray:
      TMltData(pItem^.Value).VMultiArray := nil;
  end;
  Dispose(pItem);
end;

procedure TArray.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else if FCapacity > 8 then
    Delta := 16
  else
    Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

procedure TArray.QuickSort(L, R: Integer);
var
  I, J, P: Integer;
  _Item: PVarItem;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while FValueCompare(FValues^[I]^.Value, FValues^[P]^.Value) < 0 do
        Inc(I);
      while FValueCompare(FValues^[J]^.Value, FValues^[P]^.Value) > 0 do
        Dec(J);
      if I <= J then
      begin
        _Item := FValues^[I];
        FValues^[I] := FValues^[J];
        FValues^[J] := _Item;
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TArray.SetCapacity(const Value: Integer);
begin
  ReallocMem(FKeys, Value * SizeOf(PVarItem));
  ReallocMem(FValues, Value * SizeOf(PVarItem));
  FCapacity := Value;
end;

function TArray.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

function TArray.GetValue(Index: Integer): Variant;
begin
  if (Index >= 0) and (Index < FCount) then
    AssignVar(Result, FValues^[Index]^.Value)
  else
    raise EArrayError.CreateResFmt(@SArrayIndexOutOfBounds, [Index]);
end;

function TArray.GetKey(Index: Integer): Variant;
begin
  if (Index >= 0) and (Index < FCount) then
    Result := FValues^[Index]^.Key
  else
    raise EArrayError.CreateResFmt(@SArrayIndexOutOfBounds, [Index]);
end;

function TArray.GetItem(Key: Variant): Variant;
var
  Index: Integer;
begin
  if FindInternalKeyIndex(Key, Index) then
    AssignVar(Result, FKeys^[Index]^.Value)
  else
    Result := Unassigned;
end;

procedure TArray.SetItem(Key: Variant; const Value: Variant);
var
  KeyIndex, NewIndex, Index: Integer;
  _Item: PVarItem;
begin
  if FindInternalKeyIndex(Key, KeyIndex) then
    if FSorted then
    begin
      Index := GetInternalValueIndex(KeyIndex);
      FindValue(Value, NewIndex);
      _Item := FValues^[Index];
      if NewIndex > Index then
      begin
        Dec(NewIndex);
        if Index < NewIndex then
          Move(FValues^[Index + 1], FValues^[Index], (NewIndex - Index) * SizeOf(PVarItem));
      end
      else if NewIndex < Index then
        Move(FValues^[NewIndex], FValues^[NewIndex + 1], (Index - NewIndex) * SizeOf(PVarItem));
      FValues^[NewIndex] := _Item;
      AssignVar(FValues^[NewIndex]^.Value, Value);
    end
    else
      AssignVar(FKeys^[KeyIndex]^.Value, Value)
  else
  begin
    if FCount = FCapacity then
      Grow;
    if KeyIndex < FCount then
      Move(FKeys^[KeyIndex], FKeys^[KeyIndex + 1], (FCount - KeyIndex) * SizeOf(PVarItem));
    New(FKeys^[KeyIndex]);
    FKeys^[KeyIndex]^.Key := Key;
    AssignVar(FKeys^[KeyIndex]^.Value, Value);
    if FSorted then
    begin
      FindValue(Value, Index);
      if Index < FCount then
        Move(FValues^[Index], FValues^[Index + 1], (FCount - Index) * SizeOf(PVarItem));
    end
    else
      Index := FCount;
    FValues^[Index] := FKeys^[KeyIndex];
    Inc(FCount);
  end;
end;

function TArray.GetCount: Integer;
begin
  Result := FCount;
end;

function TArray.GetBof: Boolean;
begin
  Result := FBof;
end;

function TArray.GetCurrentIndex: Integer;
begin
  Result := FCurrentIndex;
end;

function TArray.GetCurrentKey: Variant;
begin
  Result := GetKey(FCurrentIndex);
end;

function TArray.GetCurrentValue: Variant;
begin
  Result := GetValue(FCurrentIndex);
end;

function TArray.GetEof: Boolean;
begin
  Result := FEof;
end;

procedure TArray.SetCurrentIndex(const Value: Integer);
begin
  FCurrentIndex := Value;
  if FCurrentIndex < 0 then
  begin
    FCurrentIndex := 0;
    FBof := True;
  end
  else
    FBof := False;
  if FCurrentIndex >= FCount then
  begin
    FCurrentIndex := FCount - 1;
    FEof := True;
  end
  else
    FEof := False;
end;

procedure TArray.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    if Value then
      Sort;
    FSorted := Value;
  end;
end;

function TArray.GetSorted: Boolean;
begin
  Result := FSorted;
end;

procedure TArray.SetKeyCaseSensitive(const Value: Boolean);
begin
  FKeyCaseSensitive := Value;
end;

function TArray.GetKeyCaseSensitive: Boolean;
begin
  Result := FKeyCaseSensitive;
end;

function TArray.GetOwnsObjects: Boolean;
begin
  Result := FOwnsObjects;
end;

procedure TArray.SetOwnsObjects(const Value: Boolean);
begin
  FOwnsObjects := Value;
end;

function TArray.GetInstance: TArray;
begin
  Result := Self;
end;

function TArray.GetRefCount: Integer;
begin
  Result := FRefCount;
end;

function TArray.FindValueB(const Value: Boolean;
  var Index: Integer): Boolean;
begin
  Result := FindValue(Value, Index);
end;

function TArray.FindValueC(const Value: TClass;
  var Index: Integer): Boolean;
var
  V: Variant;
begin
  TClsData(V).VExtType := extClass;
  TClsData(V).VClass := Value;
  Result := FindValue(V, Index);
end;

function TArray.FindValueD(const Value: TDateTime;
  var Index: Integer): Boolean;
begin
  Result := FindValue(Value, Index);
end;

function TArray.FindValueF(const Value: Double;
  var Index: Integer): Boolean;
begin
  Result := FindValue(Value, Index);
end;

function TArray.FindValueI(const Value: Integer;
  var Index: Integer): Boolean;
begin
  Result := FindValue(Value, Index);
end;

function TArray.FindValueO(const Value: TObject;
  var Index: Integer): Boolean;
var
  V: Variant;
begin
  TObjData(V).VExtType := extObject;
  TObjData(V).VObject := Value;
  Result := FindValue(V, Index);
end;

function TArray.FindValueP(const Value: Pointer;
  var Index: Integer): Boolean;
var
  V: Variant;
begin
  TVarData(V).VType := varPointer;
  TVarData(V).VPointer := Value;
  Result := FindValue(V, Index);
end;

function TArray.FindValueS(const Value: string;
  var Index: Integer): Boolean;
begin
  Result := FindValue(Value, Index);
end;

function TArray.GetCurrentValueB: Boolean;
begin
  Result := GetCurrentValue;
end;

function TArray.GetCurrentValueC: TClass;
var
  V: Variant;
begin
  V := GetCurrentValue;
  Result := TClsData(V).VClass;
end;

function TArray.GetCurrentValueD: TDateTime;
begin
  Result := GetCurrentValue;
end;

function TArray.GetCurrentValueF: Double;
begin
  Result := GetCurrentValue;
end;

function TArray.GetCurrentValueI: Integer;
begin
  Result := GetCurrentValue;
end;

function TArray.GetCurrentValueO: TObject;
var
  V: Variant;
begin
  V := GetCurrentValue;
  Result := TObjData(V).VObject;
end;

function TArray.GetCurrentValueP: Pointer;
var
  V: Variant;
begin
  V := GetCurrentValue;
  Result := TVarData(V).VPointer;
end;

function TArray.GetCurrentValueS: string;
begin
  Result := GetCurrentValue;
end;

function TArray.GetItemB(Key: Variant): Boolean;
begin
  Result := GetItem(Key);
end;

function TArray.GetItemC(Key: Variant): TClass;
var
  V: Variant;
begin
  V := GetItem(Key);
  Result := TClsData(V).VClass;
end;

function TArray.GetItemD(Key: Variant): TDateTime;
begin
  Result := GetItem(Key);
end;

function TArray.GetItemF(Key: Variant): Double;
begin
  Result := GetItem(Key);
end;

function TArray.GetItemI(Key: Variant): Integer;
begin
  Result := GetItem(Key);
end;

function TArray.GetItemO(Key: Variant): TObject;
var
  V: Variant;
begin
  V := GetItem(Key);
  Result := TObjData(V).VObject;
end;

function TArray.GetItemP(Key: Variant): Pointer;
var
  V: Variant;
begin
  V := GetItem(Key);
  Result := TVarData(V).VPointer;
end;

function TArray.GetItemS(Key: Variant): string;
begin
  Result := GetItem(Key);
end;

function TArray.GetValueB(Index: Integer): Boolean;
begin
  Result := GetValue(Index);
end;

function TArray.GetValueC(Index: Integer): TClass;
var
  V: Variant;
begin
  V := GetValue(Index);
  Result := TClsData(V).VClass;
end;

function TArray.GetValueD(Index: Integer): TDateTime;
begin
  Result := GetValue(Index);
end;

function TArray.GetValueF(Index: Integer): Double;
begin
  Result := GetValue(Index);
end;

function TArray.GetValueI(Index: Integer): Integer;
begin
  Result := GetValue(Index);
end;

function TArray.GetValueO(Index: Integer): TObject;
var
  V: Variant;
begin
  V := GetValue(Index);
  Result := TObjData(V).VObject;
end;

function TArray.GetValueP(Index: Integer): Pointer;
var
  V: Variant;
begin
  V := GetValue(Index);
  Result := TVarData(V).VPointer;
end;

function TArray.GetValueS(Index: Integer): string;
begin
  Result := GetValue(Index);
end;

procedure TArray.SetItemB(Key: Variant; const Value: Boolean);
begin
  SetItem(Key, Value);
end;

procedure TArray.SetItemC(Key: Variant; const Value: TClass);
var
  V: Variant;
begin
  TClsData(V).VExtType := extClass;
  TClsData(V).VClass := Value;
  SetItem(Key, V);
end;

procedure TArray.SetItemD(Key: Variant; const Value: TDateTime);
begin
  SetItem(Key, Value);
end;

procedure TArray.SetItemF(Key: Variant; const Value: Double);
begin
  SetItem(Key, Value);
end;

procedure TArray.SetItemI(Key: Variant; const Value: Integer);
begin
  SetItem(Key, Value);
end;

procedure TArray.SetItemO(Key: Variant; const Value: TObject);
var
  V: Variant;
begin
  TObjData(V).VExtType := extObject;
  TObjData(V).VObject := Value;
  SetItem(Key, V);
end;

procedure TArray.SetItemP(Key: Variant; const Value: Pointer);
var
  V: Variant;
begin
  TVarData(V).VType := varPointer;
  TVarData(V).VPointer := Value;
  SetItem(Key, V);
end;

procedure TArray.SetItemS(Key: Variant; const Value: string);
begin
  SetItem(Key, Value);
end;

function TArray.FindValueI64(const Value: Int64;
  var Index: Integer): Boolean;
var
  V: Variant;
begin
  TI64Data(V).VType := varInt64;
  TI64Data(V).VInt64 := Value;
  Result := FindValue(V, Index);
end;

function TArray.GetCurrentValueI64: Int64;
var
  V: Variant;
begin
  V := GetCurrentValue;
  Result := TI64Data(V).VInt64;
end;

function TArray.GetItemI64(Key: Variant): Int64;
var
  V: Variant;
begin
  V := GetItem(Key);
  Result := TI64Data(V).VInt64;
end;

function TArray.GetValueI64(Index: Integer): Int64;
var
  V: Variant;
begin
  V := GetValue(Index);
  Result := TI64Data(V).VInt64;
end;

procedure TArray.SetItemI64(Key: Variant; const Value: Int64);
var
  V: Variant;
begin
  TI64Data(V).VType := varInt64;
  TI64Data(V).VInt64 := Value;
  SetItem(Key, V);
end;

function TArray.FindValueM(const Value: IMultiArray;
  var Index: Integer): Boolean;
var
  V: Variant;
begin
  TExtData(V).VExtType := extMultiArray;
  TExtData(V).VPointer := Pointer(Value); // дабы не потер€ть ссылку
  Result := FindValue(V, Index);
end;

function TArray.GetAsBoolean: Boolean;
begin
  Result := FValue;
end;

function TArray.GetAsClass: TClass;
begin
  Result := TClsData(FValue).VClass;
end;

function TArray.GetAsDateTime: TDateTime;
begin
  Result := FValue;
end;

function TArray.GetAsFloat: Double;
begin
  Result := FValue;
end;

function TArray.GetAsInt64: Int64;
begin
  Result := TI64Data(FValue).VInt64;
end;

function TArray.GetAsInteger: Integer;
begin
  Result := FValue;
end;

function TArray.GetAsObject: TObject;
begin
  Result := TObjData(FValue).VObject;
end;

function TArray.GetAsString: string;
begin
  Result := FValue;
end;

function TArray.GetAsVariant: Variant;
begin
  Result := FValue;
end;

function TArray.GetCurrentValueM: IMultiArray;
var
  V: Variant;
begin
  V := GetCurrentValue;
  Result := TMltData(V).VMultiArray;
  if not Assigned(Result) then
  begin
    SetItemM(FValues^[FCurrentIndex]^.Key, CreateArray(FValueCompare));
    Result := GetCurrentValueM;
  end;
end;

function TArray.GetItemM(Key: Variant): IMultiArray;
var
  V: Variant;
begin
  V := GetItem(Key);
  Result := TMltData(V).VMultiArray;
  if not Assigned(Result) then
  begin
    SetItemM(Key, CreateArray(FValueCompare));
    Result := GetItemM(Key);
  end;
end;

function TArray.GetValueM(Index: Integer): IMultiArray;
var
  V: Variant;
begin
  V := GetValue(Index);
  Result := TMltData(V).VMultiArray;
  if not Assigned(Result) then
  begin
    SetItemM(FValues^[Index]^.Key, CreateArray(FValueCompare));
    Result := GetValueM(Index);
  end;
end;

procedure TArray.SetAsBoolean(const Value: Boolean);
begin
  FValue := Value;
end;

procedure TArray.SetAsClass(const Value: TClass);
begin
  TClsData(FValue).VExtType := extClass;
  TClsData(FValue).VClass := Value;
end;

procedure TArray.SetAsDateTime(const Value: TDateTime);
begin
  FValue := Value;
end;

procedure TArray.SetAsFloat(const Value: Double);
begin
  FValue := Value;
end;

procedure TArray.SetAsInt64(const Value: Int64);
begin
  TI64Data(FValue).VType := varInt64;
  TI64Data(FValue).VInt64 := Value;
end;

procedure TArray.SetAsInteger(const Value: Integer);
begin
  FValue := Value;
end;

procedure TArray.SetAsObject(const Value: TObject);
begin
  TObjData(FValue).VExtType := extObject;
  TObjData(FValue).VObject := Value;
end;

procedure TArray.SetAsString(const Value: string);
begin
  FValue := Value;
end;

procedure TArray.SetAsVariant(const Value: Variant);
begin
  FValue := Value;
end;

procedure TArray.SetItemM(Key: Variant; const Value: IMultiArray);
var
  V: Variant;
begin
  V := GetItem(Key);
  TMltData(V).VMultiArray := nil;
  TMltData(V).VExtType := extMultiArray;
  TMltData(V).VMultiArray := Value;
  SetItem(Key, V);
end;

end.
