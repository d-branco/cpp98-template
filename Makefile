#  **************************************************************************  #
#                                           ::::::::    ::::::::   :::::::::   #
#    Makefile                             :+:    :+:  :+:    :+:  :+:          #
#                                              +:+         :+:   :+:           #
#    github.com/d-branco                    +#+         +#+      +#+#+#+       #
#                                        +#+         +#+              +#+      #
#    Created: 2026/02/25 20:52:12      #+#         #+#      +#+        #+#     #
#    Updated: 2026/02/26 12:48:17     #########  #########  ###      ###       #
#                                                             ########         #
#  **************************************************************************  #

NAME			:= a.out

ARGS			=
DEBUG_LEVEL		:= 1

FORMATABLE		= $(HEADERS) $(SRCS)
TEST_NAME		:= test_$(NAME)
DEBUG_NAME		:= debug_$(NAME)
SRC_DIR			:= srcs
INC_DIR			:= include
BUILD_DIR		:= build

########################################################## Objects and Headers #
HEADERS			= $(shell find $(INC_DIR) -name "*.hpp" 2>/dev/null)
SRCS			= $(shell find $(SRC_DIR) -name "*.cpp" 2>/dev/null)
OBJS			= $(SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
TEST_OBJS		= $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/test_%.o,$(SRCS))
DEBUG_OBJS		= $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/debug_%.o,$(SRCS))

##################################################################### Compiler #
CC				:= c++
CFLAGS			+= -std=c++98
CFLAGS			+= -Wall -Wextra
CFLAGS			+= -Werror
CFLAGS			+= -Wshadow -Wnon-virtual-dtor
CFLAGS			+= -Wpedantic
CFLAGS			+= -Wconversion -Wsign-conversion -Wold-style-cast
CFLAGS			+= $(LDFLAGS) $(LDLIBS)

TEST_FLAGS		= $(CFLAGS) -DTESTING

INC_DIRS		:= $(shell find $(INC_DIR) -type d 2>/dev/null)
INCLUDES		:= $(addprefix -I, $(INC_DIRS))
LDFLAGS			:=
LDLIBS			:=

GPROF_FLAGS		+= -pg

DEBUG_FLAGS		= $(CFLAGS) -O0
DEBUG_FLAGS		+= -g3
DEBUG_FLAGS		+= -DHARL=$(DEBUG_LEVEL)

########################################################### Intermediate steps #
RM				:= rm --force --recursive --verbose
AR				:= ar rcs

###################################################################### Targets #
all: $(NAME)

$(NAME): $(OBJS)
	@\
	echo "$(GRAY)Compiled with:	$(CC) $(RESET)" ; \
	echo "$(GRAY)Compile flags:	$(CFLAGS) $(RESET)" ; \
	echo "$(GRAY)Linking flags:	$(INCLUDES) $(RESET)" ; \
	$(CC) $(OBJS) $(INCLUDES) $(CFLAGS) -o $(NAME)	&&	\
	echo "$(GRAY)File compiled:$(RESET)	./$(NAME)"

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@\
	mkdir -p $(dir $@) ; \
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@	&&	\
	echo "$(GRAY)Obj. compiled:	$<$(RESET)"

$(DEBUG_NAME): $(DEBUG_OBJS)
	@\
	echo "$(GRAY)Compiled with:	$(CC) $(RESET)" ; \
	echo "$(GRAY)Compile flags:	$(DEBUG_FLAGS) $(RESET)" ; \
	echo "$(GRAY)Linking flags:	$(INCLUDES) $(RESET)" ; \
	$(CC) $(DEBUG_FLAGS) $(INCLUDES) $(DEBUG_OBJS) -o $(DEBUG_NAME) &&\
	echo "$(GRAY)File compiled:$(RESET)	./$(DEBUG_NAME)"

$(BUILD_DIR)/debug_%.o: $(SRC_DIR)/%.cpp
	@\
	mkdir -p $(dir $@) &&\
	$(CC) $(DEBUG_FLAGS) $(INCLUDES) -c $< -o $@ &&\
	echo "$(GRAY)Obj. compiled:	$<$(RESET)"

$(TEST_NAME): $(TEST_OBJS)
	@\
	echo "$(GRAY)Compiled with:	$(CC) $(RESET)" ; \
	echo "$(GRAY)Compile flags:	$(TEST_FLAGS) $(RESET)" ; \
	echo "$(GRAY)Linking flags:	$(INCLUDES) $(RESET)" ; \
	$(CC) $(TEST_FLAGS) $(INCLUDES) $(TEST_OBJS) -o $(TEST_NAME) &&\
	echo "$(GRAY)File compiled:$(RESET)	./$(TEST_NAME)"

$(BUILD_DIR)/test_%.o: $(SRC_DIR)/%.cpp
	@\
	mkdir -p $(dir $@) &&\
	$(CC) $(TEST_FLAGS) $(INCLUDES) -c $< -o $@ &&\
	echo "$(GRAY)Obj. compiled:	$<$(RESET)"

clean:
	@\
	if [ -d $(BUILD_DIR) ]; then \
	rm -rfv  $(BUILD_DIR) | while read line; do \
		file=$$(echo "$$line" | sed "s/.*'\(.*\)'/\1/"); \
		echo "$(GRAY)Objects Clean:  $$file$(RESET)"; \
	done; \
	fi

fclean: clean
	@\
	make clean --silent; \
	for file in $(NAME) $(TEST_NAME) $(DEBUG_NAME); do \
		if [ -f $$file ]; then \
			echo "$(GRAY)File fcleaned: $(RESET) $$file"; \
			rm -f $$file; \
		fi; \
	done

re: fclean all
	@echo "$(GRAY)redone$(RESET)"

.PHONY: all clean fclean re clang-check valgrind test run debug gprof time

####################################################################### Format #
.clang-format:
	@echo "\
	Language: Cpp\n\
	\n\
	AlignConsecutiveDeclarations:\n\
	  Enabled: true\n\
	  AcrossEmptyLines: true\n\
	  AcrossComments: true\n\
	  AlignCompound: true\n\
	  AlignFunctionPointers: false\n\
	  PadOperators: true\n\
	AlignConsecutiveMacros:\n\
	  Enabled: true\n\
	  AcrossEmptyLines: false\n\
	  AcrossComments: false\n\
	  AlignCompound: false\n\
	  PadOperators: true\n\
	AlignAfterOpenBracket: Align\n\
	AlignConsecutiveAssignments: true\n\
	AlignEscapedNewlinesLeft: true\n\
	AllowAllConstructorInitializersOnNextLine: false\n\
	AllowAllParametersOfDeclarationOnNextLine: false\n\
	AllowShortBlocksOnASingleLine: false\n\
	AllowShortIfStatementsOnASingleLine: false\n\
	AllowShortFunctionsOnASingleLine: None\n\
	AlwaysBreakAfterReturnType: None\n\
	AlwaysBreakBeforeMultilineStrings: false\n\
	BinPackArguments: false\n\
	BinPackParameters: false\n\
	BreakBeforeBraces: Allman\n\
	BreakBeforeBinaryOperators: All\n\
	BreakBeforeTernaryOperators: false\n\
	BreakConstructorInitializers: AfterColon\n\
	PackConstructorInitializers: CurrentLine\n\
	ColumnLimit: 80\n\
	ConstructorInitializerIndentWidth: 4\n\
	IndentPPDirectives: AfterHash\n\
	IndentWidth: 4\n\
	KeepEmptyLinesAtTheStartOfBlocks: false\n\
	MaxEmptyLinesToKeep: 1\n\
	PointerAlignment: Right\n\
	PenaltyBreakBeforeFirstCallParameter: 100\n\
	PenaltyBreakString: 100\n\
	PenaltyExcessCharacter: 1000000\n\
	PPIndentWidth: 1\n\
	RemoveBracesLLVM: false\n\
	SeparateDefinitionBlocks: Always\n\
	SpaceAfterCStyleCast: true\n\
	SpaceBeforeAssignmentOperators: true\n\
	SpaceBeforeParens: ControlStatements\n\
	SpaceInEmptyParentheses: false\n\
	SpacesInCStyleCastParentheses: false\n\
	SpacesInParentheses: false\n\
	SpacesInSquareBrackets: false\n\
	TabWidth: 4\n\
	UseTab: Always\n\
	" > .clang-format

format: check-guards .clang-format headers
	@\
	for file in $(FORMATABLE); do	\
		if ! clang-format "$$file" | diff -q "$$file" - > /dev/null 2>&1; then \
			clang-format -i "$$file"	&&	\
			echo "$(GRAY)File formated:$(RESET)	$$file"; \
		fi; \
	done; \
#	rm -f .clang-format

.clang-tidy:
	@\
	echo "\
	Checks: |\n\
	  readability-*,\n\
	  -readability-magic-numbers,\n\
	  bugprone-*,\n\
	  performance-*,\n\
	  clang-analyzer-*,\n\
	  -modernize-*,\n\
	  cppcoreguidelines-*,\n\
	  -cppcoreguidelines-avoid-magic-numbers,\n\
	  -cppcoreguidelines-pro-type-member-init,\n\
	  -cppcoreguidelines-avoid-const-or-ref-data-members\n\
	\n\
	CheckOptions:\n\
	  - key:   readability-identifier-naming.ClassCase\n\
	    value: CamelCase\n\
	  - key:   readability-identifier-naming.FunctionCase\n\
	    value: lower_case\n\
	  - key:   readability-identifier-naming.PrivateMemberSuffix\n\
	    value: '_'\n\
	\n\
	HeaderFilterRegex: '.*'\n\
	" > .clang-tidy

style: .clang-format .clang-tidy
	@\
	clang-format --verbose --dry-run $(FORMATABLE)	; \
	clang-tidy --quiet -extra-arg=-std=c++98 $(FORMATABLE)	\
	-- $(CFLAGS) $(INCLUDES)	; \
	make check-guards --silent

fix-style: .clang-tidy format
	@\
	clang-tidy --quiet --fix --use-color --extra-arg=-std=c++98 $(FORMATABLE) -- $(CFLAGS) $(INCLUDES)	; \
	make check-guards --silent ;\
	make format --silent

check-guards:
	@fail=0	; \
	for file in $$(find $(INC_DIR) -name "*.hpp" 2>/dev/null); do \
		filename=$$(basename $$file)	; \
		guard=$$(echo $$filename | tr 'a-z' 'A-Z' | sed 's/\./_/g')	; \
		if ! grep -q "#ifndef $$guard" $$file\
			|| ! grep -q "#define $$guard" $$file; then \
			echo "$(YELLOW)$$file  is missing header guard:$(RESET)\
	\n#ifndef $$guard\n#define $$guard\n\n#endif // $$guard"	; \
			fail=1	; \
		fi	; \
	done;

clang-check:
	@\
	clang-check --analyze $(FORMATABLE) -- $(CFLAGS) $(INCLUDES)	; \
	rm -f *.plist

clangd: .clang-format .clang-tidy
	@\
	echo "\
	CompileFlags:\n\
	  Add: [-std=c++98, -pedantic, -Wall, -Wextra, -Werror, -I../include, -Iinclude]\n\
	Diagnostics:\n\
	  UnusedIncludes: None\n\
	---\n\
	If:\n\
	  PathMatch: include/external/doctest.h\n\
	Diagnostics:\n\
	  Suppress: \"*\"\n\
	Index:\n\
	  Background: Skip\n\
	\n\
	" > .clangd
############################################################# ANSI Escape Code #
RESET			:= \033[0m

PURPLE		:= \033[1;35m
GRAY		:= \033[1;90m
YELLOW		:= \033[1;93m
BLUE		:= \033[1;96m
GREEN		:= \033[32m
ORANGE		:= \033[33m

BG_GREEN	:= \033[1;30m\033[102m
BG_RED		:= \033[1;30m\033[101m

###################################################################### Headers #
headers:
	@\
	for file in $$(find . -name "Makefile"); do	\
		if [ -f "$$file" ]; then	\
			first_line=$$(head -n 1 "$$file"); \
			if [ "$$first_line" != "#  **************************************************************************  #" ]; then	\
				echo	"#  **************************************************************************  #" > temp.txt ; \
				echo	"#                                           ::::::::    ::::::::   :::::::::   #" >> temp.txt ; \
				echo	"#    Makefile                             :+:    :+:  :+:    :+:  :+:          #" >> temp.txt ; \
				echo	"#                                              +:+         :+:   :+:           #" >> temp.txt ; \
				echo	"#    github.com/d-branco                    +#+         +#+      +#+#+#+       #" >> temp.txt ; \
				echo	"#                                        +#+         +#+              +#+      #" >> temp.txt ; \
				echo	"#    Created: $$(date '+%Y/%m/%d %H:%M:%S')      #+#         #+#      +#+        #+#     #" >> temp.txt ; \
				echo	"#    Updated: $$(date '+%Y/%m/%d %H:%M:%S')     #########  #########  ###      ###       #" >> temp.txt ; \
				echo	"#                                                             ########         #" >> temp.txt ; \
				echo	"#  **************************************************************************  #" >> temp.txt ; \
				echo "" >> temp.txt ; \
				cat $$file >> temp.txt; \
				cat temp.txt > $$file; \
				rm -f temp.txt; \
				echo "$(GRAY)Header create:$(RESET) $$file"; \
			else	\
				header_date=$$(sed -n '8p' "$$file" |	\
					sed 's/.*Updated: \([0-9/: ]*\).*/\1/'); \
				header_epoch=$$(date -d "$$header_date" +%s 2>/dev/null || echo 0); \
				file_epoch=$$(stat -c %Y "$$file"); \
				if [ $$file_epoch -gt $$header_epoch ]; then	\
					echo "$(GRAY)Header update:$(RESET) $$file"; \
					update_date=$$(date '+%Y/%m/%d %H:%M:%S'); \
					sed -i "8s|.*|#    Updated: $$update_date     #########  #########  ###      ###       #|" "$$file"; \
				fi; \
			fi; \
		fi; \
	done; \
	\
	for file in $$(find . -name "*.cpp"); do	\
		if [ -f "$$file" ]; then	\
			first_line=$$(head -n 1 "$$file"); \
			if [ "$$first_line" != "/* ************************************************************************** */" ]; then	\
				echo "/* ************************************************************************** */" > temp.txt ; \
				echo "/*                                          ::::::::    ::::::::   :::::::::  */" >> temp.txt ; \
				printf "/*   %-36.36s :+:    :+:  :+:    :+:  :+:         */\n" "$$(basename $$file)" >> temp.txt; \
				echo "/*                                             +:+         :+:   :+:          */" >> temp.txt ; \
				echo "/*   github.com/d-branco                    +#+         +#+      +#+#+#+      */" >> temp.txt ; \
				echo "/*                                       +#+         +#+              +#+     */" >> temp.txt ; \
				echo "/*   Created: $$(date '+%Y/%m/%d %H:%M:%S')      #+#         #+#      +#+        #+#    */" >> temp.txt ; \
				echo "/*   Updated: $$(date '+%Y/%m/%d %H:%M:%S')     #########  #########  ###      ###      */" >> temp.txt ; \
				echo "/*                                                            ########        */" >> temp.txt ; \
				echo "/* ************************************************************************** */" >> temp.txt ; \
				echo "" >> temp.txt ; \
				cat $$file >> temp.txt; \
				cat temp.txt > $$file; \
				rm -f temp.txt; \
				echo "$(GRAY)Header create:$(RESET) $$file"; \
			else	\
				header_date=$$(sed -n '8p' "$$file" |	\
					sed 's/.*Updated: \([0-9/: ]*\).*/\1/'); \
				header_epoch=$$(date -d "$$header_date" +%s 2>/dev/null || echo 0); \
				file_epoch=$$(stat -c %Y "$$file"); \
				if [ $$file_epoch -gt $$header_epoch ]; then	\
					echo "$(GRAY)Header update:$(RESET) $$file"; \
					update_date=$$(date '+%Y/%m/%d %H:%M:%S'); \
					sed -i "8s|.*|/*   Updated: $$update_date     #########  #########  ###      ###      */|" "$$file"; \
				fi; \
			fi; \
		fi; \
	done; \
	\
	\
	for file in $$(find . -name "*.hpp"); do	\
		if [ -f "$$file" ]; then	\
			first_line=$$(head -n 1 "$$file"); \
			if [ "$$first_line" != "/* ************************************************************************** */" ]; then	\
				echo "/* ************************************************************************** */" > temp.txt ; \
				echo "/*                                          ::::::::    ::::::::   :::::::::  */" >> temp.txt ; \
				printf "/*   %-36.36s :+:    :+:  :+:    :+:  :+:         */\n" "$$(basename $$file)" >> temp.txt; \
				echo "/*                                             +:+         :+:   :+:          */" >> temp.txt ; \
				echo "/*   github.com/d-branco                    +#+         +#+      +#+#+#+      */" >> temp.txt ; \
				echo "/*                                       +#+         +#+              +#+     */" >> temp.txt ; \
				echo "/*   Created: $$(date '+%Y/%m/%d %H:%M:%S')      #+#         #+#      +#+        #+#    */" >> temp.txt ; \
				echo "/*   Updated: $$(date '+%Y/%m/%d %H:%M:%S')     #########  #########  ###      ###      */" >> temp.txt ; \
				echo "/*                                                            ########        */" >> temp.txt ; \
				echo "/* ************************************************************************** */" >> temp.txt ; \
				echo "" >> temp.txt ; \
				cat $$file >> temp.txt; \
				cat temp.txt > $$file; \
				rm -f temp.txt; \
				echo "$(GRAY)Header create:$(RESET) $$file"; \
			else	\
				header_date=$$(sed -n '8p' "$$file" |	\
					sed 's/.*Updated: \([0-9/: ]*\).*/\1/'); \
				header_epoch=$$(date -d "$$header_date" +%s 2>/dev/null || echo 0); \
				file_epoch=$$(stat -c %Y "$$file"); \
				if [ $$file_epoch -gt $$header_epoch ]; then	\
					echo "$(GRAY)Header update:$(RESET) $$file"; \
					update_date=$$(date '+%Y/%m/%d %H:%M:%S'); \
					sed -i "8s|.*|/*   Updated: $$update_date     #########  #########  ###      ###      */|" "$$file"; \
					make --silent clean; \
				fi; \
			fi; \
		fi; \
	done

######################################################################### Time #
time: $(NAME)
	@\
	echo "$(GRAY)Executing arg:$(RESET)	time ./$(NAME) $(ARGS)"	; \
	trap '' INT TERM	; \
	$(TIMED_RUN) ./$(NAME) $(ARGS)	; \
	trap - INT TERM

define TIMED_RUN
time --quiet --format "==CRONO== Total time: %E "
endef
##################################################################### Valgrind #
valgrind: $(NAME)
	@\
	echo "$(GRAY)Executing arg:$(RESET)	time valgrind ./$(NAME) $(ARGS)"	; \
	echo "$(RESET)$(GRAY)=========================================="\
	" $(TEST_NAME) VALGRIND$(RESET)"	; \
	trap '' INT TERM	; \
	$(TIMED_RUN) $(VALGRIND_CMD) ./$(NAME) $(ARGS)	; \
	RET=$$?	; \
	trap - INT TERM	; \
	echo "$(RESET)$(GRAY)=========================================="\
	" $(TEST_NAME) VALGRIND$(RESET)"	; \
	echo "$(RESET)$(GRAY)Return value:$(RESET) $$RET"

VALGRIND_CMD = valgrind \
	--track-fds=yes \
	--show-error-list=yes \
	--leak-check=full \
	--show-leak-kinds=all \
	--track-origins=yes \
	--max-stackframe=4200000 \
	--quiet --show-error-list=yes

######################################################################### Test #
test: format $(NAME) $(TEST_NAME) $(DEBUG_NAME)
	@\
	echo "$(GRAY)Executing arg:$(RESET)	./$(TEST_NAME) $(ARGS)"	; \
	echo "$(RESET)$(GRAY)=========================================="\
	" $(TEST_NAME) DOCTEST START$(RESET)"	; \
	trap '' INT TERM	; \
	./$(TEST_NAME) $(TEST_ARGS)	; \
	RET1=$$?	; \
	trap - INT TERM	; \
	echo "$(RESET)$(GRAY)=========================================="\
	" $(TEST_NAME) DOCTEST END$(RESET)"	; \
	\
	echo "$(GRAY)Executing arg:$(RESET)	time valgrind ./$(DEBUG_NAME) $(ARGS)"	; \
	echo "$(RESET)$(GRAY)=========================================="\
	" $(TEST_NAME) TEST START$(RESET)"	; \
	trap '' INT TERM	; \
	$(TIMED_RUN) ./$(DEBUG_NAME) $(TEST_ARGS)	; \
	RET2=$$?	; \
	trap - INT TERM	; \
	echo "$(RESET)$(GRAY)=========================================="\
	" $(NAME) TEST END$(RESET)"	; \
	\
	echo "$(GRAY)Executing arg:$(RESET)	time valgrind ./$(NAME) $(ARGS)"	; \
	echo "$(RESET)$(GRAY)=========================================="\
	" $(TEST_NAME) VALGRIND START$(RESET)"	; \
	trap '' INT TERM	; \
	$(TIMED_RUN) $(VALGRIND_CMD) --error-exitcode=1 ./$(NAME) $(TEST_ARGS)	; \
	RET3=$$?	; \
	trap - INT TERM	; \
	echo "$(RESET)$(GRAY)=========================================="\
	" $(NAME) VALGRIND END$(RESET)"	; \
	\
	echo "$(RESET)$(GRAY)Return value:$(RESET)  DOCTEST: $$RET1"	; \
	echo "$(RESET)$(GRAY)Return value:$(RESET)     TEST: $$RET2"	; \
	echo "$(RESET)$(GRAY)Return value:$(RESET) VALGRIND: $$RET3"
doctest: format $(TEST_NAME)
	@\
	echo '$(GRAY)Executing arg:$(RESET)	./$(TEST_NAME) $(ARGS)'	; \
	trap '' INT TERM	; \
	./$(TEST_NAME) $(ARGS)	; \
	trap - INT TERM


exe: format $(NAME)
	@\
	echo '$(GRAY)Executing arg:$(RESET)	time ./$(NAME) $(ARGS)'	; \
	trap '' INT TERM	; \
	$(TIMED_RUN) ./$(NAME) $(ARGS)	; \
	trap - INT TERM

run: $(NAME)
	@\
	echo '$(GRAY)Executing arg:$(RESET)	./$(NAME) $(ARGS)'	; \
	trap '' INT TERM	; \
	./$(NAME) $(ARGS)	; \
	trap - INT TERM

debug: format $(DEBUG_NAME)
	@\
	echo '$(GRAY)Executing arg:$(RESET)	time ./$(DEBUG_NAME) $(ARGS)'	; \
	trap '' INT TERM	; \
	$(TIMED_RUN) ./$(DEBUG_NAME) $(ARGS)	; \
	trap - INT TERM

gprof: CFLAGS += $(GPROF_FLAGS)
gprof: fclean $(NAME)
	@\
	echo '$(GRAY)Executing arg:$(RESET)	gprof ./$(NAME)'	; \
	trap '' INT TERM	; \
	./$(NAME) $(ARGS)	; \
	trap - INT TERM
	gprof $(NAME) gmon.out > gmon-ignoreme.txt	; \
	cat gmon-ignoreme.txt	; \
	rm -f gmon-ignoreme.txt gmon.out
