#!/bin/sh
# Credits to https://www.reddit.com/r/kde/comments/1bcf0ak/toggling_hdr_via_shortcut_or_command/
# I added the brightness, which is fairly necessary for this kind of switch
#
# Usage possible in steam to enable HDR in a game as follows
#
# hdr.sh enable && gamescope --hdr-enabled -W3840 -H2160 -f --force-grab-cursor -- %command%; hdr.sh disable 
#

usage() { echo "Usage: $0 <enable|disable>" 1>&2; exit 1; }

action=${1};
brightness=`ddcutil -t -d 1 getvcp 10 | cut -w -f 4`;

if [ "$(kscreen-doctor -o | ansi2txt | grep -cm1 "HDR: enabled")" -ge 1 ];
then
  state="enabled"
  echo ${brightness} > ~/.hdr_brightness;
else
  state="disabled"
  echo ${brightness} > ~/.sdr_brightness;
fi;

if [ -z $action ];
then
  if [ ${state} == "enabled" ];
  then
    action="disable";
  elif [ ${state} == "disabled" ];
  then
    action="enable";
  fi;
fi;

if [ ${action} == "enable" ] || [ ${action} == "on" ];
then
  action="enable";
  brightness=`cat ~/.hdr_brightness`;
elif [ ${action} == "disable" ] || [ ${action} == "off" ];
then
  action="disable";
  brightness=`cat ~/.sdr_brightness`;
fi;

echo "Brightness: ${brightness} HDR State: ${state} Action: ${action}"

kscreen-doctor output.DP-1.wcg.${action} output.DP-1.hdr.${action} output.DP-1.brightness.${brightness};
