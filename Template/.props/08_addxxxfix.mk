#============================================================
# Add prefix and suffix to use compiler option
#============================================================
INCS		:=	$(addprefix -I , $(INC_PATH))

OBJS		:=	$(addprefix $(OBJ_DIR)/, $(LASRC:.S=.S.o))
OBJS		+=	$(addprefix $(OBJ_DIR)/, $(ASRC:.s=.s.o))
OBJS		+=	$(addprefix $(OBJ_DIR)/, $(CSRC:.c=.c.o))
OBJS		+=	$(addprefix $(OBJ_DIR)/, $(CXXSRC:.cpp=.cpp.o))

DEPS		:=	$(addprefix $(OBJ_DIR)/, $(LASRC:.S=.S.d))
DEPS		+=	$(addprefix $(OBJ_DIR)/, $(ASRC:.s=.s.d))
DEPS		+=	$(addprefix $(OBJ_DIR)/, $(CSRC:.c=.c.d))
DEPS		+=	$(addprefix $(OBJ_DIR)/, $(CXXSRC:.cpp=.cpp.d))

LIB_DIR		:=	$(addprefix -L, $(LIB_DIR))
LIBS		:=	$(addprefix -l, $(LIB_NAME))
LDFLAGS		=	$(addprefix -Wl,,$(LINKER_FLAGS))
AFLAGS		=	$(addprefix -Wa,,$(ASSEMBLER_FLAGS))
