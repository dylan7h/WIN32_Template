export TARGET	:= Template
export TOPDIR	:= ..

# Job Count
JOB_CNT			:= 8

all:
	@$(MAKE) -C $(TARGET) mkdir --no-print-directory
	@$(MAKE) -C $(TARGET) make_autoconf --no-print-directory
	@$(MAKE) -C $(TARGET) -j $(JOB_CNT) --no-print-directory

clean:
	@$(MAKE) -C $(TARGET) clean --no-print-directory

distclean:
	rm -rf build/*

run: all
	@$(MAKE) -C $(TARGET) -j $(JOB_CNT) run --no-print-directory

debug: all
	@$(MAKE) -C $(TARGET) -j $(JOB_CNT) debug --no-print-directory

info:
	@$(MAKE) -C $(TARGET) info --no-print-directory
