//
//  CommentTableViewCell.m
//  Technology
//
//  Created by admin on 2021/3/4.
//

#import "CommentReplyTableViewCell.h"
@interface CommentReplyTableViewCell()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic,strong) FSCustomButton *zanButton;
@property (nonatomic,strong) UIButton *replyButton;

@end


@implementation CommentReplyTableViewCell

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
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 15)
    .widthIs(20)
    .heightIs(20);
    
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel
    .sd_layout
    .centerYEqualToView(self.iconImageView)
    .leftSpaceToView(self.iconImageView, 16)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(20);
    
    [self.contentView addSubview:self.commentView];
    self.commentView.sd_layout
    .topSpaceToView(self.iconImageView, 1)
    .leftEqualToView(self.nameLabel)
    .rightEqualToView(self.nameLabel);
    
    [self.commentView addSubview:self.commentLabel];
    self.commentLabel.sd_layout
    .topSpaceToView(self.commentView, 6)
    .leftSpaceToView(self.commentView, 6)
    .rightSpaceToView(self.commentView, 6)
    .autoHeightRatio(0);
    
    [self.contentView addSubview:self.replyButton];
    self.replyButton.sd_layout
    .topSpaceToView(self.commentView, 10)
    .rightSpaceToView(self.contentView, 0)
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
    
}

- (void) setReplyModel:(CommentItemModel *)replyModel
{
    [self.iconImageView sd_setImageWithURL:URL(replyModel.img)];
    NSString *str = @"回复";
    NSString *nameStr = [NSString stringWithFormat:@"%@ %@ %@",replyModel.name,str,replyModel.replyName];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:nameStr];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:APP_Text_Weak_Color] range:[nameStr rangeOfString:str]];
    [text addAttribute:NSFontAttributeName value:FONT(10) range:[nameStr rangeOfString:str]];
    self.nameLabel.attributedText = text;
    
    self.commentLabel.text = replyModel.content;
    self.timeLabel.text = replyModel.time;
    [self.zanButton setTitle:replyModel.zanCount forState:UIControlStateNormal];
    if (replyModel.zan.integerValue == 1) {
        [_zanButton setImage:IMG(@"comment_zan_selected") forState:UIControlStateNormal];
    }else{
        [_zanButton setImage:IMG(@"comment_zan") forState:UIControlStateNormal];
    }
    [self.commentView setupAutoHeightWithBottomView:self.commentLabel bottomMargin:6];
    [self setupAutoHeightWithBottomView:self.timeLabel bottomMargin:5];
}


- (void)didSelectShareAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(rankCommentShowShareIndex:)]) {
        [_delegate rankCommentShowShareIndex:self.indexPath];
    }
}

- (void)didSelectZanAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(rankCommentZanIndex:)]) {
        [_delegate rankCommentZanIndex:self.indexPath];
    }
}

- (void)didSelectReplyButtonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(rankCommentReplyIndex:)]) {
        [_delegate rankCommentReplyIndex:self.indexPath];
    }
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageView.layer.cornerRadius = 10;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = FONT(12);
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
        _commentLabel.font = FONT(10);
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
        _replyButton.titleLabel.font = FONT(10);
        [_replyButton addTarget:self action:@selector(didSelectReplyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyButton;
}

@end
