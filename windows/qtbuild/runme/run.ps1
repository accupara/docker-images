mkdir C:/code
mkdir C:/code/qt6-build
cd C:/code

git clone https://code.qt.io/qt/qt5.git
cd qt5
git checkout 6.2.1
perl .\init-repository

cd ~/code/qt6-build
..\qt5\configure -prefix C:\Qt6
cmake --build . --parallel
