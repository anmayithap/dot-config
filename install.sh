echo "Welcom to environment installer!"

if [ "$(uname)" == "Darwin" ]; then
    echo "Mac"
    cd ./macos
    ./main.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "Linux"
    cd ./linux
    ./main.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
    echo "Windows"
fi
