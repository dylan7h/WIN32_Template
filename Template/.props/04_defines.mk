# Type Of Build
ifeq ($(BUILD_MODE), debug)
$(call add_define,DEBUG)
$(call add_define,_DEBUG)
else ifeq ($(BUILD_MODE), release)

else
	#error "Invalid BUILD_MODE"
endif


# Dependency Of OS Platform
ifeq ($(OS),Windows_NT)
	
else
	
endif
