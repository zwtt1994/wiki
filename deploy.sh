if [ "$1" = "-i" ]
then
    mkdir output
    cd output
    git clone -b gh-pages git@github.com:zwtt1994/wiki.git ./
    cd ..
    exit 0
elif [ "$1" = "" ]
then
    echo deploy [Option]
    echo "       -i 初始化"
    echo "       message  提交到github并发布，提交信息为mesage"
    exit 0
else
    git add . --all
    git commit -am "$1"
    git pull origin master
    git push origin master

    simiki g
    conda activate py2
    fab deploy
    conda activate base
    


fi
