set VARS=--enable-checked-mode
set VARS=%VARS% --analyze-all
rem set VARS=%VARS% --enable-diagnostic-colors
set VARS=%VARS% --enable-concrete-type-inference
set VARS=%VARS% --reject-deprecated-language-features
set VARS=%VARS% --report-sdk-use-of-deprecated-language-features
set VARS=%VARS% --library-root="E:\Users\Sergey\Documents\dart\editor\dart-sdk"
dart2js %VARS% "example/hello/hello.dart"