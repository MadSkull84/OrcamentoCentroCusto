unit uConfigOrcamentoCentroCusto;

interface

type
  TConfigOrcamentoCentroCusto = class
  private
    FDataBase: String;
    FDataBaseUser: String;
    FDataBasePassword: String;
    FDataBaseIp: String;
    FDataBasePort: String;
  public
    property DataBase: String read FDataBase write FDataBase;
    property DataBaseUser: String read FDataBaseUser write FDataBaseUser;
    property DataBasePassword: String read FDataBasePassword write FDataBasePassword;
    property DataBaseIp: String read FDataBaseIp write FDataBaseIp;
    property DataBasePort: String read FDataBasePort write FDataBasePort;
  end;

implementation

end.
