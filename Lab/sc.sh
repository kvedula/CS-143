#!/bin/bash

cd student
./submit.sh
mv submission.zip 68149804.zip
cd ..
rm grader/68149804.zip
rm -r grader/s_68149804
cp student/68149804.zip grader
rm student/68149804.zip
cd grader
./run.sh 68149804.zip
./grade.sh s_68149804