# C Standard Version
C_STANDARD_VER		:= 	gnu89
CXX_STANDARD_VER	:= 	c++14

#============================================================
# Set Compile Options by Configurations
#============================================================
C_CXX_COMMON_FLAGS	:= -m$(INSTRUCTION_SET) -W -Werror -Wall -pedantic-errors


# Build Mode
ifeq ($(BUILD_MODE), debug)
	C_CXX_COMMON_FLAGS	+= -g
else ifeq ($(BUILD_MODE), release)
	C_CXX_COMMON_FLAGS	+= -O2
else
	#error "Invalid BUILD_MODE"
endif


# Build Type
ifeq ($(BUILD_TYPE),exe)
	C_CXX_COMMON_FLAGS	+=
else ifeq ($(BUILD_TYPE),static_lib)
	C_CXX_COMMON_FLAGS	+=
else ifeq ($(BUILD_TYPE),shared_lib)
	C_CXX_COMMON_FLAGS	+=
else
	#error "Invalid BUILD_TYPE"
endif

# Compile Flags
CFLAGS				:= $(C_CXX_COMMON_FLAGS) -std=$(C_STANDARD_VER) 
CXXFLAGS			:= $(C_CXX_COMMON_FLAGS) -std=$(CXX_STANDARD_VER)
