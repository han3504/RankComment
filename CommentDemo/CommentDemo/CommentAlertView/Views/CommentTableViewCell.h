//
//  CommentTableViewCell.h
//  Technology
//
//  Created by admin on 2021/3/4.
//

#import <UIKit/UIKit.h>
#import "CommentItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol CommentTableViewCellDelegate <NSObject>
@optional
//一级
- (void)commentShowShareIndex:(NSInteger)index;
- (void)commentZanIndex:(NSInteger)index;
- (void)commentReplyIndex:(NSInteger)index;
//二级
- (void)commentShowShareIndex:(NSInteger)index rankIndex:(NSInteger)randIndex;
- (void)commentZanIndex:(NSInteger)index rankIndex:(NSInteger)randIndex;
- (void)commentReplyIndex:(NSInteger)index rankIndex:(NSInteger)randIndex;

@end

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic, weak) id<CommentTableViewCellDelegate>delegate;

@property (nonatomic,strong) CommentItemModel *itemModel;
@property (nonatomic,assign) NSInteger indexPath;

@end

NS_ASSUME_NONNULL_END
