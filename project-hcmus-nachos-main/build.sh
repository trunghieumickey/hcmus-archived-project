cd NachOS-4.0/code/build.linux 
make depend -j$(($(nproc)+1))
make -j$(($(nproc)+1))
make clean
cd ../../coff2noff 
make -j$(($(nproc)+1))
make clean
cd ../code/test
make -j$(($(nproc)+1))
make clean
