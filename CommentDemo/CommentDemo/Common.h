//
//  Common.h
//  DrivingSafety_Enterprise
//
//  Created by admin on 2018/9/5.
//  Copyright © 2018年 yaobin. All rights reserved.
//

#ifdef __OBJC__

#endif

#ifdef DEBUG
#    define DSPLog(...) NSLog(__VA_ARGS__)
#else
#    define DSPLog(...)
#endif

//FOUNDATION_EXPORT void Write_Log_To_File(NSString *format, ...);

#ifndef Common_h
#define Common_h

/*----------------------------单例定义------------------------*/
#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \
/*-----------------------------------------------------------*/


//快速格式化一个字符串
#define _S(str,...) [NSString stringWithFormat:str,##__VA_ARGS__]
#define _ST(str,...) [NSString stringWithFormat:@"%ld",(long)str,##__VA_ARGS__]
//APP名称
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
//取得指定名称的图片
#define IMG(name) [UIImage imageNamed:name]
#define FONT(font) [UIFont systemFontOfSize:font]
#define URL(url) [NSURL URLWithString:url]
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//  self弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//   强引用
#define StrongS(strongSelf)  __strong __typeof(&*self)strongSelf = self;
//判断是否为iPhone X
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define K_ScreenFrame  [[UIScreen mainScreen] bounds]
#define WINDOW                  [[[UIApplication sharedApplication] delegate] window]
#define DSP_DELEGATE          [[UIApplication sharedApplication] delegate]
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define screenHeight ([[UIScreen mainScreen] bounds].size.height)
#define screenWidth ([[UIScreen mainScreen] bounds].size.width)

// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

//状态栏高度
#define StatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
//安全高度
#define safeAreaTopHeight (IPHONE_X ? 88 : 64)
#define safeAreaBottonpHeight (IPHONE_X ? 34 : 0)
//导航栏高度
#define NavigationBarHeight 44.0f
//tabbar高度
#define TabBarHeight (IPHONE_X ? (49 + 34) : 49)

//适配
#define dev_Width(width)  ((width) * scaleW)
#define dev_Height(height)  ((height) * scaleH)
#define dev_X(x)  ((x) * scaleW)
#define dev_Y(y)  ((y) * scaleH)

#define scaleW    screenWidth/375.000000
#define scaleH (IPHONE_X ? scaleW : screenHeight/667.00)

//网络请求超时时间（秒）
#define TIMEOUTINTERVAL 10

#define ktbl_NoThing_TitleName     @"暂无数据"                      //没有数据是的文字显示
#define ktbl_Loaging_TitleName     @"加载中"                       //加载中
#define ktbl_Network_Error_TitleName     @"网络出问题了～请您查看网络设置"               //网络异常
#define ErrorPromptContent @"网络异常，请检查手机网络"
#define ErrorLoaginPromptContent @"您的账号在其他设备登录或登录超时，请重新登录"
//线的高度
#define isiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone6   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone6P   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhoneX   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhoneXS_MAX   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2668), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhoneXR   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)





/*---------------UI相关字体大小、颜色等宏定义---------------*/
// 颜色的简单构成宏
#define rgba(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define rgb(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//导航栏标题颜色
#define NAV_TITLE_TEXT_COLOR @"#333333"
//导航栏背景颜色
#define Navigation_And_StatusBar_Color @"#FFFFFF"
//导航栏返回按钮颜色
#define NAV_TEXT_COLOR              rgb(255, 255, 255)
#define NAV_TEXT_COLOR_HILIGHT      rgb(205, 205, 205)
#define NAV_Right_Button_Text_Size 16.0f
//默认view背景色
#define Background_Color @"#FFFFFF"
//底部菜单tabbar背景颜色
#define Bottom_Background_Color @"#FFFFFF"
//底部菜单tabbar按钮字体颜色，选中
#define Bottom_Text_Color @"#D43826"
//底部菜单tabbar按钮字体颜色，未选中
#define Bottom_Text_Normal_Color @"#666666"
//通用字体颜色
#define APP_Text_Color @"#333333"
#define APP_Text_Weak_Color @"#666666"
#define APP_Line_Color @"#F1F1F1"



#endif /* Common_h */
