# Developer's Notes

## Build

https://github.com/AngularTaiwan/angular.tw/tree/beta

```sh
./build.sh
```

## Test

先修改 `./build.sh` 檔案內的測試文字，再執行 `./build.sh` 即可確認是否翻譯正確。

## CI/CD

- 簡體字直接轉繁體字的校正
  - https://gist.github.com/doggy8088/57b77b625e60b337fd96001b2e7c4b0e/
- 已經轉成繁體中文之後的繁體詞彙校正
  - https://gist.github.com/doggy8088/5d965d7219413fdabe586212e3d4700b

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
