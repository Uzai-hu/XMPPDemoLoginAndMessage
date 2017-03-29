//
//  FriendsTableViewController.h
//  XMPPDemo
//
//  Created by hzy on 2016/9/29.
//  Copyright © 2016年 hzy. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "XMPPManager.h"
#import "RootViewController.h"
@interface FriendsTableViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong)NSArray *friendsArray;
@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNav];
    
    [self initFriendsTools];
    
}

- (void)initFriendsTools{
    __weak typeof(self) ws=self;
    self.friendsArray = [XMPPManager defaultManager].xmppRosterMemoryStorage.unsortedUsers;
    [self.tableView reloadData];
    
    
    [[XMPPManager defaultManager] initXmppRosterAndFriends:^(NSMutableArray *x) {
        
        ws.friendsArray = x;
        [ws.tableView reloadData];
    }];
    
    
}

- (void)initNav{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"添加好友"] style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem=item;
    
}

- (void)click{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加好友" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *tf=[alertView textFieldAtIndex:0];//获得输入框
        NSString * str = tf.text;
        if (str.length) {
            [[XMPPManager defaultManager] addFriend:[XMPPJID jidWithUser:str domain:SERVICE_NAME resource:@"iPhone"]];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        }
    }


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Photos";
    
    /** NOTE: This method can return nil so you need to account for that in code */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // NOTE: Add some code like this to create a new cell if there are none to reuse
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    XMPPUserMemoryStorageObject *user = self.friendsArray[indexPath.row];
    
    cell.textLabel.text = user.jid.user;
    
    
    if ([user isOnline]) {
        cell.detailTextLabel.text = @"[在线]";
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        cell.detailTextLabel.text = @"[离线]";
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.textLabel.textColor = [UIColor grayColor];
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XMPPUserMemoryStorageObject *user = self.friendsArray[indexPath.row];
    
    RootViewController *root = [RootViewController new];
    root.user = user;
    
    [self.navigationController pushViewController:root animated:YES];
}


@end
