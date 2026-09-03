#!/usr/bin/env bash
## AVAILABLE:
## * printf
## * printf_rgb

## printf
printf '\e[i1m%s\e[0m\n' "i2"
##

## printf_rgb
printf '\e[38;2;i1;i2;i3m%s\e[0m\n' "i4"
##
