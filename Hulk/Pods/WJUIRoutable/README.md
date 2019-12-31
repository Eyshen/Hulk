# WJUIRoutable

http 请求组件api

### CocoaPods 安装

```
'pod WJUIRoutable'  or  'pod WJUIRoutable/API'  'pod WJUIRoutable/Core'
```

### 要求
* ARC支持
* iOS 6.0+


### 使用方法

* 在WJConfig配置中心：

```
//WJUIRoutable在配置中心名称
WJUIRoutable : {
    defaultNavigationController:(String)默认导航控制器名称（可为空）
    routerURLformatter:(String)路由链接格式化器(可为空、插件配置)
}

```

```
//映射
[[WJUIRoutable sharedInstance] map:xxxx toController:xxxx];
[[WJUIRoutable sharedInstance] maps:xxxx toController:xxxx];
[[WJUIRoutable sharedInstance] map:xxxx toController:xxxx withOptions:xxxx];
[[WJUIRoutable sharedInstance] maps:xxxx toController:xxxx withOptions:xxxx];
[[WJUIRoutable sharedInstance] map:xxxx toCallback:xxxx];
[[WJUIRoutable sharedInstance] maps:xxxx toCallback:xxxx];
[[WJUIRoutable sharedInstance] map:xxxx toCallback:xxxx withOptions:xxxx];
[[WJUIRoutable sharedInstance] maps:xxxx toCallback:xxxx withOptions:xxxx];

//打开页面
[[WJUIRoutable sharedInstance] open:xxxx];
[[WJUIRoutable sharedInstance] open:xxxx animated:xxxx];
[[WJUIRoutable sharedInstance] open:xxxx animated:xxxx extraParams:xxxx];

//打开外部链接
[[WJUIRoutable sharedInstance] openExternal:xxxx];

```
