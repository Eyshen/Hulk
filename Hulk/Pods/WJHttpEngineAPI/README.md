# WJHttpEngineAPI

http 请求组件api

### CocoaPods 安装

```
pod WJHttpEngineAPI
```

### 要求
* ARC支持
* iOS 6.0+


### 使用方法

* 在WJConfig配置中心：

```
//WJHttpEngineAPI在配置中心名称
WJHttpEngineAPI : {
	timeoutDuration : (int)默认超时时长
	defaultEngineName : （String）默认引擎名称
	networkActivityEnabled：（bool）请求时是否默认打开状态栏网络活跃标识
	allowInvalidCertificates:(bool)是否允许无效证书
	filters:(Array<String>)过滤器，必须实现协议IWJHttpFilter
	cers:(Array<String>)证书列表
}

```
