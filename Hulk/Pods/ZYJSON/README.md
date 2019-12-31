# ZYJSON 

 JSON string 、 自定义对象 转换，json解析基于NSJSONSerialization，支持复杂的数据结构
 
 类型支持：NSString，NSNumber，NSArray，NSSet，NSDictionary,NSDate

### CocoaPods 安装
    pod ZYJSON

	source：https://github.com/Eyshen/ios-zy-framework-cocoapods-specs.git

### 要求
* ARC支持
* iOS 5.0+

### 使用方法

1、所有需要使用ZYJSON解析自定义类型必须实现协议 	**IZYJSONObject**


```objective-c
	

    /**
     *  Json对象协议，所有需要解析的对象必须实现此协议
     */
    @protocol IZYJSONObject <NSObject>

    /**
     *  属性到Json属性的映射
     */
    +(NSDictionary*) zyPropertyToJsonPropertyDictionary;

    /**
     *  非Json属性列表
     */
    +(NSSet*) zyNonJsonPropertys;

    /**
     *  容器属性类型
     *  key：属性名称
     *  value：类型（Class）支持NSDictionary，NSSet，NSArray   
     *  {
     *      @"users" : [UserDTO class],
     *      @"dict" : {
     *                   @"key1" : [DTOClass1 class],
     *                   @"key2" : [DTOClass2 class]
     *                }
     *  }
     */
    +(NSDictionary*) zyContainerPropertysGenericClass;

    /**
     *  日期属性Format字符串
     */
    +(NSString*) zyPropertyDateFormatString:(NSString*) property;

    /**
     *  自定义解析属性集合
     *
     *  @return 数据名称集合
     */
    +(NSSet*) zyCustomHandlePropertys;

    /**
     *  自定义处理属性（只有zyCustomHandlePropertys返回有属性需要自定义处理时才触发）
     *
     *  @param property 属性名称
     *  @param object   对应值
     */
    -(void) zyCustomHandleProperty:(NSString*) property value:(id) object;

    @end
```

2、toJson ZYJSON 中提供了两个方法 :

	+(NSData*) toJson:(id) object;

	+(NSString*) toJsonString:(id) object;


```objective-c
	
	@interface UserDTO : NSObject<IWJJSONObject>
	@property (nonatomic, copy) NSString *nick;
	@property (nonatomic, assign) int age;
	@property (nonatomic, strong) NSDate *createTime;
	@end
	
	
	1、
		UserDTO *user = [[UserDTO alloc] init];
		[user setNick:@"nicka"];
		[user setAge:25];
		[user setCreateTime:[NSDate date]];
		
		NSLog(@"%@",[ZYJSON toJsonString:user]);
	
		结果：{"nick" : "nicka","age" : 25,"createTime" : "2015-12-25T23:14:06+0800"}
		
	2、
		NSDictionary *dict = @{@"k1":@"v1",@"k2":@"v2",@"k3":@"v3"};
		
		NSLog(@"%@",[WJJSON toJsonString:dict]);
		
		结果：{"k3" : "v3","k2" : "v2","k1" : "v1"}
		
	3、
		NSArray *array = @[@"a1",@"a2",@"a3",@"a4"];
		
		NSLog(@"%@",[WJJSON toJsonString:array]);
		
		结果：["a1","a2","a3","a4"]
		
```


3、fromJson ZYJSON 提供6个方法：

	/**
	 *  按照指定类型type解析
	 */
	+(id) fromJsonString:(NSString*) jsonString type:(Class) type;
	
	/**
	 *  按照指定类型type解析
	 */
	+(id) fromJsonData:(NSData*) jsonData type:(Class)type;
	
	/**
	 *  将JSON转成集合类型
	 */
	+(id) fromJsonString:(NSString* ) jsonString groupType:(ZYJSONGroupType*) groupType;

	/**
	 *  将JSON转成集合类型
	 */
	+(id) fromJsonData:(NSData* ) jsonData groupType:(ZYJSONGroupType*) groupType;

	/**
	 *  返回NSDictionary 或者 NSArray
	 */
	+(id) fromJsonString:(NSString* ) json;
	
	/**
	 *  返回NSDictionary 或者 NSArray
	 */
	+(id) fromJsonData:(NSData*)jsonData;

```objective-c
	
	@interface UserDTO : NSObject<IWJJSONObject>
	@property (nonatomic, copy) NSString *nick;
	@property (nonatomic, assign) int age;
	@property (nonatomic, strong) NSDate *createTime;
	@end

	1、
		NSString *jsonString = @"{'nick' : 'nicka','age' : 25,'createTime' : '2015-12-25T23:14:06+0800'}";
		
		UserDTO *user = [ZYJSON fromJsonString:jsonString type:[UserDTO class]];
	
		
	2、
		NSString *jsonString = @"[
										{	'nick' : 'nicka',
											'age' : 25,
											'createTime' : '2015-12-25T23:14:06+0800'},
										{	'nick' : 'nicka',
											'age' : 25,
											'createTime' : '2015-12-25T23:14:06+0800'},
										{	'nick' : 'nicka',
											'age' : 25,
											'createTime' : '2015-12-25T23:14:06+0800'}]";
		
		NSArray *users = [ZYJSON fromJsonString:jsonString groupType:[ZYJSONGroupType createCollectionClass:[NSArray class] elementClass:[UserDTO class]]];
		
		
```
