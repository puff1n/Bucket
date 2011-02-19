object Form1: TForm1
  Left = 202
  Top = 82
  Width = 884
  Height = 649
  Caption = 'Generating SQL Query'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 14
    Width = 20
    Height = 24
    Caption = 'Q:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label6: TLabel
    Left = 16
    Top = 40
    Width = 72
    Height = 13
    Caption = 'Classes / types'
  end
  object TestMemo: TMemo
    Left = 824
    Top = 56
    Width = 137
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 4
    Visible = False
  end
  object ListBox1: TListBox
    Left = 824
    Top = 8
    Width = 185
    Height = 41
    ItemHeight = 13
    Items.Strings = (
      
        'SELECT MODEL, CATEGORY, YEAR, PRICE FROM WorldView WHERE type=Ca' +
        'rForSale or type=Motorcycle and type<>UsedCar and year>1950'
      'SELECT * FROM WorldView;')
    TabOrder = 2
    Visible = False
    OnClick = ListBox1Click
  end
  object Classes: TGroupBox
    Left = 648
    Top = 8
    Width = 137
    Height = 129
    Caption = 'Classes / types'
    TabOrder = 1
    Visible = False
    object CheckCar: TCheckBox
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Car'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckCarClick
    end
    object CheckCarForSale: TCheckBox
      Left = 24
      Top = 48
      Width = 97
      Height = 17
      Caption = 'CarForSale'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckCarForSaleClick
    end
    object CheckUsedCar: TCheckBox
      Left = 32
      Top = 64
      Width = 97
      Height = 17
      Caption = 'UsedCar'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = CheckUsedCarClick
    end
    object CheckNewCar: TCheckBox
      Left = 32
      Top = 80
      Width = 97
      Height = 17
      Caption = 'NewCar'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = CheckNewCarClick
    end
    object CheckMotorcycle: TCheckBox
      Left = 16
      Top = 104
      Width = 97
      Height = 17
      Caption = 'Motorcycle'
      TabOrder = 4
    end
  end
  object Edit1: TEdit
    Left = 40
    Top = 16
    Width = 593
    Height = 21
    TabOrder = 0
    Text = '<Enter SQL-query>'
    Visible = False
  end
  object GlobalPageControl: TPageControl
    Left = 16
    Top = 24
    Width = 841
    Height = 537
    ActivePage = WorkTab
    TabOrder = 6
    object WorkTab: TTabSheet
      Caption = 'Work'
      object WorkPageControl: TPageControl
        Left = 0
        Top = 4
        Width = 833
        Height = 501
        ActivePage = SQLTab
        MultiLine = True
        TabOrder = 0
        object SQLTab: TTabSheet
          Caption = 'SQL'
          object ClearButton: TButton
            Left = 8
            Top = 436
            Width = 75
            Height = 25
            Caption = 'Clear'
            TabOrder = 0
            OnClick = ClearButtonClick
          end
          object SQLToBucket: TButton
            Left = 584
            Top = 436
            Width = 225
            Height = 25
            Caption = 'Go with SQL Query >>'
            TabOrder = 1
            OnClick = SQLToBucketClick
          end
          object GeneratedQuery: TMemo
            Left = 8
            Top = 356
            Width = 569
            Height = 69
            Lines.Strings = (
              'Generated SQL Query here')
            ScrollBars = ssVertical
            TabOrder = 2
          end
          object Attribs: TGroupBox
            Left = 8
            Top = 144
            Width = 569
            Height = 209
            Caption = 'What to search and show'
            TabOrder = 3
            object Model: TCheckBox
              Left = 144
              Top = 24
              Width = 97
              Height = 17
              Caption = 'Search Model'
              TabOrder = 0
              OnClick = ModelClick
            end
            object SearchModel: TEdit
              Left = 16
              Top = 24
              Width = 121
              Height = 21
              TabOrder = 1
              Text = '<Name of Model>'
              OnEnter = SearchModelEnter
              OnExit = SearchModelExit
            end
            object SearchCategory: TEdit
              Left = 16
              Top = 56
              Width = 121
              Height = 21
              TabOrder = 2
              Text = '<Category>'
              OnEnter = SearchCategoryEnter
              OnExit = SearchCategoryExit
            end
            object Category: TCheckBox
              Left = 144
              Top = 56
              Width = 97
              Height = 17
              Caption = 'Search Category'
              TabOrder = 3
              OnClick = CategoryClick
            end
            object Year: TCheckBox
              Left = 16
              Top = 88
              Width = 81
              Height = 17
              Caption = 'Show Year'
              TabOrder = 4
            end
            object Price: TCheckBox
              Left = 144
              Top = 88
              Width = 97
              Height = 17
              Caption = 'Show Price'
              TabOrder = 5
            end
            object CheckAll: TCheckBox
              Left = 336
              Top = 16
              Width = 81
              Height = 17
              Alignment = taLeftJustify
              Caption = 'SHOW ALL'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              TabOrder = 6
              OnClick = CheckAllClick
            end
            object GenerateButton: TButton
              Left = 424
              Top = 160
              Width = 137
              Height = 41
              Caption = 'Generate SQL Query'
              TabOrder = 7
              OnClick = GenerateButtonClick
            end
          end
          object GroupBox1: TGroupBox
            Left = 24
            Top = 264
            Width = 225
            Height = 73
            Caption = 'Addition Capabilities'
            TabOrder = 4
            object ProductReview: TCheckBox
              Left = 16
              Top = 20
              Width = 145
              Height = 17
              Caption = 'Show ProductReview'
              TabOrder = 0
            end
            object SellerContact: TCheckBox
              Left = 16
              Top = 44
              Width = 161
              Height = 17
              Caption = 'Show SellerContact'
              TabOrder = 1
            end
          end
          object Restrictions: TGroupBox
            Left = 152
            Top = 9
            Width = 425
            Height = 128
            Caption = 'Restrictions'
            TabOrder = 5
            object YearCaption: TLabel
              Left = 16
              Top = 27
              Width = 22
              Height = 13
              Caption = 'Year'
            end
            object PriceCaption: TLabel
              Left = 16
              Top = 60
              Width = 24
              Height = 13
              Caption = 'Price'
            end
            object Label2: TLabel
              Left = 48
              Top = 27
              Width = 20
              Height = 13
              Caption = 'from'
            end
            object Label3: TLabel
              Left = 48
              Top = 60
              Width = 20
              Height = 13
              Caption = 'from'
            end
            object Label4: TLabel
              Left = 256
              Top = 29
              Width = 9
              Height = 13
              Caption = 'to'
            end
            object Label5: TLabel
              Left = 256
              Top = 61
              Width = 9
              Height = 13
              Caption = 'to'
            end
            object Restriction1min: TComboBox
              Left = 80
              Top = 25
              Width = 73
              Height = 21
              ItemHeight = 13
              TabOrder = 0
              Text = '1960'
              Items.Strings = (
                'any'
                '1960'
                '1961'
                '1962'
                '1963'
                '1964'
                '1965'
                '1966'
                '1967'
                '1968'
                '1969'
                '1970'
                '1971'
                '1972'
                '1973'
                '1974'
                '1975'
                '1976'
                '1977'
                '1978'
                '1979'
                '1980'
                '1981'
                '1982'
                '1983'
                '1984'
                '1985'
                '1986'
                '1987'
                '1988'
                '1989'
                '1990'
                '1991'
                '1992'
                '1993'
                '1994'
                '1995'
                '1996'
                '1997'
                '1998'
                '1999'
                '2000'
                '2001'
                '2002'
                '2003'
                '2004'
                '2005'
                '2006'
                '2007'
                '2008'
                '2009'
                '2010'
                '2011')
            end
            object Restriction2min: TComboBox
              Left = 80
              Top = 59
              Width = 73
              Height = 21
              ItemHeight = 13
              TabOrder = 1
              Text = '1000'
              Items.Strings = (
                'any'
                '1000'
                '1500'
                '2000'
                '2500'
                '3000'
                '3500'
                '4000'
                '4500'
                '5000'
                '5500'
                '6000'
                '6500'
                '7000'
                '7500'
                '8000'
                '8500'
                '9000'
                '9500'
                '10000'
                '10500'
                '11000'
                '11500'
                '12000'
                '12500'
                '13000'
                '13500'
                '14000'
                '14500'
                '15000')
            end
            object Restriction1max: TComboBox
              Left = 272
              Top = 26
              Width = 73
              Height = 21
              ItemHeight = 13
              TabOrder = 2
              Text = '1980'
              Items.Strings = (
                'any'
                '1960'
                '1961'
                '1962'
                '1963'
                '1964'
                '1965'
                '1966'
                '1967'
                '1968'
                '1969'
                '1970'
                '1971'
                '1972'
                '1973'
                '1974'
                '1975'
                '1976'
                '1977'
                '1978'
                '1979'
                '1980'
                '1981'
                '1982'
                '1983'
                '1984'
                '1985'
                '1986'
                '1987'
                '1988'
                '1989'
                '1990'
                '1991'
                '1992'
                '1993'
                '1994'
                '1995'
                '1996'
                '1997'
                '1998'
                '1999'
                '2000'
                '2001'
                '2002'
                '2003'
                '2004'
                '2005'
                '2006'
                '2007'
                '2008'
                '2009'
                '2010'
                '2011')
            end
            object Restriction2max: TComboBox
              Left = 272
              Top = 60
              Width = 73
              Height = 21
              ItemHeight = 13
              TabOrder = 3
              Text = '10000'
              Items.Strings = (
                'any'
                '1000'
                '1500'
                '2000'
                '2500'
                '3000'
                '3500'
                '4000'
                '4500'
                '5000'
                '5500'
                '6000'
                '6500'
                '7000'
                '7500'
                '8000'
                '8500'
                '9000'
                '9500'
                '10000'
                '10500'
                '11000'
                '11500'
                '12000'
                '12500'
                '13000'
                '13500'
                '14000'
                '14500'
                '15000')
            end
            object SetRestrictionsToAny: TButton
              Left = 80
              Top = 88
              Width = 169
              Height = 25
              Caption = 'Does not matter'
              TabOrder = 4
              OnClick = SetRestrictionsToAnyClick
            end
            object RestrictionInc1max: TCheckBox
              Left = 352
              Top = 32
              Width = 65
              Height = 17
              Caption = 'including'
              Checked = True
              State = cbChecked
              TabOrder = 5
            end
            object RestrictionInc2max: TCheckBox
              Left = 352
              Top = 64
              Width = 65
              Height = 17
              Caption = 'including'
              Checked = True
              State = cbChecked
              TabOrder = 6
            end
            object RestrictionInc1min: TCheckBox
              Left = 160
              Top = 32
              Width = 81
              Height = 17
              Caption = 'including'
              Checked = True
              State = cbChecked
              TabOrder = 7
            end
            object RestrictionInc2min: TCheckBox
              Left = 160
              Top = 64
              Width = 65
              Height = 17
              Caption = 'including'
              Checked = True
              State = cbChecked
              TabOrder = 8
            end
          end
          object TestMemo2: TMemo
            Left = 584
            Top = 44
            Width = 225
            Height = 381
            ScrollBars = ssVertical
            TabOrder = 6
          end
          object CreateBucket: TButton
            Left = 584
            Top = 16
            Width = 105
            Height = 25
            Caption = 'Create Bucket'
            TabOrder = 7
            OnClick = CreateBucketClick
          end
          object ClearLog: TButton
            Left = 729
            Top = 16
            Width = 75
            Height = 25
            Caption = 'Clear log'
            TabOrder = 8
            OnClick = ClearLogClick
          end
          object ClassList: TCheckListBox
            Left = 8
            Top = 16
            Width = 137
            Height = 121
            ItemHeight = 13
            TabOrder = 9
          end
        end
        object BucketTab: TTabSheet
          Caption = 'Bucket'
          ImageIndex = 1
        end
        object QueryPlanTab: TTabSheet
          Caption = 'Query Plan'
          ImageIndex = 2
        end
        object ResultsTab: TTabSheet
          Caption = 'Results'
          ImageIndex = 3
        end
      end
    end
    object SettingsTab: TTabSheet
      Caption = 'Settings'
      ImageIndex = 1
      object SettingsPageControl: TPageControl
        Left = 0
        Top = 8
        Width = 833
        Height = 497
        ActivePage = ClassesTab
        TabOrder = 0
        object SourcesTab: TTabSheet
          Caption = 'Sources'
        end
        object CapabilitiesTab: TTabSheet
          Caption = 'Capabilities'
          ImageIndex = 1
        end
        object ClassesTab: TTabSheet
          Caption = 'Classes'
          ImageIndex = 2
        end
      end
    end
  end
  object Quit: TButton
    Left = 784
    Top = 568
    Width = 75
    Height = 25
    Caption = 'Quit'
    TabOrder = 3
    OnClick = QuitClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 603
    Width = 876
    Height = 19
    Panels = <>
    SimplePanel = True
  end
end
