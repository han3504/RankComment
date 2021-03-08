//
//  CommentReplyTableViewCell.h
//  Technology
//
//  Created by admin on 2021/3/4.
//

#import <UIKit/UIKit.h>
#import "CommentItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CommentReplyTableViewCellDelegate <NSObject>
@optional
- (void)rankCommentShowShareIndex:(NSInteger)index;
- (void)rankCommentZanIndex:(NSInteger)index;
- (void)rankCommentReplyIndex:(NSInteger)index;


@end

@interface CommentReplyTableViewCell : UITableViewCell
@property (nonatomic, weak) id<CommentReplyTableViewCellDelegate>delegate;

@property (nonatomic,strong) CommentItemModel *replyModel;
@property (nonatomic,assign) NSInteger indexPath;


@end

NS_ASSUME_NONNULL_END
