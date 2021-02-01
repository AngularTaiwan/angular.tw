# Developer's Notes

## Build

<https://github.com/AngularTaiwan/angular.tw/tree/beta>

```sh
./build.sh
```

## Test

先修改 `./build.sh` 檔案內的測試文字，再執行 `./build.sh` 即可確認是否翻譯正確。

## CI/CD

- 簡體字直接轉繁體字的校正
  - <https://gist.github.com/doggy8088/57b77b625e60b337fd96001b2e7c4b0e/>
- 已經轉成繁體中文之後的繁體詞彙校正
  - <https://gist.github.com/doggy8088/5d965d7219413fdabe586212e3d4700b>

## OpenCC

- 重要名詞

  - `segmentation` (分詞)

      `mmseg` is stand for `MaxMatchSegmentation` ( [Source](https://github.com/BYVoid/OpenCC/blob/master/src/Config.cpp) )

  - `conversion_chain` (分詞後的詞彙轉換)

      如果有**跨越分詞**的字句，是無法透過 `conversion_chain` 指定的字典檔轉換的！

- `STPhrases-Angular.ocd` (分詞檔)

    這個檔案是由 `STPhrases.txt` 與 `STPhrases-Angular.txt` 組合而建立的字典檔。

    `STPhrases.txt` 包含 `48933` 個簡轉繁的常用詞彙，**這裡面有許多導致翻譯錯誤的詞彙，下次看到就要先移除**。

    `STPhrases-Angular.txt` 包含 `15` 個簡轉繁 Angular 領域的常用詞彙。

- `TWPhrases-Angular.ocd` (轉換檔)

    這個檔案是由 `TWPhrases-Angular.txt`, `TWPhrases-Other.txt`, `TWPhrasesIT.txt`, `TWPhrasesOther.txt` 組合而建立的字典檔。

- `s2twp-Angular.json`

    ```json
    {
        "name": "Simplified Chinese to Traditional Chinese (Taiwan standard, with phrases, with Angular)",
        "segmentation": {
            "type": "mmseg",
            "dict": {
                "type": "ocd",
                "file": "STPhrases-Angular.ocd"
            }
        },
        "conversion_chain": [
            {
                "dict": {
                    "type": "group",
                    "dicts": [
                        {
                            "type": "ocd",
                            "file": "STPhrases-Angular.ocd"
                        },
                        {
                            "type": "ocd",
                            "file": "STCharacters.ocd"
                        }
                    ]
                }
            },
            {
                "dict": {
                    "type": "ocd",
                    "file": "TWPhrases-Angular.ocd"
                }
            },
            {
                "dict": {
                    "type": "ocd",
                    "file": "TWVariants.ocd"
                }
            }
        ]
    }
    ```

## 微調字典檔筆記

- 一定是「分詞檔」先改，因為所有文字都會先被「分詞」，然後再做「轉換」

    `STPhrases-Angular.ocd` (分詞檔)

    `data\dictionary\STCharacters.txt` 是「分詞」之後的第一個轉換字典，用來「轉換」某些**異體字**！

- 剩下來的才是用來轉換微調後的轉換詞彙！

## 注意事項

- `STPhrases.txt` 包含 `48933` 個簡轉繁的常用詞彙，**這裡面有許多導致翻譯錯誤的詞彙，下次看到就要先移除**。

## 使用 Docker 容器建置筆記

```sh
docker run -it --name buildangulartw ubuntu:16.04
```

```sh
## Intall packages

apt update
apt install lsb-release build-essential cmake doxygen uni2ascii wget curl git vim python python-pip -y

dpkg -L uni2ascii

## Check system info

cd ~ && mkdir build && cd build

pwd
lsb_release -a

## Install OpenCC

wget https://github.com/BYVoid/OpenCC/archive/ver.1.0.5.tar.gz
tar zxf ver.1.0.5.tar.gz && cd OpenCC-ver.1.0.5 && make && make install && cd ..
# rm -rf OpenCC-ver.1.0.5
# rm -f ver.1.0.5.tar.gz

## Make Angular Dict for OpenCC

# Repo: https://github.com/AngularTaiwan/angular.tw/tree/beta

cd ~ && cd build

OPENCC=/usr/share/opencc

# 簡體字直接轉繁體字的校正
# https://gist.github.com/doggy8088/57b77b625e60b337fd96001b2e7c4b0e/
curl -sSL -o TEMP-STPhrasesAngular.txt https://gist.githubusercontent.com/doggy8088/57b77b625e60b337fd96001b2e7c4b0e/raw/8b72bcf6950abd33234953083515d90436c98674/TEMP-STPhrasesAngular.txt

# 已經轉成繁體中文之後的繁體詞彙校正
# https://gist.github.com/doggy8088/5d965d7219413fdabe586212e3d4700b
curl -sSL -o TEMP-TWPhrasesAngular.txt https://gist.githubusercontent.com/doggy8088/5d965d7219413fdabe586212e3d4700b/raw/62930d47fa13595e907a52972ae84c48e5845a7e/TEMP-TWPhrasesAngular.txt

opencc_dict -f text -t ocd -i TEMP-STPhrasesAngular.txt -o $OPENCC/STPhrases-Angular.ocd
opencc_dict -f text -t ocd -i TEMP-TWPhrasesAngular.txt -o $OPENCC/TWPhrases-Angular.ocd

# opencc_dict -f text -t ocd2 -i TEMP-STPhrasesAngular.txt -o $OPENCC/STPhrases-Angular.ocd2
# opencc_dict -f text -t ocd2 -i TEMP-TWPhrasesAngular.txt -o $OPENCC/TWPhrases-Angular.ocd2

cat <<EOF | tee $OPENCC/s2twp-Angular.json
{
    "name": "Simplified Chinese to Traditional Chinese (Taiwan standard, with phrases, with Angular)",
    "segmentation": {
        "type": "mmseg",
        "dict": {
            "type": "ocd",
            "file": "STPhrases-Angular.ocd"
        }
    },
    "conversion_chain": [
        {
            "dict": {
                "type": "group",
                "dicts": [
                    {
                        "type": "ocd",
                        "file": "STPhrases-Angular.ocd"
                    },
                    {
                        "type": "ocd",
                        "file": "STCharacters.ocd"
                    }
                ]
            }
        },
        {
            "dict": {
                "type": "ocd",
                "file": "TWPhrases-Angular.ocd"
            }
        },
        {
            "dict": {
                "type": "ocd",
                "file": "TWVariants.ocd"
            }
        }
    ]
}
EOF

ls -laF $OPENCC/


git clone https://github.com/ng-docs/material-cn-prebuilt.git
cd material-cn-prebuilt

## Run S2T Conversion

find . \( -name '*.json' -o -name '*.html' \)   -type f -exec echo '{}' \; -exec opencc -c s2twp-Angular -i '{}' -o '{}' \;

## ascii2uni

find . -name '*.js' -type f -exec echo '{}' \; -exec sh -c "ascii2uni  -Z '\u%04X' -q {} > {}.new" \; -exec sh -c 'mv {}.new {}' \; -exec opencc -c s2twp-Angular -i '{}' -o '{}' \;

## Add web.config

cat <<EOF > web.config
<?xml version="1.0"?>
<configuration>
    <system.webServer>
        <staticContent>
            <mimeMap fileExtension=".json" mimeType="application/json" />
        </staticContent>
        <rewrite>
          <rules>
            <rule name="SPA" stopProcessing="true">
              <match url=".*" />
              <action type="Rewrite" url="/" />
              <conditions>
                <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
              </conditions>
            </rule>
          </rules>
        </rewrite>
    </system.webServer>
</configuration>
EOF

## Fix CSS font-family

find . -type f -name '*.css' -exec sed -i 's/font-family:Roboto/font-family:"Microsoft JhengHei",Roboto/g' '{}' \;

## Copy to StagingDirectory

# rsync -av . $(Build.ArtifactStagingDirectory) --exclude .git --exclude .github
rsync -av . ../mb/ --exclude .git --exclude .github
```
