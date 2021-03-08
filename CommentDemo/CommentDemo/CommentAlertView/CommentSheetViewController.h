//
//  CommentSheetViewController.h
//  Technology
//
//  Created by admin on 2021/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CommentSheetViewControllerDelegate <NSObject>

- (void)hideCommentAlertView;

@end

@interface CommentSheetViewController : UIViewController

+ (CommentSheetViewController *)commentSheetViewControllerArrayData:(NSMutableArray *)data;
@property (nonatomic, weak) id<CommentSheetViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
