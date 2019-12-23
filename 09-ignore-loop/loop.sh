#!/bin/bash

SITES="example.com voyagegroup.com voyagegroup.jp"

for v in $SITES
do
  ping -c 1 $v
done
