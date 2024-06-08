function Start-ApplyLayer
{
    param(
        [double[]]$input_data,
        $weights,
        [double[]]$biases,
        [string]$activation
    )
    [Double[]]$output_data = @()
    $rows = $weights.Length
    $cols = $weights[0].length

    for ($i = 0; $i -lt $cols; $i++) {
        [Double]$sum = 0
        for ($j = 0; $j -lt $rows; $j++) {
            $sum += $input_data[$j] * $weights[$j][$i]
        }
        $sum += $biases[$i]
        if ($activation -eq "relu")
        {
            $output_data += [Double]([Math]::Max([Double]0, [Double]$sum))
        }
        elseif ($activation -eq "linear")
        {
            $output_data += $sum
        }
        elseif ($activation -eq "sigmoid")
        {
            $output_data += 1 / (1 + [Math]::Exp(-$sum))
        }

    }
    return $output_data
}