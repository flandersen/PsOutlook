using namespace System.Collections.Generic

# . ".\FilterEmails.ps1" | Select-Object -ExpandProperty "Body" |  Where-Object {$_ -like "*G-AU-CSE-MAN-227-20210012*"} | . .\RemoveExcessEmptyLines.ps1 | . .\RemoveLinks.ps1


Add-Type -assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -comobject Outlook.Application
$namespace = $Outlook.GetNameSpace("MAPI")
$sentItems = $namespace.Folders.Item('me@company.local').Folders.Item('Gesendete Elemente')

$date = Get-Date -Date '2024-01-01'
$filter = "[SentOn]>'$($date.ToString("g"))'"
$found = $sentItems.Items.Restrict($filter)
$result = [List[System.Object]]::New()

foreach($item in $found)
{
    $recipients = $item.Recipients
   
    foreach($recipient in $recipients)
    {
        if ($recipient.Address -like 'colleague@company.local')
        {
            $result.Add($item)
        }
    }
}

# "Count: $($found.Count)"
# "First: $($found.GetFirst().SentOn)"
# "Last: $($found.GetLast().SentOn)"

$result