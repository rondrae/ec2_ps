### Pulls details of the EC2 instance, if the instance is off it will not have a Public IP
$instance = Get-EC2Instance -InstanceId 'i-02e096575cc5af84e'


$state = (Get-EC2InstanceStatus -InstanceId $instanceId).InstanceState.Name

###  Checks if the EC2 is running or not. Powers it on if it's not running
if ($state -eq "running") {
    "EC2 is already running"
}
else {
   "Not running, Starting instance"
     $instance | Start-EC2Instance 
     Start-Sleep -Seconds 120   ## Waiting 2 minutes for the EC2 to boot up
}



$instance = Get-EC2Instance -InstanceId 'i-02e096575cc5af84e' # This is ran again because this time it should have a Public IP
$instance.Instances.PublicIpAddress ### Prints public IP to terminal
$pubIP = $instance.Instances.PublicIpAddress

ssh -i .\vprofile-prod-key.pem ubuntu@$pubIP ### Connects to the EC2 instance via SSH