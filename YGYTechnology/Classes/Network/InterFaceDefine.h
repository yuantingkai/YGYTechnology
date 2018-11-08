//
//  InterFaceDefine.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#ifndef InterFaceDefine_h
#define InterFaceDefine_h


#endif /* InterFaceDefine_h */
//生产url
//#define BASEURL    @"http://www.inoath.net:8080/"
//测试url
#define BASEURL    @"http://112.74.175.218:8080/"
//bendiurl
//#define BASEURL    @"http://192.168.0.138:8080/"
//请求状态
//登录
#define LOGIN_URL @"user/login?"
//验证码
#define sendCode_URL @"user/sendCode?"
//根据用户id修改密码
#define VERIFY_PWD_URL @"user/editPwd?"
//新闻资讯
#define NEWS_INFO_URL @"consult/page?"
//财富列表
#define TREASURE_GETALL_URL @"product/getAll?"
//财富支付
#define TREASURE_PAY_URL @"product/pay?"
//实名认证
#define CERTIFICATION_URL @"user/authRealInfo?"
//通过验证码修改资产密码
#define PROPERTY_PWD_URL @"user/editAssetsPwd?"
//修改用户个人信息
#define EDIT_USER_INFO_URL @"user/editUserInfo?"
//上传用户头像
#define UPLOAD_AVATAR_URL @"user/uploadAvatar?"
//查看挖矿明细
#define CHECK_DETAIL_URL @"sdtRecord/getByuid?"
//邀请挖矿 总SDT请求
#define SDT_NUM_URL @"sdtRecord/sumSdtByuid?"
//生态合伙人收益
#define ECO_PARTNER_URL @"user/getPartnerInfo?"
//获得所有云力
#define GET_CLOUD_CLAC_URL @"clac/getClac?"
//获得用户身份信息
#define GET_REAL_INFO @"user/getRealInfo?"
//获得云游所有数据
#define GET_SDT_LIST_URL @"clac/getSdtList?"
//修改云游数据
#define VERIFY_SDT_URL @"clac/updateUserSdt?"
//收益明细
#define GET_EARNING_LIST @"order/getEarningList?"
//提现明细
#define WITHDRAW_DETAILS_LIST @"order/getBtcMentionList?"
//总收益 总提现 账户余额数据呈现
#define GET_EARNING_URL @"btcRecord/getEarnings?"
//我的合约列表
#define GET_ORDER_LIST_URL @"order/getOrderList?"
//更新云力
#define UPDATE_CLOUD_CLAC_URL @"clac/updateCalc?"
//获得资产信息
#define GET_ASSET_INFO_URL @"user/getAssets?"
//资产提现
#define ASSET_WITHDRAW_URL @"btcOrder/reflect?"
//CNY提现
#define CNY_ORDER_GENERATE @"cnyOrder/generateOrder?"
//跑马灯文案
#define GET_LATEST_INFO @"scroll/getLatestInfo?"
//CNY总收益 总提现 账户余额数据呈现
#define CNY_ORDER_GET_EARNINGS @"cnyOrder/getEarnings?"
//CNY提现明细
#define CNY_ORDER_GET_CNY_MENTIONLIST @"cnyOrder/getCnyMentionList?"
//CNY收益明细
#define CNY_ORDER_GET_EARNING_LIST @"cnyOrder/getEarningList?"
//删除订单
#define DELETE_PAY_PRODUCT @"product/delpay?"
//查询用户云力流水
#define CHECK_USER_CLAC_LIST @"/clac/getCalcList?"
