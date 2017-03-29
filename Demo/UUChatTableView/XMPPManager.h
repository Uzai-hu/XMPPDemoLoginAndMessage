//
//  XMPPManager.h
//  myXmpp
//
//  Created by ccyy on 15/8/4.
//  Copyright (c) 2015年 hzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMPPFramework/XMPPFramework.h>
/**
 *  该类主要封装了xmpp的常用方法
 */
typedef void (^Success)();
typedef void (^Failure)(NSString *error);
typedef void (^ReceiveMessageBlock)(XMPPMessage *message);
typedef void (^Hanldles)(id x);
@interface XMPPManager : NSObject<XMPPStreamDelegate,XMPPRosterDelegate,XMPPRosterMemoryStorageDelegate>
//通信管道，输入输出流
@property(nonatomic,strong)XMPPStream *xmppStream;
//好友工具
@property(nonatomic,strong)XMPPRoster *xmppRoster;
@property(nonatomic,strong)XMPPRosterMemoryStorage *xmppRosterMemoryStorage;


@property (nonatomic,copy)ReceiveMessageBlock receiveMessageBlock;
//单例方法
+(XMPPManager *)defaultManager;
//登录的方法
-(void)loginwithName:(NSString *)userName andPassword:(NSString *)password success:(Success)success failure:(Failure)failure;
//注册
-(void)registerWithName:(NSString *)userName andPassword:(NSString *)password;
-(void)logout;



//初始化朋友部分
-(void)initXmppRosterAndFriends:(Hanldles )hanldles;


- (void)addFriend:(XMPPJID *)aJID;
@end
