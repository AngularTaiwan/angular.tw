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

echo '第一个包是使用现代的 ES2015 语法，它能发挥现代浏览器内置支持的优势，发布更少的腻子脚本，因此打包尺寸更小。第二个包使用老式的 ES5 语法，包含所有必要的腻子脚本。其打包尺寸更大，但是支持老式浏览器。---source-map-explorer 会分析与包一起生成的 source map，并画出所有依赖的地图，精确展示哪些类包含在哪个包中。--添加具有部署功能的程序包时，它将为所选项目自动更新自动更新工作区配置--这个包用到了全部这些特性，还提供了一些额外功能。--您可以通过以下与包名称相关的链接来阅读更多内容：在下表中，您可以找到实现了到不同平台部署功能的软件包列表。每个软件包的 deploy 命令可能需要不同的命令行选项。--CLI 会构建两个单独的捆绑包作为已部署应用程序的一部分。--该选项是为了验证为生成 npm 包而产生的 .metadata.json 文件。--可用于指示模板编译器生成 .metadata.json 文件，以使用 npm 软件包进行分发，同时避免产生无法分发至 npm 的 .ngfactory.js 和 .ngstyle.js 文件。--组件开发工具包（CDK）中包括 a11y 软件包，该软件包提供了支持无障碍领域的各种工具--包导入--对于子模块和惰性加载的子模块，该模块应该这样用：RouterModule 可能会被多次导入：每个惰性加载的发布包都会导入一次。 但由于路由器要和全局共享的资源 - location 打交道，所以不能同时激活一个以上的 Router 服务。-- 包装过的值会在变更检测期间自动解包，并保存解包过的值。包匯入描述了这些包如何协作，以进行开发期构建。与 DOM 和浏览器有关的一切，特别是那些帮助往 DOM 中渲染的部分。这个包中还包括 bootstrapModuleFactory() 方法，该方法可以使用 AOT 编译器构建的生产环境发布包来引导应用。' | opencc -c angular

# 智能代码补全

# cd guide
# find . -name 'rx*.html' -type f -exec echo '{}' \; -exec opencc -c s2twp-Angular -i '{}' -o '{}' \;

# cd ../generated/docs/guide
# find . -name 'rx*.json' -type f -exec echo '{}' \; -exec opencc -c s2twp-Angular -i '{}' -o '{}' \;

# lite-server
