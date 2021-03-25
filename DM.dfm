object DM1: TDM1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 374
  Width = 431
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=H:\0_'#20844#21496'\'#22283#22303#28204#32362#20013#24515'WMS'#26381#21209 +
      '\Win32\Debug\wms.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 64
    Top = 64
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'wms'#22294#23652
    Left = 200
    Top = 80
    object ADOTable1識別碼: TAutoIncField
      FieldName = #35672#21029#30908
      ReadOnly = True
    end
    object ADOTable1圖層名稱: TWideStringField
      FieldName = #22294#23652#21517#31281
      Size = 255
    end
    object ADOTable1圖層ID: TWideStringField
      FieldName = #22294#23652'ID'
      Size = 255
    end
  end
end
