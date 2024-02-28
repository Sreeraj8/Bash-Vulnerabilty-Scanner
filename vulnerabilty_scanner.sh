#!/bin/bash
#simple vulnerabilty scanner for linux distros
#
#
echo "Select Your Operating System: "
echo "1.Arch Linux"
echo "2.Ubuntu"
echo "3.Fedora"
echo "4.Exit"

read -p "Enter your Choice (1-4): " choice


case $choice in

	1)
		distribution="Arch Linux"
		;;

	2)      
		distribution="ubuntu"
		;;
		
        3)      
		distribution="Fedora"
		;;

	4)    
		echo "Exiting Script"
		exit 0
		;;

	*)
		echo "Invalid choice. exiting script"
		exit 1
		;;

esac


echo "Starting Vulnerability scanner for $distribution..."


#function to check vulnerability

function check_cve {

	echo -e "checking for vulnerabilities using cve for $distribution.."

#list installed packages

case  $distribution in

	"Arch Linux")
		installed_packages=$(pacman -Que)
		;;

	"ubuntu")
		installed_packages=$(dpkg -l | grep '^ii' | awk '{print $2}')
		;;

	"fedora") installed_packages=$(dnf list installed | awk '{print $1}')
		;;


esac


#checking cve for each installed package
#

for package in $installed_packages; do

	cve_results=$(curl -s "https://cve.circl.lu/api/cve/$package")
        if [ "$cve_results" != "[]" ]; then

		echo -e "\nVulnerabilities found for package: $package"
		echo "$cve_results"
	fi
done

}

#execute function

check_cve


echo -e "\nVulnerability scan for $distribution completed."

















        


















