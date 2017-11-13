//
//  wanshanziliaoViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/18.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "wanshanziliaoViewController.h"
#import "textfieldCell.h"
#import "infophotoCell.h"
#import "zhiyeViewController.h"
#import "addressViewController.h"
@interface wanshanziliaoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong)UIView *backV;
@property (nonatomic, strong)WeChatActionSheet *sheetv;
@end

@implementation wanshanziliaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";
    [self.tableview registerNib:[UINib nibWithNibName:@"textfieldCell" bundle:nil] forCellReuseIdentifier:@"textfield"];
    [self.tableview registerNib:[UINib nibWithNibName:@"infophotoCell" bundle:nil] forCellReuseIdentifier:@"photo"];
    [self settinghead];
}
- (void)settinghead
{
    UIView *headv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    headv.backgroundColor = [UIColor grayColor];
    self.tableview.tableHeaderView = headv;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4) {
        textfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textfield" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.textf.placeholder = @"请填写姓名";
            cell.leftlab.text = @"姓名";
        } else if (indexPath.row == 2){
            cell.textf.placeholder = @"请填写身份证号";
            cell.leftlab.text = @"身份证";
        } else if (indexPath.row == 4){
            cell.textf.placeholder = @"请填写第二联系人";
            cell.leftlab.text = @"第二联系人";
        }
        return cell;
    } else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5){
        static NSString *str = @"fengfeng";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = H14;
        cell.detailTextLabel.font = H14;
        if (indexPath.row == 1) {
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = @"男";
        } else if (indexPath.row == 3){
            cell.textLabel.text = @"现居地";
            cell.detailTextLabel.text = @"南山大道";
        } else if (indexPath.row == 5){
            cell.textLabel.text = @"职业";
            cell.detailTextLabel.text = @"专车司机";
        }
        return cell;
    } else {
        infophotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photo" forIndexPath:indexPath];
        if (indexPath.row == 6) {
            cell.titlelab.text = @"个人形象照片";
        } else if (indexPath.row == 7){
            cell.titlelab.text = @"手持身份证照片";
        } else if (indexPath.row == 8){
            cell.titlelab.text = @"身份证正面";
        } else {
            cell.titlelab.text = @"身份证背面";
        }
        cell.photobtn.tag = indexPath.row + 100;
        cell.photobtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.photobtn addTarget:self action:@selector(photobtnaction:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
}
- (void)photobtnaction:(UIButton *)sender
{
    infophotoCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag - 100 inSection:0]];
    [[PhotoPickerManager sharedManager] getImageInView:self successBlock:^(UIImage *image) {
        [cell.photobtn setImage:image forState:(UIControlStateNormal)];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 6) {
        return 45;
    } else {
        return 250;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        self.sheetv = [WeChatActionSheet showActionSheet:@"选择性别" buttonTitles:@[@"男",@"女"]];
        [self.sheetv setFunction:^(WeChatActionSheet *actionSheet,NSInteger index)
         {
             if (index == WECHATCANCELINDEX)
             {
                 NSLog(@"点击了取消按钮");
             }
             else
             {
                 NSLog(@"按钮的Index为%@",@(index));
             }
         }];
    } else if (indexPath.row == 5){
        zhiyeViewController *zhiye = [zhiyeViewController new];
        [self.navigationController pushViewController:zhiye animated:YES];
    } else if (indexPath.row == 3){
        addressViewController *address = [addressViewController new];
        [self.navigationController pushViewController:address animated:YES];
    }
}
@end
