#!/bin/sh

OPENCC=/usr/share/opencc

echo '建立 STPhrases-Angular.ocd 檔案'
##########################################
rm -f TEMP-STPhrasesAngular.txt
cat ./data/dictionary/STPhrases.txt    >> TEMP-STPhrasesAngular.txt
cat ./STPhrases-Angular.txt            >> TEMP-STPhrasesAngular.txt
sudo opencc_dict -f text -t ocd -i TEMP-STPhrasesAngular.txt -o $OPENCC/STPhrases-Angular.ocd
# rm -f TEMP-STPhrasesAngular.txt

echo '建立 TWPhrases-Angular.ocd 檔案'
##########################################
rm -f TEMP-TWPhrasesAngular.txt
cat ./TWPhrases-Angular.txt              >> TEMP-TWPhrasesAngular.txt
cat ./TWPhrases-Other.txt                >> TEMP-TWPhrasesAngular.txt
cat ./data/dictionary/TWPhrasesIT.txt    >> TEMP-TWPhrasesAngular.txt
cat ./data/dictionary/TWPhrasesOther.txt >> TEMP-TWPhrasesAngular.txt
sudo opencc_dict -f text -t ocd -i TEMP-TWPhrasesAngular.txt -o $OPENCC/TWPhrases-Angular.ocd
# rm -f TEMP-TWPhrasesAngular.txt

echo "複製 s2twp-Angular.json 到 $OPENCC"
##########################################
sudo cp s2twp-Angular.json $OPENCC/
sudo cp s2twp-Angular.json $OPENCC/angular.json

echo "測試結果"
##########################################
#cd ~/build/ng-docs.github.io
#git reset --hard -q

# opencc -c angular -i /mnt/g/a.txt -o /mnt/g/b.txt
# cat generated/docs/features.json | opencc -c angular | grep 自動完成

echo '<a href=\"guide/npm-packages\">npm 包</a>Angular CLI 会安装必要的 Angular npm 包和其它依赖项。这可能需要几分钟。你可以使用 npm CLI client 来下载并安装这些 npm 包，它通过 Node.js® 安装并运行。默认情况下，Angular CLI 会使用 npm 客户端。当你用 npm 包安装该库时，它就映射到 node_modules 目录下。' | opencc -c angular

# 智能代码补全

# cd guide
# find . -name 'rx*.html' -type f -exec echo '{}' \; -exec opencc -c s2twp-Angular -i '{}' -o '{}' \;

# cd ../generated/docs/guide
# find . -name 'rx*.json' -type f -exec echo '{}' \; -exec opencc -c s2twp-Angular -i '{}' -o '{}' \;

# lite-server
