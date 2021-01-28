$html++
Write-Output "<!DOCTYPE html>
<html>
<head>
<style>
.item1 {
  grid-area: myArea;
}

.grid-container {
  display: grid;
  grid-template-areas: 'myArea myArea . . .';
  grid-gap: 10px;
  background-color: #2196F3;
  padding: 10px;
}

.grid-container > div {
  background-color: rgba(255, 255, 255, 0.8);
  text-align: center;
  padding: 20px 0;
  font-size: 20px;
  font-weight: bold;
}

</style>
</head>
<body>


<div class="grid-container">" | Out-File -FilePath C:\Users\Shaun\OneDrive\Desktop\addserv\status$html.html
$servers = Get-Content C:\Users\Shaun\OneDrive\Desktop\addserv\servers.txt
foreach ($server in $servers) {
    $item++
    $date = Get-Date
	try {
        $null = Test-Connection -ComputerName $server -Count 1 -ErrorAction STOP
        Write-Output " <div class="item$item">$server - OK</div>"
		Write-Output " <div class="item$item"><p style="background-color:green">$server</p>UP</div>" | Out-File -Append -FilePath C:\Users\Shaun\OneDrive\Desktop\addserv\status$html.html
	}
    catch {
        Write-Output "$server - $($_.Exception.Message) "
		Write-Output "<div class="item$item"><p style="background-color:red">$server</p>DOWN<br>$date</div>" | Out-File -Append -FilePath C:\Users\Shaun\OneDrive\Desktop\addserv\status$html.html
	}
}
$item = 0