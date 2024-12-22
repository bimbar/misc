#!/bin/sh
# Credits to https://www.reddit.com/r/kde/comments/1bcf0ak/toggling_hdr_via_shortcut_or_command/
# I added the brightness, which is fairly necessary for this kind of switch
#
# Usage possible in steam to enable HDR in a game as follows
#
# hdr.sh on && gamescope --hdr-enabled -W3840 -H2160 -f --force-grab-cursor -- %command% && hdr.sh off
#

usage() { echo "Usage: $0 <on|off>" 1>&2; exit 1; }

action=${1};

if [ -z $action ];
then
  if [ "$(kscreen-doctor -o | ansi2txt | grep -cm1 "HDR: enabled")" -ge 1 ];
  then
    action="off";
  else
    action="on";
  fi;
fi;

if [ ${action} == "on" ];
then
  echo "Enabling HDR"
  kscreen-doctor output.DP-1.wcg.enable output.DP-1.hdr.enable output.DP-1.brightness.100;
elif [ ${action} == "off" ];
then
  echo "Disabling HDR"
  kscreen-doctor output.DP-1.wcg.disable output.DP-1.hdr.disable output.DP-1.brightness.25;
else
  usage;
fi;
