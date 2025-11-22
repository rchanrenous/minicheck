all: minishell parsing exec
	./test_exec.sh
	./test_parsing.sh

minishell:
	make -C ..

parsing:	minishell
	./test_parsing.sh

exec:		minishell
	./test_exec.sh

.PHONY: all minishell parsing exec
