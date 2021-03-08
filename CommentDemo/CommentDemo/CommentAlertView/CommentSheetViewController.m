//
//  CommentSheetViewController.m
//  Technology
//
//  Created by admin on 2021/3/4.
//

#import "CommentSheetViewController.h"
#import "CommentTableViewCell.h"
#import "CommentItemModel.h"

static NSString * k_CommentTableViewCell = @"CommentTableViewCell";

@interface CommentSheetViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CommentTableViewCellDelegate>

@property (nonatomic,strong) UIView *layerView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UITableView *aTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIView *funeView;
@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) UITextField *commentTextField;

@end

@implementation CommentSheetViewController

+ (CommentSheetViewController *)commentSheetViewControllerArrayData:(NSMutableArray *)data
{
    CommentSheetViewController *vc = [CommentSheetViewController alloc];
    vc.dataArray = data;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return vc;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyBoardWillShow:(NSNotification *)note
{
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    
    self.bgView.sd_layout.bottomSpaceToView(self.view, keyBoardHeight);
    [self.bgView updateLayout];
}
//键盘收起
- (void)keyBoardWillHide:(NSNotification *)note{
    self.bgView.sd_layout.bottomSpaceToView(self.view, safeAreaBottonpHeight);
    [self.bgView updateLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
   
    
    [self initAdditionalControl];
    
}

- (void)initAdditionalControl
{
    [self.view addSubview:self.layerView];
    self.layerView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, StatusBarHeight+NavigationBarHeight).bottomSpaceToView(self.view, safeAreaBottonpHeight);
    
    [self.view addSubview:self.bgView];
    self.bgView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, StatusBarHeight+NavigationBarHeight+25).bottomSpaceToView(self.view, safeAreaBottonpHeight);
    
    [self.bgView addSubview:self.funeView];
    self.funeView.sd_layout.topSpaceToView(self.bgView, 0).leftEqualToView(self.bgView).rightEqualToView(self.bgView).heightIs(50);
    
    UILabel *funLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    funLabel.font = FONT(16);
    funLabel.textColor = [UIColor colorWithHexString:APP_Text_Color];
    funLabel.text = @"评论";
    funLabel.textAlignment = NSTextAlignmentCenter;
    [self.funeView addSubview:funLabel];
    funLabel.sd_layout .centerYEqualToView(self.funeView).centerXEqualToView(self.funeView).widthIs(80).heightIs(22);
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.funeView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(didSelectCloseAction) forControlEvents:UIControlEventTouchUpInside];
    closeButton.sd_layout.centerYEqualToView(self.funeView).rightSpaceToView(self.funeView, 20).widthIs(28).heightIs(28);
    
    UIImageView *closeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [closeImageView setImage:IMG(@"comment_close")];
    [closeButton addSubview:closeImageView];
    closeImageView.sd_layout.centerYEqualToView(closeButton).centerXEqualToView(closeButton).widthIs(14).heightIs(14);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor colorWithHexString:APP_Line_Color];
    [self.funeView addSubview:lineView];
    lineView.sd_layout.leftSpaceToView(self.funeView, 20).rightSpaceToView(self.funeView, 20).bottomEqualToView(self.funeView).heightIs(1);
    
    [self.bgView addSubview:self.commentView];
    self.commentView.sd_layout.leftSpaceToView(self.bgView, 0.0f).rightSpaceToView(self.bgView, 0.0f).bottomSpaceToView(self.bgView, 0).heightIs(62);
    
    UIView *comView = [[UIView alloc] initWithFrame:CGRectZero];
    comView.backgroundColor = [UIColor colorWithHexString:APP_Line_Color];
    comView.layer.cornerRadius = 13;
    [self.commentView addSubview:comView];
    comView.sd_layout.leftSpaceToView(self.commentView, 20).rightSpaceToView(self.commentView, 20).centerYEqualToView(self.commentView).heightIs(27);
    
    [comView addSubview:self.commentTextField];
    self.commentTextField.sd_layout.leftSpaceToView(comView, 18).rightSpaceToView(comView, 10).heightIs(27);
    
    [self.bgView addSubview:self.aTableView];
    self.aTableView.sd_layout.topSpaceToView(self.funeView, 0).bottomSpaceToView(self.bgView, 62).leftEqualToView(self.bgView).rightEqualToView(self.bgView);
}

- (void)didSelectCloseAction
{
    WS(weakSelf);
    [self dismissViewControllerAnimated:NO completion:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(hideCommentAlertView)]) {
            [weakSelf.delegate hideCommentAlertView];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - 1级评论
- (void)commentShowShareIndex:(NSInteger)index
{
    NSLog(@"分享%zd第几行",index);
}

- (void)commentZanIndex:(NSInteger)index
{
    NSLog(@"赞第%zd几行",index);
}

- (void)commentReplyIndex:(NSInteger)index
{
    NSLog(@"回复第%zd几行",index);
}

#pragma mark - 2级评论
- (void)commentShowShareIndex:(NSInteger)index rankIndex:(NSInteger)randIndex
{
    NSLog(@"分享1级第%zd几行-2级第%zd几行",index,randIndex);
}

- (void)commentZanIndex:(NSInteger)index rankIndex:(NSInteger)randIndex
{
    NSLog(@"赞1级第%zd几行-2级第%zd几行",index,randIndex);
}

- (void)commentReplyIndex:(NSInteger)index rankIndex:(NSInteger)randIndex
{
    NSLog(@"回复1级第%zd几行-2级第%zd几行",index,randIndex);
}

#pragma mark - tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [self createCommentCell:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentItemModel *itemModel = self.dataArray[indexPath.row];
    return  [tableView cellHeightForIndexPath:indexPath model:itemModel keyPath:@"itemModel" cellClass:[CommentTableViewCell class] contentViewWidth:screenWidth];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)createCommentCell:(NSIndexPath *)indexPath
{
    CommentItemModel *itemModel = self.dataArray[indexPath.row];

    CommentTableViewCell *cell = (CommentTableViewCell *)[self.aTableView dequeueReusableCellWithIdentifier:k_CommentTableViewCell];
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:k_CommentTableViewCell];
    }
    cell.delegate = self;
    cell.itemModel = itemModel;
    cell.indexPath = indexPath.row;
    return cell;
}


#pragma mark - getter and setter
- (UITableView *)aTableView
{
    if (!_aTableView) {
        _aTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _aTableView.dataSource = self;
        _aTableView.delegate = self;
        _aTableView.showsVerticalScrollIndicator = NO;
        _aTableView.showsHorizontalScrollIndicator = NO;
        _aTableView.separatorStyle = NO;
        _aTableView.backgroundColor = [UIColor whiteColor];

        _aTableView.sectionFooterHeight = 0;
        _aTableView.sectionHeaderHeight = 0;
        
        UIView *headView = [[UIView alloc] init];
        headView.height = CGFLOAT_MIN;
        _aTableView.tableHeaderView = headView;
        UIView *footView = [[UIView alloc] init];
        footView.height = CGFLOAT_MIN;
        _aTableView.tableFooterView = footView;
        
    }
    return _aTableView;
    
}

- (NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIView *)layerView
{
    if (!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectZero];
        _layerView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        _layerView.alpha = 0.5;
    }
    return _layerView;
}

- (UIView *)funeView
{
    if (!_funeView) {
        _funeView = [[UIView alloc] initWithFrame:CGRectZero];
        _funeView.backgroundColor = [UIColor whiteColor];
    }
    return _funeView;
}

- (UIView *)commentView
{
    if (!_commentView) {
        _commentView = [[UIView alloc] initWithFrame:CGRectZero];
        _commentView.backgroundColor = [UIColor whiteColor];
    }
    return _commentView;
}

- (UITextField *)commentTextField
{
    if (!_commentTextField) {
        _commentTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _commentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _commentTextField.textColor = [UIColor colorWithHexString:APP_Text_Color];
        _commentTextField.returnKeyType = UIReturnKeyDone;
        _commentTextField.font = FONT(12);
        _commentTextField.placeholder = @"说点什么吧…";
        _commentTextField.delegate = self;
        [_commentTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_commentTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    }
    return _commentTextField;
}

@end
