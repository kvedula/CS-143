rm -rf submission
rm -f submission.zip
mkdir -p submission
cp -r scheduler/src scheduler/lib submission
cp scheduler/Makefile scheduler/simu.sh submission
zip -r submission.zip submission