# WJWebViewJavascriptBridge

 web native 交互组件

### CocoaPods 安装

```
	pod  WJWebViewJavascriptBridge
```

### 要求
* ARC支持
* iOS 5.0+


### 使用方法

* 在WJConfig配置中心：

```
	//WJWebViewJavascriptBridge在配置中心名称
	WJWebViewJavascriptBridge : {
		//模块列表
		allowHosts : ['www.baidu.net', 'www.jucaicat.com', ...],
		//回话数据格式化程序
		allowSchemes : ['jucaicat', 'jucaicatapp', ...],
        //是否开启主机验证(default YES)
        enabledHostVerify : YES
	}

```
