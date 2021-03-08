//
//  CommentTableViewCell.m
//  Technology
//
//  Created by admin on 2021/3/4.
//

#import "CommentTableViewCell.h"
#import "CommentReplyTableViewCell.h"

static NSString * k_CommentReplyTableViewCell = @"CommentReplyTableViewCell";

@interface CommentTableViewCell()<UITableViewDelegate,UITableViewDataSource,CommentReplyTableViewCellDelegate>

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic,strong) FSCustomButton *zanButton;
@property (nonatomic,strong) UIButton *replyButton;

@property (nonatomic,strong) UITableView *aTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end


@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setup];
        
    }
    return self;
}

- (void)setup
{
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .topSpaceToView(self.contentView, 15)
    .widthIs(34)
    .heightIs(34);
    
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel
    .sd_layout
    .centerYEqualToView(self.iconImageView)
    .leftSpaceToView(self.iconImageView, 16)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(20);
    
    [self.contentView addSubview:self.commentView];
    self.commentView.sd_layout
    .topSpaceToView(self.iconImageView, 1)
    .leftEqualToView(self.nameLabel)
    .rightEqualToView(self.nameLabel);
    
    [self.commentView addSubview:self.commentLabel];
    self.commentLabel.sd_layout
    .topSpaceToView(self.commentView, 8)
    .leftSpaceToView(self.commentView, 8)
    .rightSpaceToView(self.commentView, 8)
    .autoHeightRatio(0);
    
    [self.contentView addSubview:self.replyButton];
    self.replyButton.sd_layout
    .topSpaceToView(self.commentView, 10)
    .rightSpaceToView(self.contentView, 30)
    .widthIs(25)
    .heightIs(16);
    
    [self.contentView addSubview:self.zanButton];
    self.zanButton.sd_layout
    .topEqualToView(self.replyButton)
    .rightSpaceToView(self.replyButton, 20)
    .widthIs(40)
    .heightIs(16);
    
    [self.contentView addSubview:self.shareButton];
    self.shareButton.sd_layout
    .topEqualToView(self.zanButton)
    .rightSpaceToView(self.zanButton, 20)
    .widthIs(40)
    .heightIs(16);
    
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.sd_layout
    .topSpaceToView(self.commentView, 10)
    .leftEqualToView(self.nameLabel)
    .rightSpaceToView(self.shareButton, 20)
    .heightIs(14);
    
    [self.contentView addSubview:self.aTableView];
    self.aTableView.hidden = YES;
    self.aTableView.sd_layout
    .topSpaceToView(self.timeLabel, 14)
    .leftSpaceToView(self.contentView, 80)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(0);
}

- (void) setItemModel:(CommentItemModel *)itemModel
{
    self.aTableView.hidden = YES;
    self.aTableView.sd_layout.heightIs(0);
    [self.dataArray removeAllObjects];
    [self.iconImageView sd_setImageWithURL:URL(itemModel.img)];
    self.nameLabel.text = itemModel.name;
    self.commentLabel.text = itemModel.content;
    self.timeLabel.text = itemModel.time;
    [self.zanButton setTitle:itemModel.zanCount forState:UIControlStateNormal];
    if (itemModel.zan.integerValue == 1) {
        [_zanButton setImage:IMG(@"comment_zan_selected") forState:UIControlStateNormal];
    }else{
        [_zanButton setImage:IMG(@"comment_zan") forState:UIControlStateNormal];
    }
    [self.commentView setupAutoHeightWithBottomView:self.commentLabel bottomMargin:8];
    [self setupAutoHeightWithBottomView:self.timeLabel bottomMargin:5];
    
    if (itemModel.itemArray.count > 0) {
        [self.dataArray addObjectsFromArray:itemModel.itemArray];
        self.aTableView.hidden = NO;
        self.aTableView.sd_layout.heightIs(200);
        [self setupAutoHeightWithBottomView:self.aTableView bottomMargin:5];
    }
   
}

- (void)didSelectShareAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(commentShowShareIndex:)]) {
        [_delegate commentShowShareIndex:self.indexPath];
    }
}

- (void)didSelectZanAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(commentZanIndex:)]) {
        [_delegate commentZanIndex:self.indexPath];
    }
}

- (void)didSelectReplyButtonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(commentReplyIndex:)]) {
        [_delegate commentReplyIndex:self.indexPath];
    }
}



#pragma mark - 二级
- (void)rankCommentShowShareIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(commentShowShareIndex:rankIndex:)]) {
        [_delegate commentShowShareIndex:self.indexPath rankIndex:index];
    }
}

- (void)rankCommentZanIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(commentZanIndex:rankIndex:)]) {
        [_delegate commentZanIndex:self.indexPath rankIndex:index];
    }
}

- (void)rankCommentReplyIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(commentReplyIndex:rankIndex:)]) {
        [_delegate commentReplyIndex:self.indexPath rankIndex:index];
    }
}

#pragma mark - tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [self createCommentReplyCell:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentReplyTableViewCell *itemModel = self.dataArray[indexPath.row];
    return  [tableView cellHeightForIndexPath:indexPath model:itemModel keyPath:@"replyModel" cellClass:[CommentReplyTableViewCell class] contentViewWidth:screenWidth - dev_Width(113)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)createCommentReplyCell:(NSIndexPath *)indexPath
{
    CommentItemModel *replyModel = self.dataArray[indexPath.row];

    CommentReplyTableViewCell *cell = (CommentReplyTableViewCell *)[self.aTableView dequeueReusableCellWithIdentifier:k_CommentReplyTableViewCell];
    if (cell == nil) {
        cell = [[CommentReplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:k_CommentReplyTableViewCell];
    }
    cell.delegate = self;
    cell.replyModel = replyModel;
    cell.indexPath = indexPath.row;
    
    return cell;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageView.layer.cornerRadius = 17;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = FONT(14);
        _nameLabel.textColor = [UIColor colorWithHexString:APP_Text_Color];
    }
    return _nameLabel;
}

- (UIView *)commentView
{
    if (!_commentView) {
        _commentView = [[UIView alloc] initWithFrame:CGRectZero];
        _commentView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _commentView.layer.cornerRadius = 4;
    }
    return _commentView;
}

- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.font = FONT(12);
        _commentLabel.textColor = [UIColor colorWithHexString:APP_Text_Color];
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = FONT(10);
        _timeLabel.textColor = [UIColor colorWithHexString:APP_Text_Weak_Color];
    }
    return _timeLabel;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:IMG(@"comment_share") forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(didSelectShareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (FSCustomButton *)zanButton
{
    if (!_zanButton) {
        _zanButton = [[FSCustomButton alloc] initWithFrame:CGRectZero];
        _zanButton.buttonImagePosition = FSCustomButtonImagePositionLeft;
        _zanButton.titleLabel.font = FONT(10);
        [_zanButton setTitleColor:[UIColor colorWithHexString:APP_Text_Color] forState:UIControlStateNormal];
        [_zanButton setImage:IMG(@"comment_zan") forState:UIControlStateNormal];
        _zanButton.imageEdgeInsets  =UIEdgeInsetsMake(0,0,0,7);
        _zanButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _zanButton.backgroundColor = [UIColor whiteColor];
        [_zanButton addTarget:self action:@selector(didSelectZanAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _zanButton;
}

- (UIButton *)replyButton
{
    if (!_replyButton) {
        _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        [_replyButton setTitleColor:[UIColor colorWithHexString:APP_Text_Color] forState:UIControlStateNormal];
        _replyButton.titleLabel.font = FONT(11);
        [_replyButton addTarget:self action:@selector(didSelectReplyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyButton;
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
@end
