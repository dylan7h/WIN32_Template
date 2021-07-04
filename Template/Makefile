#============================================================
# Target Name
#============================================================
TARGET_DIR	:=	$(CURDIR)
TARGET		:=	$(notdir $(CURDIR))


#============================================================
# Include Build Environments
#============================================================
include $(CURDIR)/.props/00_common.mk
include $(CURDIR)/.props/01_toolchain.mk
include $(CURDIR)/.props/02_util.mk
include $(CURDIR)/.props/03_build_path.mk
include $(CURDIR)/.props/04_defines.mk
include $(CURDIR)/.props/05_asm_options.mk
include $(CURDIR)/.props/06_c_cpp_options.mk
include $(CURDIR)/.props/07_linker_options.mk
include $(CURDIR)/.props/08_addxxxfix.mk


#============================================================
# Default Make Target
#============================================================
all: $(ELF_DIR)/$(TARGET_PREFIX)$(TARGET).$(FILE_EXT)
	

#============================================================
# Clean Target
#============================================================
clean:
	@printf "%-10s Product of $(TARGET)\n" "RM"
	$(V)rm -rf $(OBJ_DIR)/$(TARGET)
	$(V)rm -rf $(DEF_DIR)/$(TARGET).def
	$(V)rm -rf $(ELF_DIR)/$(TARGET).$(EXE_EXT)
	$(V)rm -rf $(ELF_DIR)/$(TARGET_PREFIX)$(TARGET).$(STATIC_LIB_EXT)
	$(V)rm -rf $(ELF_DIR)/$(TARGET_PREFIX)$(TARGET).$(SHARED_LIB_EXT)
	$(V)rm -rf $(MAP_DIR)/$(TARGET).map
	$(V)rm -rf $(ASM_DIR)/$(TARGET).asm

#============================================================
# Run Target
#============================================================
run:
	$(ELF_DIR)/$(TARGET).$(EXE_EXT)


#============================================================
# Link Object files --> Make ELF File
#============================================================
$(ELF_DIR)/$(TARGET).$(EXE_EXT): $(OBJS)
	@printf "%-10s $@\n" "LD"
	$(V)$(CROSS_COMPILE)$(CXX) -m$(INSTRUCTION_SET) $(LDFLAGS) -Wl,-Map$(ASSIGN_OP)$(MAP_DIR)/$(TARGET).map $(LIB_DIR) $(LIBS) -o $@ $(OBJS) 
	@printf "%-10s $(ASM_DIR)/$(TARGET).asm\n" "OD"
	$(V)$(CROSS_COMPILE)$(OD) -d $@ > $(ASM_DIR)/$(TARGET).asm
	$(V)$(CROSS_COMPILE)$(SZ) $@


#============================================================
# Static Lib
#============================================================
$(ELF_DIR)/$(TARGET_PREFIX)$(TARGET).$(STATIC_LIB_EXT): $(OBJS)
	@printf "%-10s $@\n" "AR"
	$(V)$(CROSS_COMPILE)$(AR) rvcs $@ $(OBJS)


#============================================================
# Shared Lib
#============================================================
$(ELF_DIR)/$(TARGET_PREFIX)$(TARGET).$(SHARED_LIB_EXT): $(OBJS)
	@printf "%-10s $@\n" "AR"
	$(V)$(CROSS_COMPILE)$(CXX) -shared -fpic -o $@ $(OBJS)


#============================================================
# Make Directories
#============================================================
mkdir:
	@echo check build directoies...
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(DEF_DIR)
	@mkdir -p $(ELF_DIR)
	@mkdir -p $(MAP_DIR)
	@mkdir -p $(ASM_DIR)


#============================================================
# Compile Source files
#============================================================
# From *.S files
$(OBJ_DIR)/%.S.o:	%.S
	@mkdir -p $(dir $@)
	@printf "%-10s $<\n" "AS"
	$(V)$(CROSS_COMPILE)$(CC) -m$(INSTRUCTION_SET) $(AFLAGS) $(INCS) -c $< -o $@ -MMD -MP
	
# From *.s files
$(OBJ_DIR)/%.s.o:	%.s
	@mkdir -p $(dir $@)
	@printf "%-10s $<\n" "AS"
	$(V)$(CROSS_COMPILE)$(CC) -m$(INSTRUCTION_SET) $(AFLAGS) $(INCS) -c $< -o $@ -MMD -MP

# From *.c files
$(OBJ_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	@printf "%-10s $<\n" "CC"
	$(V)$(CROSS_COMPILE)$(CC) $(CFLAGS) $(INCS) -c $< -o $@ -MMD -MP

# From *.cpp files
$(OBJ_DIR)/%.cpp.o: %.cpp
	@mkdir -p $(dir $@)
	@printf "%-10s $<\n" "CXX"
	$(V)$(CROSS_COMPILE)$(CXX) $(CXXFLAGS) $(INCS) -c $< -o $@ -MMD -MP


#============================================================
# Make 'autoconf.h'
#============================================================
make_autoconf:
# Check if the file exists
	@IS_EXIST_DEF_FILE=$$(test -s $(DEF_DIR)/$(TARGET).def && echo -n y); 								\
	if [ "$${IS_EXIST_DEF_FILE}" != "y" ]; 																\
	then 																								\
		echo "$(DEFINES)" > $(DEF_DIR)/$(TARGET).def; 													\
		IS_INVALIDATE_DEF=y; 																			\
	else 																								\
		DEFINES_FROM_FILE=$$(cat $(DEF_DIR)/$(TARGET).def); 											\
		if [ "$${DEFINES_FROM_FILE}" != "$(DEFINES)" ]; 												\
		then 																							\
			IS_INVALIDATE_DEF=y; 																		\
		fi; 																							\
	fi; 																								\
																										\
	if [ "$${IS_INVALIDATE_DEF}" = "y" ]; 																\
	then 																								\
		printf "Generating 'autodonfig.h'..";															\
		mkdir -p $(AUTO_CONF_DIR);																		\
		rm -f $(AUTO_CONF_DIR)/autoconf.h;																\
		printf "#ifndef __AUTO_CONF_H__\n" > $(AUTO_CONF_DIR)/autoconf.h;								\
		printf "#define __AUTO_CONF_H__\n\n" >> $(AUTO_CONF_DIR)/autoconf.h;							\
		for ITEM in $(DEFINES); 																		\
		do 																								\
			DEFINE_SYMBOL=$${ITEM%%=*}; 																\
			DEFINE_VALUE=$${ITEM##*=}; 																	\
			printf "#ifndef $${DEFINE_SYMBOL}\n" >> $(AUTO_CONF_DIR)/autoconf.h;						\
			if [ -z $${DEFINE_VALUE} ];														 			\
			then 																						\
				printf "#define $${DEFINE_SYMBOL}\n" >> $(AUTO_CONF_DIR)/autoconf.h;					\
			else																						\
				printf "#define $${DEFINE_SYMBOL} ($${DEFINE_VALUE})\n" >> $(AUTO_CONF_DIR)/autoconf.h;	\
			fi;																							\
			printf "#endif /* !$${DEFINE_SYMBOL} */\n\n" >> $(AUTO_CONF_DIR)/autoconf.h;				\
			printf ".";																					\
		done; 																							\
		printf "#endif /* !__AUTO_CONF_H__ */\n" >> $(AUTO_CONF_DIR)/autoconf.h;						\
		echo " done!";																		\
	fi


#============================================================
# Debug Information
#============================================================
info:
	$(info INCS     : $(INCS))
	$(info LDS      : $(LDS))
	$(info ASRC     : $(ASRC))
	$(info CSRC     : $(CSRC))
	$(info OBJS     : $(OBJS))
	$(info DEPS     : $(DEPS))
	$(info LIB_DIR  : $(LIB_DIR))
	$(info LIBS     : $(LIBS))
	$(info AFLAGS   : $(AFLAGS))
	$(info CFLAGS   : $(CFLAGS))
	$(info LDFLAGS  : $(LDFLAGS))

# Include dependency file to have gcc recompile necessary sources  
-include $(DEPS)  
