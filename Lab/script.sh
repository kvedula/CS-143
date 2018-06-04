#! /bin/bash

cd ~/Documents/Development/Github/CS-143A/Lab/student
./submit.sh
mv submission.zip 68149804.zip
cd ..
cp student/68149804.zip grader/
cd grader
./run.sh 68149804.zip
./grade.sh s_68149804