#
# Copyright (c) 2015 Benzo Rom
# Copyright (c) 2015 Joe Maples
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
#
NOOP_BLUETOOTH := \
	audio.a2dp.default \
	bdt \
	bdtest \
	bdAddrLoader \
	bluetooth.mapsapi \
	bluetooth.default \
	bluetooth.mapsapi \
	bluetooth.default_32 \
	libbluetooth_jni \
	libbluetooth_jni_32 \
	libbt-brcm_gki \
	libbt-brcm_stack \
	libbt-hci \
	libbt-utils \
	libbt-qcom_sbc_decoder \
	libbt-brcm_bta \
	libbt-brcm_stack \
	libbt-vendor \
	libbtprofile \
	libbtdevice \
	libbtcore \
	libosi \
	net_test_osi \
	net_test_device \
	net_test_btcore \
	net_bdtool \
	net_hci \
	ositests

NO_OPTIMIZATIONS += \
	libandroid_runtime_32 \
	libbinder \
	libbypass \
	libc_tzcode \
	libc++ \
	libc++abi \
	libcrypto \
	libcrypto-host_32 \
	libcompiler_rt \
	libdex \
	libfdlibm \
	libft2 \
	libFraunhoferAAC \
	libharfbuzz_ng \
	libharfbuzz_ng_32 \
	libhwui \
	libicui18n \
	libinput \
	libjni_latinime_common_static \
	libloc_core \
	liblog \
	libmedia_jni \
	libmm-qcamera \
	libmmcamera_interface \
	libmmjpeg_interface_32 \
	libmmcamera_interface_32 \
	libmmjpeg_interface \
	libmcldScript \
	libmcldMC \
	libmedia_jni \
	libmedia_jni_32 \
	libmincrypt \
	libnativebridge \
	libnfc-nci_32 \
	libnfc-nci \
	libnfc_nci_jni \
	libpcap \
	libpdfiumcore \
	libpdfium \
	libperfprofdcore \
	libqdutils \
	libqomx_core \
	libpdfiumcore_32 \
	libRSCpuRef \
	libRSDriver \
	libRSSupport \
	libril \
	librilutils \
	librilutils_static \
	libscrypt_static \
	libsfntly \
	libskia \
	libsqlite_jni_32 \
	libselinux \
	libsfntly \
	libssh \
	libwebrtc_spl \
	libwebp-decode \
	libwebp-encode \
	libxml2 \
	fsck.f2fs \
	linker \
	logd \
	logcat \
	make_f2fs \
	mm-qcamera-app \
	mm-qcamera-app_32 \
	mm-jpeg-interface-test \
	mm-qcamera-app \
	mdnsd \
	nfc_nci.bcm2079x.default \
	netd \
	pppd \
	racoon \
	rsg-generator \
	$(NOOP_BLUETOOTH)


# No error
ifeq ($(DONT_ERROROUT),true)
 ifneq ($(filter 5.2% 6.0%,$(TARGET_GCC_VERSION)),)
  ifdef WARN_NO_ERROR
   ifeq (1,$(words $(filter $(WARN_NO_ERROR),$(LOCAL_MODULE))))
    ifdef LOCAL_CFLAGS
    LOCAL_CFLAGS += -Wno-error
    else
    LOCAL_CFLAGS := -Wno-error
    endif
    ifdef LOCAL_CPPFLAGS
    LOCAL_CPPFLAGS += -Wno-error
    else
    LOCAL_CPPFLAGS := -Wno-error
    endif
   endif
  endif
 endif
endif



# 03
ifeq ($(USE_O3_OPTIMIZATIONS),true)
BENZO_CLANG_CFLAGS := \
	-O3 \
	-Qunused-arguments \
	-Wno-unknown-warning-option

BENZO_CLANG_CPPFLAGS := \
	-O3 \
	-Qunused-arguments \
	-Wno-unknown-warning-option \
	-D__compiler_offsetof=__builtin_offsetof

BENZO_CLANG_LDFLAGS := -Wl,--sort-common
else
BENZO_CLANG_CFLAGS :=
BENZO_CLANG_CPPFLAGS :=
BENZO_CLANG_LDFLAGS :=
endif



# Graphite
ifeq ($(GRAPHITE_OPTS),true)
 ifndef LOCAL_IS_HOST_MODULE
  ifeq ($(LOCAL_CLANG),)
  LOCAL_DISABLE_GRAPHITE := \
	fio \
	libinput \
	libncurses \
	libhwui \
	libandroid_runtime \
	libunwind \
	libFFTEm \
	libicui18n \
	libskia \
	libvpx \
	libmedia_jni \
	libstagefright_mp3dec \
	libstagefright_amrwbenc \
	libicui18n \
	libselinux \
	libsfntly \
	libhevcdec \
	libharfbuzz_ng \
	libpdfiumcore \
	libpdfium \
	libjemalloc \
	libjni_filtershow_filters \
	libwebrtc_spl \
	libpcap \
	libFraunhoferAAC \
	libwebp-decode \
	libwebp-encode \
	libsfntly \
	libwebrtc_apm_utility \
	libmediandk \
	libmmcamera_interface_32 \
	libmmjpeg_interface_32 \
	libmmjpeg_interface \
	nfc_nci.bcm2079x.default \
	$(NO_OPTIMIZATIONS)

   ifeq ($(filter $(LOCAL_DISABLE_GRAPHITE), $(LOCAL_MODULE)),)
    ifdef LOCAL_CONLYFLAGS
     LOCAL_CONLYFLAGS += \
	-fgraphite \
	-fgraphite-identity \
	-floop-flatten \
	-floop-parallelize-all \
	-ftree-loop-linear \
	-floop-interchange \
	-floop-strip-mine \
	-floop-block
    else
     LOCAL_CONLYFLAGS := \
	-fgraphite \
	-fgraphite-identity \
	-floop-flatten \
	-floop-parallelize-all \
	-ftree-loop-linear \
	-floop-interchange \
	-floop-strip-mine \
	-floop-block
    endif
    ifdef LOCAL_CPPFLAGS
     LOCAL_CPPFLAGS += \
	-fgraphite \
	-fgraphite-identity \
	-floop-flatten \
	-floop-parallelize-all \
	-ftree-loop-linear \
	-floop-interchange \
	-floop-strip-mine \
	-floop-block
    else
     LOCAL_CPPFLAGS := \
	-fgraphite \
	-fgraphite-identity \
	-floop-flatten \
	-floop-parallelize-all \
	-ftree-loop-linear \
	-floop-interchange \
	-floop-strip-mine \
	-floop-block
    endif
   endif
  endif
 endif
endif



# IPA Analyser
ifeq ($(ENABLE_IPA_ANALYSER),true)
LOCAL_DISABLE_IPA :=

 ifeq (,$(filter true,$(LOCAL_CLANG)))
   ifneq (1,$(words $(filter $(LOCAL_DISABLE_IPA),$(LOCAL_MODULE))))
     ifdef LOCAL_CFLAGS
       LOCAL_CFLAGS += -fipa-sra -fipa-pta -fipa-cp -fipa-cp-clone
     else
       LOCAL_CFLAGS := -fipa-sra -fipa-pta -fipa-cp -fipa-cp-clone
     endif
     ifdef LOCAL_LDFLAGS
       LOCAL_LDFLAGS += -fipa-sra -fipa-pta -fipa-cp -fipa-cp-clone
     else
       LOCAL_LDFLAGS := -fipa-sra -fipa-pta -fipa-cp -fipa-cp-clone
     endif
   endif
 endif
endif



# Decrease debugging
ifeq ($(FORCE_DISABLE_DEBUGGING),true)
LOCAL_DEBUGGING_WHITELIST := $(NOOP_BLUETOOTH)

  ifneq ($(strip $(LOCAL_CLANG)),true)
    ifneq (1,$(words $(LOCAL_DEBUGGING_WHITELIST)))
      ifdef LOCAL_CFLAGS
        LOCAL_CFLAGS += -g0
      else
        LOCAL_CFLAGS := -g0
      endif
      ifdef LOCAL_CPPFLAGS
        LOCAL_CPPFLAGS += -g0
      else
        LOCAL_CPPFLAGS := -g0
      endif
    endif
  endif
endif



# pipe
ifeq ($(TARGET_USE_PIPE),true)
LOCAL_DISABLE_PIPE := \
	libc_dns \
	libc_tzcode \
	$(NO_OPTIMIZATIONS)

 ifeq ($(filter $(LOCAL_DISABLE_PIPE), $(LOCAL_MODULE)),)
  ifdef LOCAL_CONLYFLAGS
   LOCAL_CONLYFLAGS += \
        -pipe
  else
   LOCAL_CONLYFLAGS := \
        -pipe
  endif
  ifdef LOCAL_CPPFLAGS
   LOCAL_CPPFLAGS += \
	-pipe
  else
   LOCAL_CPPFLAGS := \
	-pipe
  endif
 endif
endif



# Cortex
ifeq ($(CORTEX_TUNINGS),true)
 ifndef LOCAL_IS_HOST_MODULE
 LOCAL_DISABLE_CORTEX := \
	libaudioutils \
	libmcldSupport \
	libmcldScript \
	libpixelflinger \
	libwebrtc_system_wrappers \
	libwifi-service \
	$(NOOP_BLUETOOTH) \
	$(NO_OPTIMIZATIONS)

  ifneq ($(strip $(LOCAL_CLANG)),true)
   ifeq ($(filter $(LOCAL_DISABLE_CORTEX), $(LOCAL_MODULE)),)
    ifdef LOCAL_CFLAGS
     LOCAL_CFLAGS += -mcpu=cortex-a57.cortex-a53 -mtune=cortex-a57.cortex-a53
    else
     LOCAL_CFLAGS := -mcpu=cortex-a57.cortex-a53 -mtune=cortex-a57.cortex-a53
    endif
   endif
  endif
 endif
endif



# pthread
ifeq ($(ENABLE_PTHREAD),true)
LOCAL_DISABLE_PTHREAD := \
	libc_netbsd \
	libc_tzcode \
	$(NOOP_BLUETOOTH) \
	$(NO_OPTIMIZATIONS)

 ifeq ($(filter $(LOCAL_DISABLE_PTHREAD), $(LOCAL_MODULE)),)
  ifdef LOCAL_CONLYFLAGS
   LOCAL_CFLAGS += -pthread
  else
   LOCAL_CFLAGS := -pthread
  endif
  ifdef LOCAL_CPPFLAGS
   LOCAL_CPPFLAGS += -pthread
  else
   LOCAL_CPPFLAGS := -pthread
  endif
 endif
endif



# OpenMP
ifeq ($(ENABLE_GOMP),true)
LOCAL_DISABLE_GOMP := \
	libc_tzcode \
	libscrypt_static \
	libperfprofdcore \
	libperfprofdutils \
	perfprofd \
	libv8_32 \
	libv8 \
	$(NOOP_BLUETOOTH) \
	$(NO_OPTIMIZATIONS)

 ifneq ($(filter arm arm64,$(TARGET_ARCH)),)
  ifneq ($(strip $(LOCAL_IS_HOST_MODULE)),true)
   ifneq ($(strip $(LOCAL_CLANG)),true)
    ifeq ($(filter $(LOCAL_DISABLE_GOMP), $(LOCAL_MODULE)),)
     ifdef LOCAL_CFLAGS
      LOCAL_CFLAGS += -lgomp -ldl -lgcc -fopenmp
     else
      LOCAL_CFLAGS := -lgomp -ldl -lgcc -fopenmp
     endif
     ifdef LOCAL_LDLIBS
      LOCAL_LDLIBS += -lgomp -lgcc
     else
      LOCAL_LDLIBS := -lgomp -lgcc
     endif
    endif
   endif
  endif
 endif
endif



# Memory Sanitize
ifeq ($(ENABLE_SANITIZE),true)
DISABLE_SANITIZE_LEAK := \
	libc_dns \
	libc_tzcode \
	$(NOOP_BLUETOOTH) \
	$(NO_OPTIMIZATIONS)

 ifneq ($(strip $(LOCAL_IS_HOST_MODULE)),true)
  ifneq ($(strip $(LOCAL_CLANG)),true)
   ifeq ($(filter $(DISABLE_SANITIZE_LEAK), $(LOCAL_MODULE)),)
    ifdef LOCAL_CONLYFLAGS
     LOCAL_CONLYFLAGS += -fsanitize=leak
    else
     LOCAL_CONLYFLAGS := -fsanitize=leak
    endif
   endif
  endif
 endif
endif



# Extra flags
ifeq ($(ENABLE_EXTRAGCC),true)
LOCAL_DISABLE_EXTRAGCC := \
	libc_tzcode \
	libbinder \
	libjemalloc \
	libmediandk \
	$(NOOP_BLUETOOTH) \
	$(NO_OPTIMIZATIONS)

 ifndef LOCAL_IS_HOST_MODULE
  ifeq ($(LOCAL_CLANG),)
   ifneq (1,$(words $(filter $(LOCAL_DISABLE_EXTRAGCC), $(LOCAL_MODULE))))
    ifdef LOCAL_CONLYFLAGS
     LOCAL_CONLYFLAGS += \
	-frerun-cse-after-loop \
	-frename-registers \
	-ffunction-sections \
	-fdata-sections \
	-fgcse-las \
	-fgcse-sm \
	-fipa-pta \
	-fivopts \
	-fweb \
	-fomit-frame-pointer \
	-frename-registers \
	-fsection-anchors \
	-ftracer \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-funsafe-loop-optimizations \
	-funswitch-loops \
	-fira-loop-pressure \
	-fforce-addr \
	-funroll-loops \
	-ftree-loop-distribution \
	-fsection-anchors \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-ffunction-sections \
	-ffp-contract=fast \
	-Wno-unused-parameter \
	-Wno-unused-but-set-variable \
	-Wno-maybe-uninitialized \
	-Wno-error=array-bounds \
	-Wno-error=clobbered \
	-Wno-error=maybe-uninitialized \
	-Wno-error=strict-overflow
    else
     LOCAL_CONLYFLAGS := \
	-frerun-cse-after-loop \
	-frename-registers \
	-ffunction-sections \
	-fdata-sections \
	-fgcse-las \
	-fgcse-sm \
	-fipa-pta \
	-fivopts \
	-fweb \
	-fomit-frame-pointer \
	-frename-registers \
	-fsection-anchors \
	-ftracer \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-funsafe-loop-optimizations \
	-funswitch-loops \
	-fira-loop-pressure \
	-fforce-addr \
	-funroll-loops \
	-ftree-loop-distribution \
	-fsection-anchors \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-ffunction-sections \
	-ffp-contract=fast \
	-Wno-unused-parameter \
	-Wno-unused-but-set-variable \
	-Wno-maybe-uninitialized \
	-Wno-error=array-bounds \
	-Wno-error=clobbered \
	-Wno-error=maybe-uninitialized \
	-Wno-error=strict-overflow
    endif
    ifdef LOCAL_CPPFLAGS
     LOCAL_CPPFLAGS += \
	-frerun-cse-after-loop \
	-frename-registers \
	-ffunction-sections \
	-fdata-sections \
	-fgcse-las \
	-fgcse-sm \
	-fipa-pta \
	-fivopts \
	-fweb \
	-fomit-frame-pointer \
	-frename-registers \
	-fsection-anchors \
	-ftracer \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-funsafe-loop-optimizations \
	-funswitch-loops \
	-fira-loop-pressure \
	-fforce-addr \
	-funroll-loops \
	-ftree-loop-distribution \
	-fsection-anchors \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-ffunction-sections \
	-ffp-contract=fast \
	-Wno-unused-parameter \
	-Wno-unused-but-set-variable \
	-Wno-maybe-uninitialized \
	-Wno-error=array-bounds \
	-Wno-error=clobbered \
	-Wno-error=maybe-uninitialized \
	-Wno-error=strict-overflow
    else
     LOCAL_CPPFLAGS := \
	-frerun-cse-after-loop \
	-frename-registers \
	-ffunction-sections \
	-fdata-sections \
	-fgcse-las \
	-fgcse-sm \
	-fipa-pta \
	-fivopts \
	-fweb \
	-fomit-frame-pointer \
	-frename-registers \
	-fsection-anchors \
	-ftracer \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-funsafe-loop-optimizations \
	-funswitch-loops \
	-fira-loop-pressure \
	-fforce-addr \
	-funroll-loops \
	-ftree-loop-distribution \
	-fsection-anchors \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-ffunction-sections \
	-ffp-contract=fast \
	-Wno-unused-parameter \
	-Wno-unused-but-set-variable \
	-Wno-maybe-uninitialized \
	-Wno-error=array-bounds \
	-Wno-error=clobbered \
	-Wno-error=maybe-uninitialized \
	-Wno-error=strict-overflow
    endif
   endif
  endif
 endif
endif



# Strict
ifeq ($(STRICT_ALIASING),true)
LOCAL_FORCE_DISABLE_STRICT := \
	mm-qcamera-app \
	libziparchive-host \
	libziparchive \
	libdiskconfig \
	logd \
	libjavacore \
	libstagefright_webm \
	libc_bionic_ndk \
	libc_dns \
	libc_gdtoa \
	libc_tzcode \
	libc_openbsd_ndk \
	liblog \
	libc \
	libbt-brcm_stack \
	libandroid_runtime \
	libandroidfw \
	libosi \
	libnetlink \
	libRS \
	clatd \
	ip \
	libc_nomalloc \
	linker

LOCAL_DISABLE_STRICT := \
	clatd_test \
	libart \
	libartd \
	libart-disassembler \
	libart-compiler \
	libsigchain \
	dalvikvm \
	dex2oat \
	dex2oatd \
	oatdump \
	patchoat \
	libdw \
	libmmjpeg_interface \
	mm-qcamera-app_32 \
	libbluetooth_jni_32 \
	libmmcamera_interface_32 \
	libmmjpeg_interface_32 \
	libmedia_jni_32 \
	libcrypto_static \
	nfc_nci.bcm2079x.default \
	fs_config_generate_shamu \
	fs_config \
	libcompiler_rt \
	libicui18n-host_32 \
	libbacktrace_test \
	libbacktrace \
	libbacktrace_32 \
	libunwindbacktrace \
	libunwind \
	libunwind_32 \
	libext2_quota_host \
	libc_bionic \
	libc_dns \
	libc_malloc \
	libc_openbsd_ndk \
	libc_bionic_ndk \
	libc_gdtoa \
	libc_gdtoa \
	libc_openbsd \
	libc \
	libc_nomalloc \
	libc_nomalloc \
	libcutils \
	liblog \
	libziparchive \
	libstagefright_webm \
	libtwrpmtp \
	libfusetwrp \
	libguitwrp \
	libpcre \
	libaapt \
	libz \
	libbz \
	libbase \
	libexpat \
	libcrypto-host \
	libuclibcrpc \
	libziparchive-host \
	libicui18n \
	libselinux \
	libsfntly \
	libharfbuzz_ng \
	libpdfiumcore \
	libpdfium \
	libandroid_runtime \
	libmedia \
	libicuuc-host_32 \
	libicui18n-host_32 \
	libstagefright_webm \
	libaudioflinger \
	libmediaplayerservice \
	libstagefright \
	libdiskconfig \
	libjavacore \
	libfdlibm \
	libvariablespeed \
	librtp_jni \
	libwilhelm \
	libdownmix \
	libldnhncr \
	libqcomvisualizer \
	libvisualizer \
	libutils \
	libandroidfw \
	libart-disassembler \
	libbt-brcm_stack \
	libandroid_runtime \
	libandroidfw \
	libosi \
	libnetlink \
	libsparse_host \
	librilutils \
	append2simg \
	busybox \
	static_busybox \
	bluetooth.default \
	backtrace_test \
	build_verity_tree \
	checkseapp \
	checkfc \
	checkpolicy \
	wpa_supplicant \
	aprotoc \
	aapt \
	aidl \
	dnsmasq \
	fastboot \
	logd \
	mdnsd \
	clatd \
	fio \
	img2simg \
	img2simg_host \
	ip \
	ping \
	ping6 \
	linker \
	net_net_gyp \
	linker \
	mm-vdec-omx-test \
	mkbootimg \
	mkbootfs \
	libssh \
	libext2fs \
	simg2img \
	simg2img_host \
	toybox \
	updater \
	verity_signer \
	tzdatacheck \
	tzdata \
	libbinder \
	fsck.f2fs \
	libnfc-nci_32 \
	libnfc-nci \
	libnfc_nci_jni \
	fs_config_generate_angler \
	$(NO_OPTIMIZATIONS)

 ifneq ($(filter $(LOCAL_DISABLE_STRICT),$(LOCAL_MODULE)),)
  ifdef LOCAL_CONLYFLAGS
   LOCAL_CONLYFLAGS += \
	-fno-strict-aliasing
  else
   LOCAL_CONLYFLAGS := \
	-fno-strict-aliasing
  endif
  ifdef LOCAL_CPPFLAGS
   LOCAL_CPPFLAGS += \
	-fno-strict-aliasing
  else
  LOCAL_CPPFLAGS := \
	-fno-strict-aliasing
  endif
  else
  ifdef LOCAL_CONLYFLAGS
   LOCAL_CONLYFLAGS += \
	-fstrict-aliasing \
	-Werror=strict-aliasing
  else
   LOCAL_CONLYFLAGS := \
	-fstrict-aliasing \
	-Werror=strict-aliasing
  endif
  ifdef LOCAL_CPPFLAGS
   LOCAL_CPPFLAGS += \
	-fstrict-aliasing \
	-Werror=strict-aliasing
  else
   LOCAL_CPPFLAGS := \
	-fstrict-aliasing \
	-Werror=strict-aliasing
  endif
  ifndef LOCAL_CLANG
   LOCAL_CONLYFLAGS += \
	-Wstrict-aliasing=3
   LOCAL_CPPFLAGS += \
	-Wstrict-aliasing=3
  else
   LOCAL_CONLYFLAGS += \
	-Wstrict-aliasing=2
   LOCAL_CPPFLAGS += \
	-Wstrict-aliasing=2
  endif
 endif
 else
 ifeq (1,$(words $(filter $(LOCAL_FORCE_DISABLE_STRICT),$(LOCAL_MODULE))))
  ifdef LOCAL_CONLYFLAGS
   LOCAL_CONLYFLAGS += \
	-fno-strict-aliasing
  else
   LOCAL_CONLYFLAGS := \
	-fno-strict-aliasing
  endif
  ifdef LOCAL_CPPFLAGS
   LOCAL_CPPFLAGS += \
	-fno-strict-aliasing
  else
   LOCAL_CPPFLAGS := \
	-fno-strict-aliasing
  endif
 endif
endif
