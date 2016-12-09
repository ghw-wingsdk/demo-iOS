//
//  GhwSdkIap.h
//  iOSInAppPurchases
//
//  Created by GHW-T-01 on 15/5/18.
//
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>

extern NSString * const IAPResultNotification;


@interface WAAPIapSingleton : NSObject
@property(nonatomic,weak)id<WAInventoryDelegate>inventoryDelegate;
@property(nonatomic,weak)id<WAPaymentDelegate>paymentDelegate;
@property(nonatomic,strong) NSArray* productIds;
@property(nonatomic,strong) NSMutableArray *products;
@property(nonatomic,strong) SKProduct* currentProduct;
@property(nonatomic,strong) NSData* currentReceipt;
@property(nonatomic,strong)NSMutableArray* productList;//存放SKProduct;
@property(nonatomic,strong)NSString* productId;
@property(nonatomic,strong)NSString* extInfo;
@property(nonatomic,assign)BOOL isPaying;
@property(nonatomic,strong)NSDictionary *waProducts;

/**
 *  应用内支付初始化
 *
 */
+(void)init4Iap;

/**
 *  清理商品内购相关变量
 */
+(void)clean4Iap;

/**
 *  获取单例
 *
 *  @return 返回单例
 */
+(WAAPIapSingleton *)shareInstance;

///**
// *  获取商品列表
// */
//+(void)queryInventory:(id<WAInventoryDelegate>)delegate;

/**
 *  单个商品购买
 *
 *  @param product 对应苹果商品类
 *  @param serverId服务器id
 *  @param extInfo一些额外信息
 */
+(void)singlePurchase:(SKProduct*)product withServerId:(NSString*)serverId withExtInfo:(NSString*)extInfo;
/**
 *  单个商品购买
 *
 *  @param productId 对应苹果商品id
 *  @param extInfo一些额外信息
 */
+(void)payWithProductId:(NSString *)productId extInfo:(NSString *)extInfo delegate:(id<WAPaymentDelegate>)delegate;

+(void)fetchProductInformations:(NSDictionary *)waProducts inventoryDelegate:(id<WAInventoryDelegate>)delegate;

+(SKProduct*)getCurrentProduct;

+(NSData*)getCurrentReceipt;
@end
