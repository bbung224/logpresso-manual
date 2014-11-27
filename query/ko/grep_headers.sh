#!/bin/bash
grep -h $@ -P --color=auto "#{1,4} (?:\d+\.)*.*" *.md
