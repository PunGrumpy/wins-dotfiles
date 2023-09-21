PACMAN_URL=https://mirror.msys2.org/msys/x86_64/pacman-6.0.2-9-x86_64.pkg.tar.zst
PACMAN_MIRROR_URL=https://mirror.msys2.org/msys/x86_64/pacman-6.0.2-9-x86_64.pkg.tar.zst
MSYS2_KEYRING_URL=https://mirror.msys2.org/msys/x86_64/pacman-6.0.2-9-x86_64.pkg.tar.zst
GCC_LIBS_URL=https://mirror.msys2.org/msys/x86_64/gcc-libs-13.2.0-2-x86_64.pkg.tar.zst
ZSTD_TOOL_URL=https://github.com/facebook/zstd/releases/download/v1.5.5/zstd-v1.5.5-win64.zip
GIT_FOR_WINDOWURL=https://github.com/git-for-windows/git-sdk-64/raw/main

echo "Make sure you RUN AS ADMINISTRATOR"
read -p "Press enter to continue..."

for url in $PACMAN_URL $PACMAN_MIRROR_URL $MSYS2_KEYRING_URL $GCC_LIBS_URL $ZSTD_TOOL_URL;
do
    curl -L -o ~/Downloads/fish/$(basename $url) $url
done

unzip ~/Downloads/fish/zstd-v1.5.5-win64.zip -d ~/Downloads/fish/zstd-v1.5.5-win64
cp ~/Downloads/fish/zstd-v1.5.5-win64/zstd.exe ~/Downloads/fish/zstd.exe

for file in ~/Downloads/fish/*.pkg.tar.zst;
do
    ~/Downloads/fish/zstd.exe -d $file
done

cd /
tar -xf ~/Downloads/fish/pacman-6.0.2-9-x86_64.pkg.tar
tar -xf ~/Downloads/fish/pacman-mirrors-20210603-1-any.pkg.tar
tar -xf ~/Downloads/fish/msys2-keyring-20210603-1-any.pkg.tar
tar -xf ~/Downloads/fish/gcc-libs-13.2.0-2-x86_64.pkg.tar

pacman-key --init
pacman-key --populate msys2
pacman -Syu

cat /etc/package-versions.txt | while read p v; do
  d=/var/lib/pacman/local/$p-$v
  mkdir -p $d
  for f in desc files install mtree; do
    echo "$URL$d/$f" ..... $d/$f
    curl -sSL "$URL$d/$f" -o $d/$f
  done
done

pacman -S fish