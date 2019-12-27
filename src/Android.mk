# Copyright Statement:
#
# This software/firmware and related documentation ("MediaTek Software") are
# protected under relevant copyright laws. The information contained herein
# is confidential and proprietary to MediaTek Inc. and/or its licensors.
# Without the prior written permission of MediaTek inc. and/or its licensors,
# any reproduction, modification, use or disclosure of MediaTek Software,
# and information contained herein, in whole or in part, shall be strictly prohibited.
#
# MediaTek Inc. (C) 2010. All rights reserved.
#
# BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
# THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
# RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
# AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
# NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
# SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
# SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
# THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
# THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
# CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
# SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
# STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
# CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
# AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
# OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
# MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
#
# The following software/firmware and/or related documentation ("MediaTek Software")
# have been modified by MediaTek Inc. All revisions are subject to any receiver's
# applicable license agreements with MediaTek Inc.


# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Configuration
BUILD_LAUNCHER  := false
BUILD_WMT_LPBK  := false
BUILD_WMT_CONCURRENCY := false
BUILD_STP_DUMP := false
BUILD_FDB := false
LOCAL_PATH := $(call my-dir)
NDS32_310_V2J := false
NDS32_321_V3J := false
NDS32_410_V3 := false
BUILD_CHECK_PATCH := false

ifneq ($(filter "CONSYS_6765" "CONSYS_6761" "CONSYS_6779",$(MTK_COMBO_CHIP)),)
    NDS32_410_V3 := true
endif

ifeq ($(NDS32_310_V2J), true)
    NDS32_PATH := $(LOCAL_PATH)/fdb/nds32_toolchain/bsp310_v2j
else ifeq ($(NDS32_321_V3J), true)
    NDS32_PATH := $(LOCAL_PATH)/fdb/nds32_toolchain/bsp321_v3j
else ifeq ($(NDS32_410_V3), true)
    NDS32_PATH := $(LOCAL_PATH)/fdb/nds32_toolchain/bsp410_v3
else
    NDS32_PATH := $(LOCAL_PATH)/fdb/nds32_toolchain/bsp410_v3
endif

#ifneq ($(MTK_COMBO_CHIP), )
#ifneq ($(MTK_COMBO_CHIP),MT7668)
BUILD_LAUNCHER  := true
BUILD_WMT_LPBK  := true
BUILD_WMT_CONCURRENCY := true
BUILD_FDB := true

#ifneq ($(filter MT6620E3,$(MTK_COMBO_CHIP)),)
    BUILD_STP_DUMP := true
#endif
#endif
#endif

BUILD_CHECK_PATCH := true

ifeq ($(BUILD_LAUNCHER), true)
include $(CLEAR_VARS)

$(warning after build launcher)
LOCAL_SRC_FILES  := stp_uart_launcher.c \
                    check_patch/cp_lib.c
LOCAL_MODULE := wmt_launcher
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_OWNER := mtk
LOCAL_MODULE_TAGS := optional
LOCAL_INIT_RC := ../init_connectivity.rc
LOCAL_SHARED_LIBRARIES := libcutils liblog
include $(MTK_EXECUTABLE)
endif

ifeq ($(BUILD_WMT_LPBK), true)
include $(CLEAR_VARS)
LOCAL_SRC_FILES  := wmt_loopback.c
LOCAL_MODULE := wmt_loopback
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_OWNER := mtk
LOCAL_MODULE_TAGS := eng
include $(MTK_EXECUTABLE)
endif


ifeq ($(BUILD_WMT_CONCURRENCY), true)
include $(CLEAR_VARS)
LOCAL_SRC_FILES  := wmt_concurrency.c
LOCAL_MODULE := wmt_concurrency
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_OWNER := mtk
LOCAL_MODULE_TAGS := eng
include $(MTK_EXECUTABLE)
endif

ifeq ($(BUILD_STP_DUMP), true)
include $(CLEAR_VARS)
LOCAL_SRC_FILES :=                                      \
		  stp_dump/stp_dump.c			\
		  stp_dump/eloop.c	\
		  stp_dump/os_linux.c	
# ifdef VENDOR_EDIT
# Laixin@PSW.CN.WiFi.Basic.Log.1162004, 2018/12/28
# Add for zip coredump and kernel log
LOCAL_SRC_FILES += stp_dump/oppo_utils.c
# endif /* VENDOR_EDIT */
LOCAL_SHARED_LIBRARIES := libc libcutils liblog
LOCAL_MODULE := stp_dump3
LOCAL_MODULE_TAGS := optional
LOCAL_INIT_RC := ../init_connectivity.rc
include $(MTK_EXECUTABLE)
endif

ifeq ($(BUILD_FDB), true)
include $(CLEAR_VARS)
LOCAL_CFLAGS += -I$(NDS32_PATH)
LOCAL_SRC_FILES :=		\
		  fdb/fdb.c	\
                  fdb/wmt_if.c
LOCAL_SHARED_LIBRARIES := libc libcutils liblog
LOCAL_MODULE := wmt_fdb
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_OWNER := mtk
LOCAL_MODULE_TAGS := optional
include $(MTK_EXECUTABLE)
endif

ifeq ($(BUILD_CHECK_PATCH), true)
include $(CLEAR_VARS)
LOCAL_SRC_FILES := check_patch/cp_main.c \
                   check_patch/cp_lib.c
LOCAL_SHARED_LIBRARIES := liblog libcutils
LOCAL_MODULE := wmt_check_patch
LOCAL_MODULE_TAGS := optional
LOCAL_INIT_RC := ../init_connectivity.rc
include $(MTK_EXECUTABLE)
endif