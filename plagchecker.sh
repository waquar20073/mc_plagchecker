#! /bin/bash
#Author: Waquar Shamsi
#Description: 
#	Tool to automate generation plagiarism report for Mobile Computing Assignments

REPO_HOST_URL="github.com/Mobile-Computing-Winter-2022/"
REPO_BASE="assignment-0-"
EXTENSION=".git"

branch_names=(
	"assignment-1"
	"Assignment-1"
	"ass1"	
)

admin_username=""
admin_password=""
function get_credentials(){
	read -p "Please enter your Github Username: " admin_username
	read -s -p "Please enter your Github Password: " admin_password
}

function dependencies_exist(){
	#checks if dependencies exists
	if [ -e usernames.txt ]
	then
	    echo "Username file found"
	else
	    echo "ERROR: username.txt not found! Quitting"
	    exit 1
	fi
	
	if [ -e moss.pl ]
	then
	    echo "Moss.pl script found"
	else
	    echo "ERROR: Moss.pl script not found! Quitting"
	    exit 1
	fi
}

function clone_repos(){
	#Reads a txt file containing usernames separated by \n to generate URLs using BASE_URL, branch_names and clones the repositories
	echo "Cloning Repositories"
	cat usernames.txt | while read username; do
		for branch in $branch_names; do
			repository="https://${admin_username}:${admin_password}@${REPO_HOST_URL}${REPO_BASE}${username}${EXTENSION}"
			git clone --branch "$branch" "$repository"
			
		done
	done
}

function arrange_files(){
	# for each username, move in the user directory, find all code files and move them in a folder called codes
	# $1 file extension
	echo "Arranging Files"
	cat usernames.txt | while read username; do
			user_repo="${REPO_BASE}${username}"
			cd $user_repo      
			mkdir codes                      
			file_list=`find . -type f -name "*.${1}"`
			for file in $file_list; do
					echo $file
					mv $file ./codes/
			done
			cd ..
	done
}

# main
get_credentials
dependencies_exist
clone_repos
arrange_files "java"

echo "Generating Plagiarism Report"
perl moss.pl -l java */codes/*.java