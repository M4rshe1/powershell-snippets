function ConvertTo-CamelCase
{
    param(
        [string]$inputString
    )

    # Split the input string into words based on spaces
    $words = $inputString -split '\s+'

    # Capitalize the first letter of each word (except the first word)
    for ($i = 1; $i -lt $words.Length; $i++) {
        $words[$i] = $words[$i].Substring(0, 1).ToUpper() + $words[$i].Substring(1).ToLower()
    }

    # Join the words back together to form camel case string
    $camelCaseString = $words -join ''

    # Return the camel case string
    return $camelCaseString
}
