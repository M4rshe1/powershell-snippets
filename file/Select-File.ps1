function Select-File
{
    param (
        [string]$Filter = "All files (*.*)|*.*",
        [string]$Title = "Select a file",
        [switch]$MultiSelect = $false,
        [string]$InitialDirectory = $null
    )

    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = $Filter
    $openFileDialog.Title = $Title
    $openFileDialog.Multiselect = $MultiSelect
    $openFileDialog.InitialDirectory = $InitialDirectory

    if ($openFileDialog.ShowDialog() -eq "OK")
    {
        return $openFileDialog.FileName
    }

    return $null
}