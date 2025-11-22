#!/usr/bin/bash

minishell_exec="../minishell"
dir_test_files="exec/"
test_files="test_cd test_echo test_pwd test_export test_unset test_exit test_path test_pipe"
EXIT_STATUS=0

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ ! -f $minishell_exec ]
then
	echo "Missing minishell program"
	exit 1
fi

for file in $test_files
do
	file=$dir_test_files$file
	minishell_stdout=$file'_exit_status_stdout'
	minishell_stderr=$file'_exit_status_stderr'
	bash_stdout=$file'_exit_status_bash_stdout'
	bash_stderr=$file'_exit_status_bash_stderr'
	awk '{print; print "echo " NR ": " "\047" $0 "\047" " = $?"}' $file > $file'_exit_status'
	$minishell_exec < $file'_exit_status' > $minishell_stdout 2> $minishell_stderr 
	bash < $file'_exit_status' > $bash_stdout 2> $bash_stderr 
	diff $minishell_stdout $bash_stdout > diff_stdout
	diff $minishell_stderr $bash_stderr > diff_stderr
	echo =========================================
	echo -e "$YELLOW $file $NC"
	if [ -s diff_stdout ]
	then
		echo -e "DIFF STDOUT: $RED KO $NC"
		cat diff_stdout
		EXIT_STATUS=1
	else
		echo -e "DIFF STDOUT: $GREEN OK $NC"
	fi
	if [ -s diff_stderr ]
	then
		echo -e "DIFF STDERR: $BLUE KO $NC"
		cat diff_stderr
		EXIT_STATUS=1
	else
		echo -e "DIFF STDERR: $GREEN OK $NC"
	fi
	rm -f $minishell_stdout $bash_stdout $minishell_stderr $bash_stderr diff_stdout diff_stderr $file'_exit_status'
done

exit 0
