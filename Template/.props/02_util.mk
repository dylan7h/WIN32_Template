#============================================================
# Append #define Lists
#============================================================
AUTO_CONF_DIR	:= include
DEFINES			:=

define add_define
	$(eval DEFINES += $1=$2)
endef
