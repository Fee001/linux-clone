#!/bin/bash
# SPDX-License-Identifier: GPL-2.0

. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh

TID="loop_05"
ERR_CODE=0

if ! _have_program fio; then
	exit "$UBLK_SKIP_CODE"
fi

_prep_test "loop" "write and verify test"

_create_backfile 0 256M

dev_id=$(_add_ublk_dev -q 2 -t loop "${UBLK_BACKFILES[0]}")
_check_add_dev $TID $?

# run fio over the ublk disk
_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
ERR_CODE=$?

_cleanup_test "loop"

_show_result $TID $ERR_CODE
