//
//  PersonalNicknameAndSignatureMacro.h
//  Distribution
//
//  Created by Hydra on 16/1/29.
//  Copyright © 2016年 distribution. All rights reserved.
//

/**输入类型，昵称还是签名*/
typedef NS_ENUM(NSInteger,PersonalInputAttributeType) {
    PersonalInputAttributeType_nickname,
    PersonalInputAttributeType_signature,
};

#define maxNicknameLength 10        //昵称长度最大值
#define maxSignatureLength 20       //签名长度最大值