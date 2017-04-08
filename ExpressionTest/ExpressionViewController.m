//
//  ExpressionViewController.m
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/6.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "ExpressionViewController.h"
#import "EmoticonKeyBoardView.h"
#import "MLLabel.h"
@interface ExpressionViewController ()<EmoticonListViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) EmoticonKeyBoardView *listview;
@property (nonatomic, strong)  MLLabel *label;
@end

@implementation ExpressionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    MLLabel *label = [[MLLabel alloc] initWithFrame:CGRectMake(10, 0, self.view.width_dfl, 100)];
    self.label = label;
    self.label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
    self.listview = [[EmoticonKeyBoardView alloc] initWithFrame:CGRectMake(0,  self.view.height_dfl - 64 - ([EmoticonListView EmoticonListViewHeight] + 40), self.view.width_dfl, [EmoticonListView EmoticonListViewHeight] + 40)];
    self.listview.backgroundColor = [UIColor orangeColor];
    self.listview.listView.delegate = self;
    [self.view addSubview:self.listview];
}


-(void)listView:(EmoticonListView *)listView didClickButton:(EmoticonModel *)model{
    NSLog(@"%@",model.chs);

    NSAttributedString *att = [EmoticonManager emticonAttributedStringWithString:[NSString stringWithFormat:@"%@你好你安定%@你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定你安定",model.chs,model.chs]];
    self.label.attributedText = att;
    CGSize size = [self.label preferredSizeWithMaxWidth:self.view.width_dfl - 10];
    self.label.size_dfl = size;
   
    
}


@end
