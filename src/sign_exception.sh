#!/bin/bash

trap 'trap_int' INT
trap_int() { logging_msg "WARN" "Keyboard Interrupt"; exit; }
