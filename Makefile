all: minishell
	./test_parsing.sh
	./test_exec.sh

minishell:
	make -C ..

parsing:	minishell
	./test_parsing.sh

exec:		minishell
	./test_exec.sh

.PHONY: all minishell parsing exec
