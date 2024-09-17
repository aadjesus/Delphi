unit u_crypto;

interface

function Encrypt(InString: String): String;

function Decrypt(InString: String): String;

implementation

const
  StartKey	= 321;  {Start default key}
  MultKey	= 1;	{Mult default key}
  AddKey	= 3;	{Add default key}

function Encrypt(InString: String): String;
var
  I : Byte;
  lStartKey: LongInt;
  str_local, str_result: String;
begin
{$R-}
{$Q-}
  str_local  := InString;
  str_result := '';
  lStartKey  := StartKey;
  for I := 1 to Length(str_local) do
  begin
    str_result := str_result + CHAR(Byte(str_local[I]) xor (lStartKey shr 8));
    lStartKey := (Byte(str_result[I]) + lStartKey) * MultKey + AddKey;
  end;
  Result:=str_result;
{$R+}
{$Q+}
end;

function Decrypt(InString: String): String;
var
  I : Byte;
  lStartKey: LongInt;
  str_local, str_result: String;
begin
{$R-}
{$Q-}
  str_local  := InString;
  str_result := '';
  lStartKey  := StartKey;
  for I := 1 to Length(str_local) do
  begin
    str_result := str_result + CHAR(Byte(str_local[I]) xor (lStartKey shr 8));
    lStartKey := (Byte(str_result[I]) + lStartKey) * MultKey + AddKey;
  end;
  Result:=str_result;
{$R+}
{$Q+}
end;

end.
