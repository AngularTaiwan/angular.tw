let data = require("./generated/navigation.json");
const fs = require('fs');

for (let i = 0; i < data.SideNav.length; i++) {
    const item = data.SideNav[i];
    if (item.title == '-') {
        data.SideNav.splice(i + 1);
        break;
    }
}

data.SideNav.push({
    "title": "Angular Taiwan (FB)",
    "tooltip": "台灣 Angular 臉書社團",
    "url": "https://www.facebook.com/groups/augularjs.tw/"
});
data.SideNav.push({
    "title": "Angular Taiwan (YouTube)",
    "tooltip": "台灣 Angular YouTube 頻道，有大量影音學習資源。",
    "url": "https://www.youtube.com/c/AngularUserGroupTaiwan"
});
data.SideNav.push({
    "title": "Angular Taiwan 線上讀書會",
    "tooltip": "讀書會每周三晚上 8:30 進行，每季更換主題，歡迎加入。",
    "url": "https://www.facebook.com/groups/1345890212093830/"
});
data.SideNav.push({
    "title": "台灣 Angular 技術論壇",
    "tooltip": "如何讓學習 Angular 的腳步變得紮實快速？如何讓學習變得有趣不孤單？台灣 Angular 技術論壇就是一個讓您盡情發問的好地方，從新手入門到刁鑽難題，都有一群熱心的愛好者關心您的每個問題，也期待您在獲取知識之後，為後人解答更多疑惑，教學相長，在精進技術的路上我們一同努力！",
    "url": "https://forum.angular.tw/"
});
data.SideNav.push({
    "title": "官方 Material 元件庫",
    "tooltip": "Angular Material 元件庫的中文文件",
    "url": "https://material.angular.cn"
});
data.SideNav.push({
    "title": "ng-zorro 元件庫",
    "tooltip": "Ant Design 的 Angular 實現，服務於企業級後臺產品。",
    "url": "https://ng.ant.design/"
});
data.SideNav.push({
    "title": "ng-zorro mobile 元件庫",
    "tooltip": "Ant Design Mobile 的 Angular 實現，服務於無線產品。",
    "url": "https://ng.mobile.ant.design/"
});
data.SideNav.push({
    "url": "https://flutter-io.cn/",
    "tooltip": "Flutter 中文文件站",
    "title": "友站：Flutter 中文"
});
data.SideNav.push({
    "title": "Angular Taiwan 2018",
    "tooltip": "台灣首屆 Angular 技術大會",
    "url": "https://2018.angular.tw/"
});

// console.log(data);
// console.log(JSON.stringify(data));

fs.writeFile("generated/navigation.json", JSON.stringify(data), function(err) {
    if(err) {
        return console.log(err);
    }
});
