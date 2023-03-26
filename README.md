# Mobile Computing IIITD Plagiarism Checker Script

### Requirements 
- BASH
- Linux / WSL
- Perl
- [moss.pl](https://theory.stanford.edu/~aiken/moss/ "moss.pl")

### How to Use:
1. Create a txt file "usernames.txt" with github Usernames of Mobile Computing students, on each line
```
username1
username2
username3
...
```
2. Keep moss.pl configured with moss credentials in the same directory as the script.
3. Run 
> bash plagchecker.sh
4. Enter Github Username and Password for the account that has Admin rights to the Github Classroom
5. Wait for the URL to be generated by moss.pl
