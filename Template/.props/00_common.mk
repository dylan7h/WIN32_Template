# Build Type Of Output( exe | static_lib | shared_lib )
BUILD_TYPE			:= 	exe

# Build Mode( debug | release )
BUILD_MODE			:=	debug

# Display Build Log( 0 | 1 )
BUILD_VERBOSE		:=	0

# Instruction Set
# x86_64	( 32 | 64 )
# aarch32	( thumb | arm )
# aarch64	( arm )
INSTRUCTION_SET		:=	64

# Display Build Logs
ifeq ($(BUILD_VERBOSE), 0)
	V				:=	@
endif

# Dependency Of OS Platform
ifeq ($(OS),Windows_NT)
	EXE_EXT			:=	exe
	STATIC_LIB_EXT	:= 	lib
	SHARED_LIB_EXT	:= 	dll

	ASSIGN_OP		:=	:
else
	EXE_EXT			:=	elf
	STATIC_LIB_EXT	:= 	a
	SHARED_LIB_EXT	:= 	so

	ASSIGN_OP		:=	=
endif

# Set Build Type
ifeq ($(BUILD_TYPE),exe)
	FILE_EXT		:= $(EXE_EXT)
else ifeq ($(BUILD_TYPE),static_lib)
	FILE_EXT		:= $(STATIC_LIB_EXT)
else ifeq ($(BUILD_TYPE),shared_lib)
	FILE_EXT		:= $(SHARED_LIB_EXT)
else
	#error "Invalid BUILD_TYPE"
endif
