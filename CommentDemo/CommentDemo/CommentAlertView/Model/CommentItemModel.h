//
//  CommentItemModel.h
//  Technology
//
//  Created by admin on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CommentItemModel <NSObject>
@end

@interface CommentItemModel : NSObject
@property (nonatomic,copy) NSString* img;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* time;
@property (nonatomic,copy) NSString* zan;
@property (nonatomic,copy) NSString* zanCount;
@property (nonatomic,copy) NSString* replyName;
@property (nonatomic,strong) NSMutableArray* itemArray;

@end

NS_ASSUME_NONNULL_END
