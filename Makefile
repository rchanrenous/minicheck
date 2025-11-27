all:		minishell
	./test_parsing.sh
	./test_exec.sh

minishell:
	make -C ..

parsing:	minishell
	./test_parsing.sh

exec:		minishell
	./test_exec.sh

clean:
	make -C .. clean

fclean:
	make -C .. fclean

re:			fclean all

.PHONY: all minishell parsing exec clean fclean re
