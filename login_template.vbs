Dim http
Dim url, username, password
Dim maxRetries, retryDelay, i

' Configuration
url = "https://localhost:47990/"
username = "{{USERNAME}}"
password = "{{PASSWORD}}"
maxRetries = 24  ' 24 * 5 seconds = 2 minutes max wait
retryDelay = 5000 ' 5 seconds in milliseconds

Set http = CreateObject("WinHttp.WinHttpRequest.5.1")

Function TryLogin()
    On Error Resume Next
    http.Open "GET", url, False
    http.SetCredentials username, password, 0
    ' Ignore SSL errors
    http.Option(4) = 13056
    http.Send
    
    If Err.Number <> 0 Then
        TryLogin = False
    Else
        If http.Status = 200 Then
            TryLogin = True
        Else
            TryLogin = False
        End If
    End If
    On Error GoTo 0
End Function

' Main Loop
For i = 1 To maxRetries
    If TryLogin() Then
        ' Success!
        Exit For
    End If
    
    ' Wait before retrying (using WScript.Sleep)
    WScript.Sleep retryDelay
Next

' Clean up
Set http = Nothing
