#
# Component Makefile
#

COMPONENT_SRCDIRS := .

ifdef CONFIG_APPTRACE_MEMBUFS_APPTRACE_PROTO_ENABLE
COMPONENT_SRCDIRS += port/xtensa
endif

COMPONENT_ADD_INCLUDEDIRS = include

COMPONENT_PRIV_INCLUDEDIRS = private_include \
	port/include

COMPONENT_ADD_LDFLAGS = -lapp_trace

ifdef CONFIG_APPTRACE_SV_ENABLE

COMPONENT_ADD_INCLUDEDIRS += \
	sys_view/Config \
	sys_view/SEGGER \
	sys_view/Sample/OS

COMPONENT_SRCDIRS += \
	gcov \
	sys_view/SEGGER \
	sys_view/Sample/OS \
	sys_view/Sample/Config \
	sys_view/esp \
	sys_view/ext
else
ifdef CONFIG_APPTRACE_GCOV_ENABLE
# do not produce gcov info for this module, it is used as transport for gcov
CFLAGS := $(subst --coverage,,$(CFLAGS))
COMPONENT_ADD_LDFLAGS += -Wl,--undefined=gcov_rtio_atexit
COMPONENT_SRCDIRS += gcov
endif
endif

COMPONENT_ADD_LDFRAGMENTS += linker.lf
