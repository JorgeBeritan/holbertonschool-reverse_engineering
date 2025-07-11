#!/bin/bash
file=$1

magic_number=$(readelf -h $file | grep "Magic" | awk '{$1=""; sub(/^ /, "");print }')
class=$(readelf -h $file | grep "Class" | awk '{print $2}')
byte_order=$(readelf -h $file | grep "Data" | awk '{print $4, $5}')
entry_point=$(readelf -h $file | grep "Entry point address" | awk '{print $4}')

echo "ELF Header Information for '$file':"
echo "----------------------------------------"
echo "Magic number: $magic_number"
echo "Class: $class"
echo "Byte Order: $byte_order"
echo "Entry Point Address: $entry_point"
