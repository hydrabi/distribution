//
//  PersonlInfoMacro.h
//  Distribution
//
//  Created by Hydra on 16/1/12.
//  Copyright © 2016年 distribution. All rights reserved.
//

#ifndef PersonlInfoMacro_h
#define PersonlInfoMacro_h

typedef NS_ENUM(NSInteger,AVUserAttributeType) {
    AVUserAttributeType_head,
    AVUserAttributeType_age,
    AVUserAttributeType_gender,
    AVUserAttributeType_location,
    AVUserAttributeType_locationDic,
    AVUserAttributeType_contantPhone,
};

#define AVUserKey_head                   @"AVUserKey_head"                  //头像
#define AVUserKey_age                    @"AVUserKey_age"                   //年龄
#define AVUserKey_gender                 @"AVUserKey_gender"                //性别
#define AVUserKey_location               @"AVUserKey_location"              //位置
#define AVUserKey_locationDic            @"AVUserKey_locationDic"           //位置信息
#define AVUserKey_contantPhone           @"AVUserKey_contantPhone"          //联系电话
#define AVUserKey_easePassword           @"AVUserKey_easePassword"          //环信密码
#define AVUserKey_easeHadRegisterSuccess @"AVUserKey_easeHadRegisterSuccess"//环信注册已经成功
#define AVUserKey_favorite               @"AVUserKey_favorite"              //收藏
#define AVUserKey_nickname               @"AVUserKey_nickname"              //昵称
#define AVUserKey_signature              @"AVUserKey_signature"             //签名
#define AVUserKey_trace                  @"AVUserKey_trace"                 //我的足迹
#define AVUserKey_weixin                 @"AVUserKey_weixin"                //微信
#define AVUserKey_qq                     @"AVUserKey_qq"                    //qq
#define AVUserKey_modifyPassword         @"AVUserKey_modifyPassword"        //修改密码
#define AVUserKey_addressList            @"AVUserKey_adressList"            //收货地址列表
#define AVUserKey_addressConsignee       @"AVUserKey_addressConsignee"      //收货人
#define AVUserKey_addressTelephone       @"AVUserKey_addressTelephone"      //收货电话
#define AVUserKey_addressLocation        @"AVUserKey_addressLocation"       //收货地址的位置，即省，区，市等
#define AVUserKey_addressLocationDic     @"AVUserKey_addressLocationDic"    //收货地址的位置相对选择省区市的picker的位置
#define AVUserKey_addressDetail          @"AVUserKey_addressDetail"         //收货地址的详细部分，即街道，房号等

#endif /* PersonlInfoMacro_h */
