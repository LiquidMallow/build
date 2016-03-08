# Copyright (C) 2015 The SaberMod Project
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

# SABERMOD_ARM_MODE for arm and arm64
# ARM mode is known to generate better native 32bit instructions on arm targets,
# instead of the default thumb mode which only generates 16bit code.
# This will disable the clang compiler when possible,
# and allow more optimizations to take place throughout GCC on target ARM modules.
# Clang is very limited with options, so kill it with fire.
# The LOCAL_ARM_COMPILERS_WHITELIST and LOCAL_ARM64_COMPILERS_WHITELIST will disable SaberMod ARM Mode for specified modules.
# All libLLVM's gets added to the WhiteList automatically.
# Big thanks to Joe Maples for the arm mode to replace thumb mode, and Sebastian Jena for the unveiling the arm thumb mode.

# Modules to Disable ARM Mode for.
LOCAL_ARM_COMPILERS_WHITELIST_BASE := \
  libmincrypt \
  libc++abi \
  libjni_latinime_common_static \
  libcompiler_rt \
  libnativebridge \
  libc++ \
  libRSSupport \
  netd \
  libscrypt_static \
  libRSCpuRef \
  libRSDriver \
  mdnsd \
  $(NO_OPTIMIZATIONS)

LOCAL_ARM64_COMPILERS_WHITELIST_BASE := \
  libc++abi \
  libcompiler_rt \
  libnativebridge \
  libjni_latinime_common_static \
  libRSSupport \
  libc++ \
  libRSCpuRef \
  netd \
  libRSDriver \
  libjpeg \
  mdnsd \
  $(NO_OPTIMIZATIONS)

 # Check if there's already something set somewhere.
 ifndef LOCAL_ARM_COMPILERS_WHITELIST
   LOCAL_ARM_COMPILERS_WHITELIST := \
     $(LOCAL_ARM_COMPILERS_WHITELIST_BASE)
 else
   LOCAL_ARM_COMPILERS_WHITELIST += \
     $(LOCAL_ARM_COMPILERS_WHITELIST_BASE)
 endif
 ifndef LOCAL_ARM64_COMPILERS_WHITELIST
   LOCAL_ARM64_COMPILERS_WHITELIST := \
     $(LOCAL_ARM64_COMPILERS_WHITELIST_BASE)
 else
   LOCAL_ARM64_COMPILERS_WHITELIST += \
     $(LOCAL_ARM64_COMPILERS_WHITELIST_BASE)
 endif

# ARM
ifeq ($(strip $(TARGET_ARCH)),arm)
  ifneq ($(strip $(LOCAL_IS_HOST_MODULE)),true)
    ifneq (1,$(words $(filter libLLVM% $(LOCAL_ARM_COMPILERS_WHITELIST),$(LOCAL_MODULE))))
      ifneq ($(filter arm thumb,$(LOCAL_ARM_MODE)),)
        ifeq ($(strip $(LOCAL_ARM_MODE)),arm)
          ifdef LOCAL_CFLAGS
            LOCAL_CFLAGS += -marm
          else
            LOCAL_CFLAGS := -marm
          endif
          ifeq ($(strip $(LOCAL_CLANG)),true)
            LOCAL_CLANG := false
          endif
        endif
        ifeq ($(strip $(LOCAL_ARM_MODE)),thumb)
          ifdef LOCAL_CFLAGS
            LOCAL_CFLAGS += -mthumb -mthumb-interwork
          else
            LOCAL_CFLAGS := -mthumb -mthumb-interwork
          endif
        endif
      else
        # Set to arm mode
        LOCAL_ARM_MODE := arm
        ifdef LOCAL_CFLAGS
          LOCAL_CFLAGS += -marm
        else
          LOCAL_CFLAGS := -marm
        endif
      endif
      ifeq ($(strip $(LOCAL_CLANG)),true)
          LOCAL_CLANG := false
      endif
    endif
  endif
endif

# ARM64
ifeq ($(strip $(TARGET_ARCH)),arm64)
  ifneq ($(strip $(LOCAL_IS_HOST_MODULE)),true)
    ifneq (1,$(words $(filter libLLVM% $(LOCAL_ARM64_COMPILERS_WHITELIST),$(LOCAL_MODULE))))
      ifneq ($(filter arm arm64 thumb,$(LOCAL_ARM_MODE)),)
      else
         # Set to arm64 mode
        LOCAL_ARM_MODE := arm64
      endif
      ifeq ($(strip $(LOCAL_CLANG)),true)
        LOCAL_CLANG := false
      endif
    endif
  endif
endif
