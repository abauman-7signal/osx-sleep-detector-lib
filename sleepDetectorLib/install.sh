#!/bin/bash

. runtime.env

echo "Install the plist for the daemon..."
cp -v "${DAEMON_PLIST}" "${DAEMON_LAUNCH_DIR}"

echo "Install the binaries for the daemon..."
mkdir -vp "${DAEMON_FOLDER}"
for BIN_FILE in "${BIN_FILES[@]}"
do
  cp -v "${BIN_FILE}" "${DAEMON_FOLDER}"
done
