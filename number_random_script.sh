#!/bin/bash


MAXCOUNT=5
count=1
RANGE=100

echo
echo "$MAXCOUNT random numbers:"
echo "-----------------"
while [ "$count" -le $MAXCOUNT ]      # Generate 10 ($MAXCOUNT) random integers.
do
  number=$RANDOM
  let "number %= $RANGE"
  echo $number
  let "count += 1"  # Increment count.
done
echo "-----------------"
