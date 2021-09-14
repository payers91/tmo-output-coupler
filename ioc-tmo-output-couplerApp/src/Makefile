TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = ioc-tmo-output-coupler
# ioc-tmo-output-coupler.dbd will be created and installed
DBD += ioc-tmo-output-coupler.dbd

# ioc-tmo-output-coupler.dbd will be made up from these files:
ioc-tmo-output-coupler_DBD += base.dbd

ioc-tmo-output-coupler_DBD += stream.dbd
ioc-tmo-output-coupler_DBD += drvAsynSerialPort.dbd

# Include dbd files from all support applications:
#ioc-tmo-output-coupler_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
ioc-tmo-output-coupler_LIBS += stream asyn

# ioc-tmo-output-coupler_registerRecordDeviceDriver.cpp derives from ioc-tmo-output-coupler.dbd
ioc-tmo-output-coupler_SRCS += ioc-tmo-output-coupler_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
ioc-tmo-output-coupler_SRCS_DEFAULT += ioc-tmo-output-couplerMain.cpp
ioc-tmo-output-coupler_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#ioc-tmo-output-coupler_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
ioc-tmo-output-coupler_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

