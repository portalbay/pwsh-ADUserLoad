$ADUsers = Import-csv .\data.csv
foreach ($User in $ADUsers)
{

	$user_name = $User.name
	$user_pass= $User.password
	$user_street = $User.street
	$user_city = $User.city
	$user_st= $User.state
	$user_zip= $User.zip

	$user_company="Company Name HERE"

	$user_dept= $User.dept
	$user_title = $User.title
	$user_desc = $User.desc

	$user_fname=$user_name.split()[0]
	$user_lname=$user_name.split()[1]
	$user_SamAccountName = $user_fname + "." + $user_lname
	$user_email = $user_SamAccountName + "@domain.xyz"
	$user_PrincipalName =  $user_email 
	$user_proxy_a="SMTP:" + $user_email 

	New-ADUser `
		-DisplayName $user_name `
                -Name $user_name `
                -GivenName $user_fname `
		-Surname $user_lname `
		-UserPrincipalName $user_PrincipalName `
		-SamAccountName $user_SamAccountName `
		-EmailAddress $user_email `
		-Description $user_desc `
		-AccountPassword (ConvertTo-SecureString $user_pass -AsPlainText -Force) `
		-StreetAddress $user_street `
		-City $user_city `
		-State $user_st `
		-Country "US" `
		-Company $user_company `
		-Office $user_city `
		-Title $user_title  `
		-PostalCode $user_zip `
		-Department $user_dept `
		-OtherAttributes @{Proxyaddresses="SMTP:" + $user_email} `
		-Path "OU=Users,OU=THE_FULL,DC=OU_PATH,DC=OU_PATHHERE,DC=xyz" `
		-Enabled $True
}

