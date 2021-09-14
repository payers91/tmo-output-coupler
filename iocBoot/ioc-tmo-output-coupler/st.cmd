#!../../bin/rhel7-x86_64/ioc-tmo-output-coupler

#- You may have to change ioc-tmo-output-coupler to something else
#- everywhere it appears in this file

< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db

epicsEnvSet "P" "$(P=ioc-tmo-output-coupler)


cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/ioc-tmo-output-coupler.dbd"
ioc_tmo_output_coupler_registerRecordDeviceDriver pdbbase

## Set up ASYN ports
drvAsynSerialPortConfigure("xx","tty",0,0,0)
asynSetOption("xx", -1, "baud", "9600")
asynSetOption("xx", -1, "bits", "8")
asynSetOption("xx", -1, "parity", "none")
asynSetOption("xx", -1, "stop", "1")

asynOctetSetInputEos("xx", -1, "\n")
asynOctetSetOutputEos("xx", -1, "\n")

## Load record instances
#dbLoadRecords("db/devtmo_coupler.db","P=$(P),PORT=xx")

cd "${TOP}/iocBoot/${IOC}"
iocInit

