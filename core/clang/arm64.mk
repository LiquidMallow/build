# Clang flags for arm64 arch, target or host.

CLANG_CONFIG_arm64_EXTRA_ASFLAGS :=

CLANG_CONFIG_arm64_EXTRA_CFLAGS :=

CLANG_CONFIG_arm64_EXTRA_LDFLAGS :=

# Include common unknown flags
CLANG_CONFIG_arm64_UNKNOWN_CFLAGS := \
  $(CLANG_CONFIG_UNKNOWN_CFLAGS) \
  -mthumb-interwork \
  -fgcse-after-reload \
  -frerun-cse-after-loop \
  -frename-registers \
  -fno-align-jumps \
  -fno-builtin-sin \
  -fno-caller-saves \
  -fno-early-inlining \
  -fno-move-loop-invariants \
  -fno-partial-inlining \
  -fno-strict-volatile-bitfields \
  -fno-align-jumps \
  -mfpu=neon-vfpv4 \
  -Wno-unused-local-typedefs \
  -fpredictive-commoning \
  -ftree-loop-distribute-patterns \
  -fvect-cost-model \
  -ftree-partial-pre \
  -fipa-cp-clone \
  -mvectorize-with-neon-quad

# We don't have any arm64 flags to substitute yet.
define subst-clang-incompatible-arm64-flags
  $(1)
endef
