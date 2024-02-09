param(
    [parameter(
        Mandatory         = $true,
        ValueFromPipeline = $true)]
    $pipelineInput
)

Process 
{
    ForEach ($input in $pipelineInput) 
    {
        if ($input -ne $null)
        {
            Write-Output ([regex]::Replace($input, "\<http[s]*\:.+?\>", "[Link]", "singleline"))
        }        
    }
}
