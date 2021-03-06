$identifier = "@?[_\p{Lu}\p{Ll}\p{Lt}\p{Lm}\p{Lo}\p{Nl}][\p{Lu}\p{Ll}\p{Lt}\p{Lm}\p{Lo}\p{Nl}\p{Nd}\p{Pc}\p{Mn}\p{Mc}\p{Cf}]*"

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

$documentationValidators = "($documentationNamespace)|($documentationType)|($documentationField)|($documentationProperty)|($documentationMethod)|($documentationEvent)|($documentationError)" +
"`r`n`r`n$documentationNamespace`r`n`r`n$documentationType`r`n`r`n$documentationField`r`n`r`n$documentationProperty`r`n`r`n$documentationMethod`r`n`r`n$documentationEvent`r`n`r`n$documentationError"

out-file -filepath CSharpIdentifierValidation.txt -inputobject $documentationValidators -encoding utf8