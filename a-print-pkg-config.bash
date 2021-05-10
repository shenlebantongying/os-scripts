#!/bin/bash

#TODO: generic print path function
pcPath=$(pkg-config --variable pc_path pkg-config)
tr ':' '\n' <<< "$pcPath"