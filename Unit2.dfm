object Form2: TForm2
  Left = 0
  Top = 0
  Align = alTop
  Caption = 'WMS'
  ClientHeight = 728
  ClientWidth = 1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 22
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 648
    Align = alLeft
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 1
      Top = 566
      Width = 183
      Height = 81
      Align = alBottom
      Caption = #28204#35430'WMS'#32178#22336
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object Panel2: TPanel
    Left = 185
    Top = 0
    Width = 918
    Height = 648
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object ComboBox1: TComboBox
      Left = 1
      Top = 1
      Width = 916
      Height = 30
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'ComboBox1'
      Items.Strings = (
        #22294#23652#21517#31281
        '1/5000'#22522#26412#22320#24418#22294
        #32291#24066#30028
        #33274#28771#36890#29992#38651#23376#22320#22294'('#28784#38542')'
        #33274#28771#36890#29992#38651#23376#22320#22294#36879#26126'('#28961#38272#29260')'
        #33274#28771#36890#29992#38651#23376#22320#22294'('#31561#39640#32218#28961#38272#29260')'
        #33274#28771#36890#29992#38651#23376#22320#22294'('#28961#31561#39640#32218#21450#38272#29260')'
        #33274#28771#36890#29992#38651#23376#22320#22294#36879#26126
        #33274#28771#36890#29992#38651#23376#22320#22294'('#22871#30090#31561#39640#32218')OpenData'#26368#22823#27604#20363#23610#19968#33836#20843#21315#20998#20043#19968
        #33274#28771#36890#29992#38651#23376#22320#22294'('#31561#39640#32218'+'#38272#29260')'
        #33274#28771#36890#29992#38651#23376#22320#22294'('#19981#21547#31561#39640#32218')OpenData'#26368#22823#27604#20363#23610#19968#33836#20843#21315#20998#20043#19968
        #33274#28771#36890#29992#38651#23376#22320#22294'('#28961#31561#39640#32218')'
        'TaiwanE-Map(Transparent)'
        'TaiwanE-Map(EN)'
        #33274#28771#36890#29992#38651#23376#22320#22294'('#39640'DPI'#23383')'
        'Taiwan e-Map(new)'
        #33274#28771#36890#29992#38651#23376#22320#22294'('#26032')'
        #33274#28771#36890#29992#38651#23376#22320#22294'('#28961#37941#20844#36335')'
        #33274#28771#36890#29992#38651#23376#22320#22294'('#28961#25991#23383')'
        #33274#28771#36890#29992#38651#23376#22320#22294
        #27573#31821#22294
        #22283#22303#21033#29992#35519#26597'-1'#39006#36786#26989
        #22283#22303#21033#29992#35519#26597'-2'#39006#26862#26519
        #22283#22303#21033#29992#35519#26597'-3'#39006#20132#36890
        #22283#22303#21033#29992#35519#26597'-4'#39006#27700#21033
        #22283#22303#21033#29992#35519#26597'-5'#39006#24314#31689
        #22283#22303#21033#29992#35519#26597'-6'#39006#20844#20849
        #22283#22303#21033#29992#35519#26597'-7'#39006#36938#25001
        #22283#22303#21033#29992#35519#26597'-8'#39006#31014#40573
        #22283#22303#21033#29992#35519#26597'-9'#39006#20854#20182
        #22283#22303#21033#29992#35519#26597#25104#26524#22294
        #22320#25919#20107#21209#25152#36676#21312#22294
        '1/5000'#22294#24133#26694
        #22369#21521#22294
        #31561#39640#32218#22294'(2010-2015)'
        #31561#39640#32218#22294'(2003-2005)'
        #38512#24433#22294
        #28210#26579#22294
        #22369#24230#22294'-30%'#22369'(2010-2015)'
        #22369#24230#22294'-30%'#22369'(2003-2005)'
        #22369#24230#22294'-7'#32026'(2010-2015)'
        #22369#24230#22294'-7'#32026'(2003-2005)'
        #27491#23556#24433#20687#22294'('#36890#29992')'
        #27491#23556#24433#20687'('#28151#21512')'
        #36947#36335#36335#32178
        #21508#32026#23416#26657#31684#22285#22294
        #37129#37806#21312#30028
        #26449#37324#30028)
    end
    object WebBrowser1: TWebBrowser
      Left = 1
      Top = 31
      Width = 916
      Height = 616
      Align = alClient
      TabOrder = 1
      ExplicitLeft = -3
      ExplicitTop = 26
      ExplicitHeight = 517
      ControlData = {
        4C000000BD4B0000EF3200000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 648
    Width = 1103
    Height = 80
    Align = alBottom
    TabOrder = 2
    object btnWMS: TBitBtn
      Left = 1
      Top = 1
      Width = 159
      Height = 78
      Align = alLeft
      Caption = 'test WMS'
      TabOrder = 0
      OnClick = btnWMSClick
    end
    object BitBtn2: TBitBtn
      Left = 312
      Top = 15
      Width = 105
      Height = 57
      Caption = #25918#22823
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 432
      Top = 14
      Width = 105
      Height = 57
      Caption = #32302#23567
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 976
    Top = 48
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 984
    Top = 128
  end
end
