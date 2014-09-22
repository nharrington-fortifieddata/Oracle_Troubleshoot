@For /F "tokens=2,3,4 delims=/ " %%A in ('Date /t') do @( 
	Set Month=%%A
	Set Day=%%B
	Set Year=%%C
	Set ShortYear=%Year:~2%
)

set today=%year%%month%%day%
c:\
cd c:\jde\archive
if not exist c:\jde\archive\%today% mkdir %today%
cd c:\jde
move %ShortYear%%Month%%Day%*.SNT c:\jde\archive\%today%\.




