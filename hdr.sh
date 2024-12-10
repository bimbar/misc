#!/bin/sh
# Credits to https://www.reddit.com/r/kde/comments/1bcf0ak/toggling_hdr_via_shortcut_or_command/
# I added the brightness, which is fairly necessary for this kind of switch

if [ "$(kscreen-doctor -o | ansi2txt | grep -cm1 "HDR: enabled"| cut -d= -f2)" -ge 1 ];
then
  kscreen-doctor output.DP-2.hdr.disable;
  kscreen-doctor output.DP-2.wcg.disable;
  kscreen-doctor output.DP-2.brightness.30;
else
  kscreen-doctor output.DP-2.wcg.enable;
  kscreen-doctor output.DP-2.hdr.enable;
  kscreen-doctor output.DP-2.brightness.100;
fi;
