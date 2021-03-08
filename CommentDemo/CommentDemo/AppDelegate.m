//
//  AppDelegate.m
//  CommentDemo
//
//  Created by admin on 2021/3/8.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *v = [[ViewController alloc] init];
        
    self.window.rootViewController = v;

    [self.window makeKeyAndVisible];

    return YES;
}



@end
