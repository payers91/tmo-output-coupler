TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build an ioc application
# Use PROD_IOC_RTEMS for RTEMS only
# Use PROD_IOC_Linux for Linux only
PROD_IOC = coupler

# coupler.dbd will be created and installed
DBD += coupler.dbd

# coupler.dbd will be made up from these files:
coupler_DBD += base.dbd
coupler_DBD += iocAdmin.dbd
coupler_DBD += asSupport.dbd
coupler_DBD += asyn.dbd
coupler_DBD += drvAsynSerialPort.dbd
coupler_DBD += drvAsynIPPort.dbd
coupler_DBD += stream.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
coupler_SRCS += coupler_registerRecordDeviceDriver.cpp
coupler_SRCS_DEFAULT += couplerMain.cpp

# Add locally compiled object code
#coupler_SRCS += dbSubExample.c

coupler_LIBS += devIocStats
coupler_LIBS += autosave
coupler_LIBS += asyn
coupler_LIBS += stream
coupler_LIBS += $(EPICS_BASE_IOC_LIBS)

ifneq '$(T_A)' 'RTEMS-beatnik'
PROD_SYS_LIBS_DEFAULT += pcre
SHRLIB_DEPLIB_DIRS += $(PCRE_LIB)
endif

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

