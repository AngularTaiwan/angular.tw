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

echo '下面的例子定义了一个带有只读数据的大型列表，这些数据预计每秒会变化很多次。- 实例的属性却是只读 -如果为 true，则每次变更只影响该控件本身，不影响其父控件。默认为 false。差异化加载是一种策略，它能让你的应用支持多种浏览器，但是只加载当前浏览器必须用到的代码。虽然把组件加到这个列表中也没什么坏处，不过最好还是只添加真正的入口组件。 不要添加那些被其它组件的模板引用过的组件。也就是说，在指定的注入器中最多只有某个服务的最多一个实例。你想要完整的响应信息，而不是只有响应体：总之，你希望的是只有当所有必要数据都已经拿到之后，才渲染这个路由组件。 不过这只有当 Angular 组件需要的恰好是该测试的根注入器时才能正常工作。不过，这种切换只发生在该组件元素的子节点上。可升级组件的简单例子是只有一个模板和一个控制器的指令：这只展示了一个英雄。要想把他们都列出来，就要为 <li> 添加一个 *ngFor 以便迭代出列表中的所有英雄：' | opencc -c angular

# 智能代码补全

# cd guide
# find . -name 'rx*.html' -type f -exec echo '{}' \; -exec opencc -c s2twp-Angular -i '{}' -o '{}' \;

# cd ../generated/docs/guide
# find . -name 'rx*.json' -type f -exec echo '{}' \; -exec opencc -c s2twp-Angular -i '{}' -o '{}' \;

# lite-server
