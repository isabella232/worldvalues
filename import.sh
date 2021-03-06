#!/bin/bash

echo "Create database"
dropdb --if-exists worldvalues
createdb worldvalues

echo "Convert codebook from xls to csv format"
in2csv data/WV6_Codebook_v_2014_11_07.xls > data/codebook_raw.csv
tail -n +4 data/codebook_raw.csv > data/codebook.csv

echo "Set up tables and import codebook"
./import.py

echo "Import all the data"
psql worldvalues -c "COPY survey_responses FROM '`pwd`/data/WV6_Data_ascii_v_2015_04_18-clean.csv' DELIMITER ',' CSV;"
