Function Show-MenuMultiSelect()
{

    Param(
        [Parameter(Mandatory = $True)][String]$MenuTitle,
        [Parameter(Mandatory = $True)][String]$MenuBanner,
        [Parameter(Mandatory = $True)][array]$MenuOptions
    )

    $MaxValue = $MenuOptions.count - 1
    $Selection = 0
    $EnterPressed = $False
    [System.Collections.ArrayList]$Selected = @()
    $Position = 0

    Clear-Host

    While (-not $EnterPressed)
    {
        if ($MenuBanner.Length -ne 1)
        {
            Write-Host "$MenuBanner"
        }
        Write-Host "$MenuTitle"

        For ($i = 0; $i -le $MaxValue; $i++) {
            if ( $Selected.contains($MenuOptions[$i]))
            {
                $x = "X"
            }
            else
            {
                $x = " "
            }

            If ($i -eq $Selection -and -not $TabPressed)
            {
                $Position = $i
                Write-Host -BackgroundColor DarkGray -ForegroundColor White " [$( $x )] $( $MenuOptions[$i] ) "
            }
            Else
            {
                Write-Host " [$( $x )] $( $MenuOptions[$i] )  "
            }

        }
        Write-Host

        $KeyInput = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown").virtualkeycode

        Switch ($KeyInput)
        {
            13 {
                $EnterPressed = $True
                return $Selected, $Selection
                Clear-Host
                break
            }
            32 {
                if ( $Selected.Contains($MenuOptions[$Position]))
                {
                    $Selected.Remove($MenuOptions[$Position])
                }
                else
                {
                    $Selected += $MenuOptions[$Position]
                }
                Clear-Host
                break
            }
            38 {
                If ($Selection -eq 0)
                {
                    $Selection = $MaxValue
                }
                Else
                {
                    $Selection -= 1
                }
                Clear-Host
                break
            }
            40 {
                If ($Selection -eq $MaxValue)
                {
                    $Selection = 0
                }
                Else
                {
                    $Selection += 1
                }
                Clear-Host
                break
            }
            27 {
                $EnterPressed = $True
                return $Selected, "exit"
                Clear-Host
                break
            }

            Default {
                Clear-Host
            }
        }
    }
}