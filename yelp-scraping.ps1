$AreaCodes = Import-Csv -Path D:\source\bandbrew\NYZips.csv
$Count = 1
$UriParameters = @(
    "live+music"
)

$Uri = 'https://api.yelp.com/v3/businesses/search?term={0}' -f $UriParameters
# $Results = Invoke-RestMethod $Uri -Headers @{"Authorization"="Bearer {3}" -f $UriParameters};

function GetAreaResults($ZipCode) {
    $Results = Invoke-RestMethod ($Uri + ("&location={0}" -f $ZipCode)) -Headers @{"Authorization"="Bearer {0}" -f $API_KEY};
    Return $Results.total
};

foreach ($Area in $AreaCodes) {
    Clear-Host
    "Currently on " + $Count + " of " + ($AreaCodes.Count) + "!"
    $TotalCount += GetAreaResults($Area);
    $Count++

}

$TotalCount