# Copyright (C) 2015 DragonTC
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

# Polly flags for use with Clang
POLLY := -mllvm -polly \
  -mllvm -polly-parallel -lgomp \
  -mllvm -polly-parallel-force \
  -mllvm -polly-allow-nonaffine=1\
  -mllvm -polly-ast-detect-parallel \
  -mllvm -polly-vectorizer=polly \
  -mllvm -polly-opt-fusion=max \
  -mllvm -polly-opt-maximize-bands=yes \
  -mllvm -polly-run-dce

# Enable version specific Polly flags.
ifeq ($(LLVM_PREBUILTS_VERSION),3.7)
  POLLY += -mllvm -polly-no-early-exit
endif

ifeq ($(LLVM_PREBUILTS_VERSION),3.9 3.9)
  POLLY += -mllvm -polly-position=after-loopopt
endif

# Disable modules that don't work with DragonTC. Split up by arch.
DISABLE_DTC_arm := libm
DISABLE_DTC_arm64 := libm

# Set DISABLE_DTC based on arch
DISABLE_DTC := \
  $(DISABLE_DTC_$(TARGET_ARCH)) \
  $(LOCAL_DISABLE_DTC)

# Enable DragonTC on GCC modules. Split up by arch.
ENABLE_DTC_arm :=
ENABLE_DTC_arm64 :=

# Set ENABLE_DTC based on arch
ENABLE_DTC := \
  $(ENABLE_DTC_$(TARGET_ARCH)) \
  $(LOCAL_ENABLE_DTC)

# Disable modules that dont work with Polly. Split up by arch.
DISABLE_POLLY_arm :=

DISABLE_POLLY_arm64 := \
  libpng \
  libfuse \
  libLLVMAsmParser \
  libLLVMBitReader \
  libLLVMCodeGen \
  libLLVMInstCombine \
  libLLVMMCParser \
  libLLVMSupport \
  libLLVMSelectionDAG \
  libLLVMTransformUtils \
  libF77blas \
  libbccSupport \
  libblas \
  libRS \
  libstagefright_mpeg2ts \
  bcc_strip_attr

ifeq ($(LLVM_PREBUILTS_VERSION),3.8 3.9)
  DISABLE_POLLY_arm64 += \
	libLLVMARMCodeGen \
	libLLVMAnalysis \
	libLLVMScalarOpts \
	libLLVMCore \
	libLLVMInstrumentation \
	libLLVMipo \
	libLLVMMC \
	libLLVMSupport \
	libLLVMTransformObjCARC \
	libLLVMVectorize \
	libgui \
	libvixl
endif

# Set DISABLE_POLLY based on arch
DISABLE_POLLY := \
  $(DISABLE_POLLY_$(TARGET_ARCH)) \
  $(DISABLE_DTC) \
  $(LOCAL_DISABLE_POLLY)

# Make sure that the current module is not blacklisted. Polly is not
# used on host modules to reduce build time and unnecessary hassle.
# Optimizations on host do not affect ROM performance anyways.
ifneq (,$(filter true,$(LOCAL_CLANG)))
  ifeq (1,$(words $(filter $(DISABLE_DTC),$(LOCAL_MODULE))))
    my_cc := $(AOSP_CLANG)
    my_cxx := $(AOSP_CLANG_CXX)
  endif
  ifndef LOCAL_IS_HOST_MODULE
    ifneq (1,$(words $(filter $(DISABLE_POLLY),$(LOCAL_MODULE))))
      ifdef LOCAL_CFLAGS
        LOCAL_CFLAGS += -O3 $(POLLY)
      else
        LOCAL_CFLAGS := -O3 $(POLLY)
      endif
    else
      ifdef LOCAL_CFLAGS
        LOCAL_CFLAGS += -O2
      else
        LOCAL_CFLAGS := -O2
      endif
    endif
  endif
else
  ifeq (1,$(words $(filter $(ENABLE_DTC),$(LOCAL_MODULE))))
    my_cc := $(CLANG)
    my_cxx := $(CLANG_CXX)
    my_clang := true
  endif
endif
