﻿function ConvertTo-LatLngCoords {
  <#
  .Synopsis
     This script takes a city/keyword name and returns the Long and Lat Coordinates
  .DESCRIPTION
     This script utilises one of the APIs that have been created by MapQuest
     to convert city names into coordinates. It produces a custom object
     output that contains the city name, Longatude and Latitude.
     If there is more than one city in the database the script will show 
     all known cities and their details.
  
     Latitude and Longitude Coordinate Accuracy
     Decimal Places   Example          Error Tollerence
     --------------   -------          ----------------
     0                1                111  km
     1                0.1              11.1 km
     2                0.01             1.11 km
     3                0.001            111  m
     4                0.0001           11.1 m
     5                0.00001          1.11 m
     6                0.000001         11.1 cm
     7                0.0000001        1.11 cm
     8                0.00000001       1.11 mm
  .EXAMPLE
     ConvertTo-LatLngCoords -Keyword Sydney -APIKey 123456787
     This will look for locations that have Sydney in its name. The script will 
     then return an object showing: Long,Lat,City,Class and Type place found.
  .PARAMETER Keyword
     Choose any major or semi-major city in the world to be converted into 
     Coordicates. You can give as much detail as you wish, just seperate the
     street, city, state, country by commas.
  .NOTES
     General notes
     Creation: Brent Denny 11 Oct 2017
     Modified: Brent Denny  8 Mar 2019
   .ROLE
     The role this cmdlet is to show how APIs work and how PowerShell
     can use them.
  #>
  [CmdletBinding()]
  Param(
    [parameter(Mandatory=$true)]
    [string[]]$Keyword,
    [parameter(Mandatory=$true)]
    [string[]]$APIKey

  )
  $resultAPI = Invoke-RestMethod -Method Get -Uri "http://open.mapquestapi.com/nominatim/v1/search.php?key=$APIKey&format=json&q=$Keyword" -UseBasicParsing
  $locations = $resultAPI 
  foreach ($location in $locations) {  # Just in case there are multiple cities with same name
    $outputProp = [ordered]@{
      Lat = ('{0:N6}' -f $Location.lat) -as [double]
      Lng = ('{0:N6}' -f $location.lon) -as [double]
      City = $location.Display_Name
      Class = $location.Class
      Type = $location.Type
    } # END Hashtable
    New-Object -TypeName psobject -Property $outputProp
  } #END Foreach
} #END Function

function Get-NewRandomADUsers {
  [CmdletBinding()]
  Param (
    [parameter(Mandatory=$true)]
    [string[]]$APIKey
  )
  $NewUsersCsv = Invoke-RestMethod -Method Get -Uri "https://my.api.mockaroo.com/random_ad_users.json?key=$APIKey" -UseBasicParsing
  $NewUsers = $NewUsersCsv | ConvertFrom-Csv
  $NewUsers
}
