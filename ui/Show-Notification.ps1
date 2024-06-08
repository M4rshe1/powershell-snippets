function Show-Notification
{
    [cmdletbinding()]
    Param (
        [string]
        $ToastTitle,
        [string]
        [parameter(ValueFromPipeline)]
        $ToastText,
        [String]$icon
    );

    try
    {
        #        [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
        $Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)

        $RawXml = [xml] $Template.GetXml()
        ($RawXml.toast.visual.binding.text | Where-Object {
            $_.id -eq "1"
        }).AppendChild($RawXml.CreateTextNode($ToastTitle)) > $null
        ($RawXml.toast.visual.binding.text | Where-Object {
            $_.id -eq "2"
        }).AppendChild($RawXml.CreateTextNode($ToastText)) > $null

        $SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
        $SerializedXml.LoadXml($RawXml.OuterXml)

        $Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml)
        $Toast.Tag = "PowerShell"
        $Toast.Group = "PowerShell"
        $Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1)

        $Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("PowerShell")
        $Notifier.Show($Toast);
    }
    catch [System.Exception]
    {
        Write-Host
        if ($Global:verbose)
        {
            Write-Host $_ -ForegroundColor Red
        }


        $messageLength = 0
        $ToastText.split("`n") | ForEach-Object {
            if ($_.Length -gt $messageLength)
            {
                $messageLength = $_.Length
            }
        }

        switch ( $icon.ToLower())
        {
            "info" {
                $color = "Blue"
            }
            "warning" {
                $color = "Yellow"
            }
            "error" {
                $color = "Red"
            }
            default {
                $color = "White"
            }
        }


        Write-Host "".PadRight($messageLength + 4, "#") -ForegroundColor $color
        Write-Host "#" $ToastTitle.PadRight($messageLength) "#" -ForegroundColor $color
        $ToastText.split("`n") | ForEach-Object {
            Write-Host "#" $_.PadRight($messageLength) "#" -ForegroundColor $color
        }
        Write-Host "#".PadRight($messageLength + 4, "#") -ForegroundColor $color
        Write-Host
    }
}

