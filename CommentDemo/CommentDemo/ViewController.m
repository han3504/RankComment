//
//  ViewController.m
//  CommentDemo
//
//  Created by admin on 2021/3/8.
//

#import "ViewController.h"
#import "CommentItemModel.h"
#import "CommentSheetViewController.h"
@interface ViewController ()<CommentSheetViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
        模拟数据
     */

    
    CommentItemModel *model = [[CommentItemModel alloc] init];
    model.img  = @"https://eimg.smzdm.com/202102/26/60384d26130519119.png";
    model.name = @"我是用户名A";
    model.content = @"我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论…";
    model.time = @"30秒前";
    model.zan = @"2";
    model.zanCount = @"520";
    [self.dataArray addObject:model];
    
        /* 第二层 */
    CommentItemModel *item1 = [[CommentItemModel alloc] init];
    item1.img  = @"https://res.smzdm.com/pc/pc_haojia/dist/img/avatar.png";
    item1.name = @"我是哈哈哈A";
    item1.content = @"我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论…";
    item1.time = @"20秒前";
    item1.zan = @"2";
    item1.zanCount = @"52";
    item1.replyName = @"我是小A";
    
    CommentItemModel *item2 = [[CommentItemModel alloc] init];
    item2.img  = @"https://res.smzdm.com/pc/pc_haojia/dist/img/avatar.png";
    item2.name = @"我是哈哈哈B";
    item2.content = @"我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论…";
    item2.time = @"20秒前";
    item2.zan = @"1";
    item2.zanCount = @"20";
    item2.replyName = @"我是小B";
    
    CommentItemModel *item3 = [[CommentItemModel alloc] init];
    item3.img  = @"https://res.smzdm.com/pc/pc_haojia/dist/img/avatar.png";
    item3.name = @"我是哈哈哈C";
    item3.content = @"我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论是一个评论我是一个评论我是我是我是我是…";
    item3.time = @"20秒前";
    item3.zan = @"2";
    item3.zanCount = @"50";
    item3.replyName = @"我是小C";
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:item1];
    [array addObject:item2];
    [array addObject:item3];

    CommentItemModel *model2 = [[CommentItemModel alloc] init];
    model2.img  = @"https://eimg.smzdm.com/202102/26/60384d26130519119.png";
    model2.name = @"我是用户名B";
    model2.content = @"我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论…";
    model2.time = @"30秒前";
    model2.zan = @"2";
    model2.zanCount = @"52";
    model2.itemArray = array;
    [self.dataArray addObject:model2];
    
    CommentItemModel *model3 = [[CommentItemModel alloc] init];
    model3.img  = @"https://eimg.smzdm.com/202102/26/60384d26130519119.png";
    model3.name = @"我是用户名C";
    model3.content = @"我是一个评论我是一个评论我是一个评论我是一个评论我是一个评论啊啥的啊啥的啊啥的啊啥的啊实打实的爱上大叔的啊啥的啊啥的爱上撒…";
    model3.time = @"30秒前";
    model3.zan = @"1";
    model3.zanCount = @"300";
    [self.dataArray addObject:model3];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 200);
    [btn setTitle:@"点我出评论" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didSelectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
}

- (void)didSelectBtnAction
{
    CommentSheetViewController *sheetVC = [CommentSheetViewController commentSheetViewControllerArrayData:self.dataArray];
    sheetVC.delegate = self;
    [self presentViewController:sheetVC animated:NO completion:nil];
}

- (void)hideCommentAlertView
{
    
}

- (NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
