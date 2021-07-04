#============================================================
# Path of Build Product
#============================================================
BUILD_DIR		:=	$(TOPDIR)/build
OBJ_DIR			:=	$(BUILD_DIR)/obj/$(TARGET)
DEF_DIR			:=	$(BUILD_DIR)/def
BIN_DIR			:=	$(BUILD_DIR)/bin
ELF_DIR			:=	$(BUILD_DIR)/elf
MAP_DIR			:=	$(BUILD_DIR)/map
ASM_DIR			:=	$(BUILD_DIR)/asm


#============================================================
# Path of Include directoies
#============================================================
INC_PATH		:=	include

#============================================================
# Path of Source lists
#============================================================
# Legacy Assembly
LASRC	:=

# Assembly
ASRC	:=

# C Source
CSRC	:= 	source/hello.c

# C++ Source
CXXSRC	:=	source/hello.cpp

#============================================================
# Path of Libraries
#============================================================
LIB_DIR			:=

#============================================================
# Name of Libraries
#============================================================
# User Lib
LIB_NAME		:=

# System Lib
ifeq ($(OS),Windows_NT)
	LIB_NAME	+=	kernel32 user32 gdi32 winspool shell32 ole32 oleaut32 uuid comdlg32 advapi32 oldnames
else
	LIB_NAME	+=	
endif
