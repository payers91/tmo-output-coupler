#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/coupler

epicsEnvSet( "IOCNAME",	  "$$IOCNAME" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "$$IOC_PV" )
epicsEnvSet( "IOCTOP",	  "$$IOCTOP" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/coupler.dbd" )
coupler_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
# Add drvAsynIPPortConfigure and asynSetTrace{,IO}Mask calls
# Set this to enable stream module diagnostics
# var streamDebug 1

# For asynSetTraceMask
#define ASYN_TRACE_ERROR 0x0001
#define ASYN_TRACEIO_DEVICE 0x0002
#define ASYN_TRACEIO_FILTER 0x0004
#define ASYN_TRACEIO_DRIVER 0x0008
#define ASYN_TRACE_FLOW 0x0010

# For asynSetTraceIOMask
#define ASYN_TRACEIO_ASCII 0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX 0x0004

## Set up ASYN ports
drvAsynIPPortConfigure("$$BASE", "ctl-tmo-misc-01:$$PORT",0,0,0)
asynSetOption("$$PORT", 0, "baud", "9600")
asynSetOption("$$PORT", 0, "bits", "8")
asynSetOption("$$PORT", 0, "parity", "none")
asynSetOption("$$PORT", 0, "stop", "1")

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
# Add records for the coupler here.
dbLoadRecords( "db/coupler.db", "BASE=$$BASE, PORT=$$PORT" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$$IOCNAME.sav" )
set_pass1_restoreFile( "$$IOCNAME.sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$$IOCNAME.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
