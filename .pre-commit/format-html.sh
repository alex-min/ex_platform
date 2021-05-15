#!/bin/bash
if !  command -v htmlbeautifier  &> /dev/null
then
    gem install htmlbeautifier
fi

htmlbeautifier "$@"
