#ifndef _WMT_IOCTL_H_
#define _WMT_IOCTL_H_

#include <sys/ioctl.h>

#define WMT_IOC_MAGIC 0xa0
#define WMT_IOCTL_SET_PATCH_NAME	 	_IOW(WMT_IOC_MAGIC,4,char*)
#define WMT_IOCTL_SET_STP_MODE		 	_IOW(WMT_IOC_MAGIC,5,int)
#define WMT_IOCTL_FUNC_ONOFF_CTRL		_IOW(WMT_IOC_MAGIC,6,int)
#define WMT_IOCTL_LPBK_POWER_CTRL		_IOW(WMT_IOC_MAGIC,7,int)
#define WMT_IOCTL_LPBK_TEST				_IOWR(WMT_IOC_MAGIC,8,char*)
#define WMT_IOCTL_GET_CHIP_INFO			_IOR(WMT_IOC_MAGIC,12,int)
#define WMT_IOCTL_SET_LAUNCHER_KILL		_IOW(WMT_IOC_MAGIC,13,int)
#define WMT_IOCTL_SET_PATCH_NUM			_IOW(WMT_IOC_MAGIC,14,int)
#define WMT_IOCTL_SET_PATCH_INFO		_IOW(WMT_IOC_MAGIC,15,char*)
#define WMT_IOCTL_PORT_NAME          	_IOWR(WMT_IOC_MAGIC, 20, char*)
#define WMT_IOCTL_WMT_CFG_NAME       	_IOWR(WMT_IOC_MAGIC, 21, char*)
#define WMT_IOCTL_WMT_QUERY_CHIPID   	_IOR(WMT_IOC_MAGIC,  22, int)
#define WMT_IOCTL_WMT_TELL_CHIPID    	_IOW(WMT_IOC_MAGIC,  23, int)
#define WMT_IOCTL_WMT_COREDUMP_CTRL  	_IOW(WMT_IOC_MAGIC, 24, int)
#define WMT_IOCTL_SEND_BGW_DS_CMD		_IOW(WMT_IOC_MAGIC,25,char*)
#define WMT_IOCTL_ADIE_LPBK_TEST		_IOWR(WMT_IOC_MAGIC,26,char*)
#define WMT_IOCTL_GET_APO_FLAG          _IOR(WMT_IOC_MAGIC, 28, int)
#define WMT_IOCTL_FW_DBGLOG_CTRL        _IOR(WMT_IOC_MAGIC, 29, int)
#define WMT_IOCTL_DYNAMIC_DUMP_CTRL     _IOR(WMT_IOC_MAGIC, 30, char*)
#define WMT_IOCTL_SET_ROM_PATCH_INFO    _IOW(WMT_IOC_MAGIC,31,char*)
#define WMT_IOCTL_FDB_CTRL              _IOW(WMT_IOC_MAGIC,32,char*)
#define WMT_IOCTL_GET_EMI_PHY_SIZE      _IOR(WMT_IOC_MAGIC, 33, unsigned int)
#define WMT_IOCTL_SET_ROM_PATCH_INFO	_IOW(WMT_IOC_MAGIC,31,char*)
#define WMT_IOCTL_FDB_CTRL		_IOW(WMT_IOC_MAGIC,32,char*)
#define WMT_IOCTL_GET_EMI_PHY_SIZE  	_IOR(WMT_IOC_MAGIC, 33, unsigned int)
#define WMT_IOCTL_FW_PATCH_UPDATE_RST   _IOR(WMT_IOC_MAGIC, 34, int)
#define WMT_IOCTL_GET_VENDOR_PATCH_NUM         _IOW(WMT_IOC_MAGIC, 35, int)
#define WMT_IOCTL_GET_VENDOR_PATCH_VERSION     _IOR(WMT_IOC_MAGIC, 36, char*)
#define WMT_IOCTL_SET_VENDOR_PATCH_VERSION     _IOW(WMT_IOC_MAGIC, 37, char*)
#define WMT_IOCTL_GET_CHECK_PATCH_STATUS       _IOR(WMT_IOC_MAGIC, 38, int)
#define WMT_IOCTL_SET_CHECK_PATCH_STATUS       _IOW(WMT_IOC_MAGIC, 39, int)
#define WMT_IOCTL_SET_ACTIVE_PATCH_VERSION     _IOR(WMT_IOC_MAGIC, 40, char*)
#define WMT_IOCTL_GET_ACTIVE_PATCH_VERSION     _IOR(WMT_IOC_MAGIC, 41, char*)
#define WMT_IOCTL_GET_DIRECT_PATH_EMI_SIZE      _IOR(WMT_IOC_MAGIC, 42, unsigned int)
#define WMT_IOCTL_GET_XOWCN_CLK_FAIL_COUNT      _IOR(WMT_IOC_MAGIC, 43, unsigned int)

typedef enum _CONSYS_BASE_ADDRESS_INDEX_ {
        MCU_BASE_INDEX = 0,
        TOP_RGU_BASE_INDEX,
        INFRACFG_AO_BASE_INDEX,
        SPM_BASE_INDEX,
        MCU_CFG_ON_BASE_INDEX,
        MCU_CIRQ_BASE_INDEX,
} ENUM_CONSYS_BASE_ADDRESS_INDEX, *P_ENUM_CONSYS_BASE_ADDRESS_INDEX;

typedef struct {
        unsigned int is_write;
        ENUM_CONSYS_BASE_ADDRESS_INDEX base_index;
        unsigned int offset;
        unsigned int value;
} WMT_FDB_CTRL, *P_WMT_FDB_CTRL;

enum wmt_chip_type {
    WMT_CHIP_TYPE_COMBO,
    WMT_CHIP_TYPE_SOC,
    WMT_CHIP_TYPE_INVALID
};

enum wmt_patch_type {
    WMT_PATCH_TYPE_ROM = 0,
    WMT_PATCH_TYPE_RAM,
    WMT_PATCH_TYPE_WIFI
};

enum wmt_cp_status {
    WMT_CP_INIT = 0,
    WMT_CP_READY_TO_CHECK,
    WMT_CP_CHECK_DONE
};


#define WMT_FIRMWARE_VERSION_LENGTH        (14)
#define WMT_FIRMWARE_MAX_FILE_NAME_LENGTH  (50)
struct wmt_vendor_patch {
    union {
      int  id;
      int  type;
    };
    char file_name[WMT_FIRMWARE_MAX_FILE_NAME_LENGTH + 1];
    char version[WMT_FIRMWARE_VERSION_LENGTH + 1];
};

#endif