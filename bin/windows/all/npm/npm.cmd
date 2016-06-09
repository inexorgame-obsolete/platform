:: modified by Inexor
:: BE CAREFUL NOT TO BREAK THINKS HERE WHEN UPGRADING NPM
:: NODE_EXE NEEDS TO BE DEFINED IN A WAY THAT WE ARE USING THE OUR SHIPPED VERSION OF NODE!
:: NODE_EXE IS DEFINED IN tool/node_windows_generic_handler.bat
:: called by tool/node_windows_generic_handler.bat

SET "NPM_CLI_JS=%~dp0\node_modules\npm\bin\npm-cli.js"
FOR /F "delims=" %%F IN ('CALL "%NODE_EXE%" "%NPM_CLI_JS%" prefix -g') DO (
  SET "NPM_PREFIX_NPM_CLI_JS=%%F\node_modules\npm\bin\npm-cli.js"
)
IF EXIST "%NPM_PREFIX_NPM_CLI_JS%" (
  SET "NPM_CLI_JS=%NPM_PREFIX_NPM_CLI_JS%"
)

"%NODE_EXE%" "%NPM_CLI_JS%" %*
