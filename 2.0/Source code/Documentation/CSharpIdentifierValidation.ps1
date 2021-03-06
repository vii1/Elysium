﻿$identifier = "@?[_\p{Lu}\p{Ll}\p{Lt}\p{Lm}\p{Lo}\p{Nl}][\p{Lu}\p{Ll}\p{Lt}\p{Lm}\p{Lo}\p{Nl}\p{Nd}\p{Pc}\p{Mn}\p{Mc}\p{Cf}]*"

$documentationNamespace = "N:($identifier\.)*$identifier"

$genericIdentifier = "$identifier(``[1-9][0-9]*)?"
$documentationType = "T:($identifier\.)+($genericIdentifier\.)*($genericIdentifier)+"

$documentationField = "F:($identifier\.)+($genericIdentifier\.)+$identifier"

$arrays = "(\[(0:,)+(0:)\])*(\[\])*"
$typeExtensions = "(\*[\*]?)?$arrays"

$type = "($identifier\.)+($identifier\.)*($identifier)+"
$advancedType = "$type$typeExtensions"
$genericTypeParameterExtension = "(\{($advancedType,)*($advancedType)+\})?"
$genericTypeParameterExtension2 = "(\{($type$genericTypeParameterExtension$typeExtensions,)*($type$genericTypeParameterExtension$typeExtensions)+\})?"
$advancedTypeParameter = "$type$genericTypeParameterExtension2$typeExtensions"

$typeGenericParameter = "``[0-9]*"
$genericParameter = "``[``]?[0-9]*"

$ctorParameter = "($typeGenericParameter$arrays[@]?|$advancedTypeParameter[@]?)"
$parameter = "($genericParameter$arrays[@]?|$advancedTypeParameter[@]?)"

$ctorParameters = "($ctorParameter,)*$ctorParameter+"
$parameters = "($parameter,)*$parameter+"

$methodGenericIdentifier = "$identifier(````[1-9][0-9]*)?"
$ctor = "#ctor(\($ctorParameters\))?"
$method = "$methodGenericIdentifier(\($parameters\)(~$type)?)?"
$documentationMethod = "M:($identifier\.)+($genericIdentifier\.)+(#cctor|$ctor|$method)"

$propParameter = "($typeGenericParameter|$advancedTypeParameter)"
$propParameters = "($propParameter\,)*$propParameter+"
$documentationProperty = "P:($identifier\.)+($genericIdentifier\.)+($identifier|Item(\($propParameters\)))"

$documentationEvent = "E:($identifier\.)+($genericIdentifier\.)+$identifier"

$documentationError = "!:(.)+"

$documentationValidators = "($documentationNamespace)|($documentationType)|($documentationField)|($documentationProperty)|($documentationMethod)|($documentationEvent)|($documentationError)" + "`r`n`r`n$documentationNamespace`r`n`r`n$documentationType`r`n`r`n$documentationField`r`n`r`n$documentationProperty`r`n`r`n$documentationMethod`r`n`r`n$documentationEvent`r`n`r`n$documentationError"

out-file -filepath CSharpIdentifierValidation.txt -inputobject $documentationValidators -encoding utf8
# SIG # Begin signature block
# MIIM6AYJKoZIhvcNAQcCoIIM2TCCDNUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU+O6WSbTGXy1rsPV1pgf54FqE
# NCygggokMIIENjCCAx6gAwIBAgIDBHpTMA0GCSqGSIb3DQEBBQUAMD4xCzAJBgNV
# BAYTAlBMMRswGQYDVQQKExJVbml6ZXRvIFNwLiB6IG8uby4xEjAQBgNVBAMTCUNl
# cnR1bSBDQTAeFw0wOTAzMDMxMjUzNTZaFw0yNDAzMDMxMjUzNTZaMHgxCzAJBgNV
# BAYTAlBMMSIwIAYDVQQKExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYD
# VQQLEx5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxHDAaBgNVBAMTE0Nl
# cnR1bSBMZXZlbCBJSUkgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCfUZZcS3wuSUcINT8L7UkdKmpeWGhNCNc/eJdyMUTcYZT1lOnTzZ0drfHk+QeR
# +f6kCZz7x54x4xsD3Pz1xUsiqa26p+GVZWOsK+KA/WF2Z+jEpDz+dOh2eB5JpRR5
# 3HSmn7YSiq4NWfxagCWYwEic28sPd+eG9bLH1k67h1AGTnb1t4wof1/i2uowieRE
# hu5V95V57wyIyn//XyUS7ymkw9/IUZ6LEJVX+urdN71Kpl9qlUXXvPOVUrMU8w6J
# OhO7gEA8y6D6jtKmRHLcN/4Ug+0Ag/GQEfwO8UPsbfBzA8sMfteClhw3zufuKGSr
# tW8GWqAESrYNe1Wce2sYwlrHAgMBAAGjggEBMIH+MA8GA1UdEwEB/wQFMAMBAf8w
# DgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQEydqa3EpJd68wAwRmLsfO8vgXfTBS
# BgNVHSMESzBJoUKkQDA+MQswCQYDVQQGEwJQTDEbMBkGA1UEChMSVW5pemV0byBT
# cC4geiBvLm8uMRIwEAYDVQQDEwlDZXJ0dW0gQ0GCAwEAIDAsBgNVHR8EJTAjMCGg
# H6AdhhtodHRwOi8vY3JsLmNlcnR1bS5wbC9jYS5jcmwwOgYDVR0gBDMwMTAvBgRV
# HSAAMCcwJQYIKwYBBQUHAgEWGWh0dHBzOi8vd3d3LmNlcnR1bS5wbC9DUFMwDQYJ
# KoZIhvcNAQEFBQADggEBAIvCzDjOR2ApbA5IvG47OAoN4BefeTwRspwdkMm9vwOi
# WfKwVOI7kh+pb2MiF5xYpEEdYeuZJCjwcMcqzOgZ4CiQXOQ0kdFQaPxuxX9kijCP
# hm0sWVRimGGiXSs7KLBx/vRcaFjm/NNhlwQ6z+yx3XIfc26Zc8hqpF993Z2ei4x7
# 6sXsd/dkDu3u5a1GzBplTq9EHW5nZENquQxv1gQfX+Ua4Dmp9a/9tchmbDMPc+VD
# IaT99SO1cfHS7OyzUX0Ew7mZfEyeRo3N9GP8To60q8eCyJNuBEySttNcHmGKKiM2
# bjjSPqSvHnXaJTMwWP7o0/krJu183xKbIVOaDLEafn4wggXmMIIEzqADAgECAhBy
# Ns+bzOD8lq3+eRECdJKyMA0GCSqGSIb3DQEBBQUAMHgxCzAJBgNVBAYTAlBMMSIw
# IAYDVQQKExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYDVQQLEx5DZXJ0
# dW0gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxHDAaBgNVBAMTE0NlcnR1bSBMZXZl
# bCBJSUkgQ0EwHhcNMTMwOTA2MDg0MTE2WhcNMTQwOTA2MDg0MTE2WjCBjDELMAkG
# A1UEBhMCUlUxHjAcBgNVBAoMFU9wZW4gU291cmNlIERldmVsb3BlcjE0MDIGA1UE
# AwwrT3BlbiBTb3VyY2UgRGV2ZWxvcGVyLCBBbGVrc2FuZHIgVmlzaG55YWtvdjEn
# MCUGCSqGSIb3DQEJARYYYXN2aXNobnlha292QGhvdG1haWwuY29tMIIBIjANBgkq
# hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxViU/8XgIGzIYzK35FPMPgV+plbOuj7c
# J2lv61DHLih78rPRC0pHyJwyfwpml1LPcTo7IPaLrDvUYyRj7d8PT4G/9ov5NO4l
# J5HZFZyoUFbHzveA0LU6ZXeDD3TeG4byjnenbaK6pPeuVevLabEd6qqfvoNsruBU
# nJLnVGoDMnGa24EV9WyJNhmF8M8BcHIF/3+bkvs/GpJ6GJyb6W/Fz/lASk6YC4Xd
# 1G0Fxtwy7TJhBZNJnwyzOLwRLJfdoWFpamywdYvARWihYFEQzml/acRRXsbH7jFp
# cq2vSit6Avbgv7WRhvdo3epDe6PcGkgZQx7TyMiKX97rSzcjRehQiwIDAQABo4IC
# VTCCAlEwDAYDVR0TAQH/BAIwADAsBgNVHR8EJTAjMCGgH6AdhhtodHRwOi8vY3Js
# LmNlcnR1bS5wbC9sMy5jcmwwWgYIKwYBBQUHAQEETjBMMCEGCCsGAQUFBzABhhVo
# dHRwOi8vb2NzcC5jZXJ0dW0ucGwwJwYIKwYBBQUHMAKGG2h0dHA6Ly93d3cuY2Vy
# dHVtLnBsL2wzLmNlcjAfBgNVHSMEGDAWgBQEydqa3EpJd68wAwRmLsfO8vgXfTAd
# BgNVHQ4EFgQUfwKeHfqapXNoIJqLdQP3q/OBHSIwDgYDVR0PAQH/BAQDAgeAMIIB
# PQYDVR0gBIIBNDCCATAwggEsBgoqhGgBhvZ3AgIDMIIBHDAlBggrBgEFBQcCARYZ
# aHR0cHM6Ly93d3cuY2VydHVtLnBsL0NQUzCB8gYIKwYBBQUHAgIwgeUwIBYZVW5p
# emV0byBUZWNobm9sb2dpZXMgUy5BLjADAgEHGoHAVXNhZ2Ugb2YgdGhpcyBjZXJ0
# aWZpY2F0ZSBpcyBzdHJpY3RseSBzdWJqZWN0ZWQgdG8gdGhlIENFUlRVTSBDZXJ0
# aWZpY2F0aW9uIFByYWN0aWNlIFN0YXRlbWVudCAoQ1BTKSBpbmNvcnBvcmF0ZWQg
# YnkgcmVmZXJlbmNlIGhlcmVpbiBhbmQgaW4gdGhlIHJlcG9zaXRvcnkgYXQgaHR0
# cHM6Ly93d3cuY2VydHVtLnBsL3JlcG9zaXRvcnkuMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMBEGCWCGSAGG+EIBAQQEAwIEEDANBgkqhkiG9w0BAQUFAAOCAQEAeK/PxHKK
# xjFN2chB0DFDdLwVGsPr1qjISdR5Sty/ieUkE6i//dHDc/wgVMY9fzEXeZB1t+gA
# azFYYf0MTSdPK/iPOFRtaUGG0uZEFEW0poZrZvyI/VL0DqX6HkBQSfhbHxwtoqEH
# VehfmCuU+nRphRaqrCmg74GS0eXgH7WnBfikAPgYsZ2KQuD9xd8qz7L+8Oz801en
# XuDxoB7bR4HDGerFbhNz34odeXakNMLntDXIm929vdwwfqQEb4lx5oFPHV4aNpKI
# vWGFDYLlX+fxW5xKSRIBR5h+jBQyVrRJiq6/xgypv7iM+4+2JHYQcm5LmZg0PmDf
# R/zvI5JSzIaqZDGCAi4wggIqAgEBMIGMMHgxCzAJBgNVBAYTAlBMMSIwIAYDVQQK
# ExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYDVQQLEx5DZXJ0dW0gQ2Vy
# dGlmaWNhdGlvbiBBdXRob3JpdHkxHDAaBgNVBAMTE0NlcnR1bSBMZXZlbCBJSUkg
# Q0ECEHI2z5vM4PyWrf55EQJ0krIwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwx
# CjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGC
# NwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFFCx0uD3uayfm3LR
# A1qGZ8fbGsxbMA0GCSqGSIb3DQEBAQUABIIBADuhoAV/2AC8wizshdPfav+qOjIH
# rf6Yan5mkfrUPYphi1SvWuwBHA9IPYc9n3xZbyZtcT/PzlOgwVIbtRGHflJGNaF/
# Ix6rm3FgWpVek3n8fb2CwrdZoVITw8OeZ0GgDlTpb7kfbpGAzSXQDck1Fxi15oRK
# pK+G/n7Un184YmQs2PeyUp3199tbS05TD+Z8x6cUQ/vQvQnWCEwXx4Ae7BxNraZC
# AwibTqgyDW29TKn8tpFU5GPejcddf4Dmwkc2LqjS93gAwNPWkRhxU5zUwh/itd/2
# 0yer0s1kbQdRyGgNYezbNBHnRn/uf/GDpN4tP/RjLUUgdGsAFdj2Liqg4zw=
# SIG # End signature block
