function Start-XMLProcessor($element)
{
    # Check if the element has a Name attribute
    if ($null -ne $element.Name -and $element.Name -ne '')
    {
        $name = $element.Name
        $control = $Global:Controls['MainWindow'].FindName($name)

        # Add control to the global dictionary
        $Global:Controls[$name] = $control
    }

    # Recursively process child elements
    foreach ($child in $element.ChildNodes)
    {
        if ($child -is [System.Xml.XmlElement])
        {
            Start-XMLProcessor  $child
        }
    }
}


