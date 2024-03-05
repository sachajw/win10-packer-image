Set-ExecutionPolicy Bypass -Scope Process -Force
# Power off and unregister the VM
VBoxManage.exe controlvm "ift-demo-win11" poweroff 2>&1 | Out-Null
VBoxManage.exe unregistervm "ift-demo-win11" --delete 2>&1 | Out-Null