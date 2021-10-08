#!/bin/sh

# Run unit test in Windows, Linux and macOS

#----------- check for Windows, Linux and macOS build
if [ "$RUNNER_OS" = "Linux" ]
then
  # show Linux OS version
  uname -a

  # show openSSL version
  openssl version

  # Exit immediately if a command exits with a non-zero status.
  set -e
  xvfb-run enduser/test_trackereditor -a --format=plain
  set +e

elif [ "$RUNNER_OS" = "macOS" ]
then
  # show macOS version
  sw_vers

  # show openSSL version
  openssl version

  # Exit immediately if a command exits with a non-zero status.
  set -e
  enduser/test_trackereditor -a --format=plain
  set +e

elif [ "$RUNNER_OS" = "Windows" ]
then
  # Exit immediately if a command exits with a non-zero status.
  set -e
  enduser/test_trackereditor.exe -a --format=plain
  set +e
fi


# Remove all the extra file created by test
# We do not what it in the ZIP release files.
rm -f enduser/console_log.txt
rm -f enduser/export_trackers.txt

# Undo all changes made by testing.
git reset --hard
