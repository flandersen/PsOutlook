param(
    [parameter(
        Mandatory         = $true,
        ValueFromPipeline = $true)]
    $pipelineInput
)

Begin {
    # The begin {} block runs once at the start, and is good for setting up variables.
}

Process {

    ForEach ($input in $pipelineInput) {

        if ($input -ne $null)
        {
            $result = [regex]::Replace($input, "[\r\n]+", "`n")
            Write-Output $result
        }        
    }
}
End {
    # The end {} block runs once at the end, and is good for cleanup tasks.
}
