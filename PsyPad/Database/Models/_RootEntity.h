// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RootEntity.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface RootEntityID : NSManagedObjectID {}
@end

@interface _RootEntity : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RootEntityID *objectID;

@property (nonatomic, strong, nullable) NSString* admin_password;

@property (nonatomic, strong, nullable) NSString* authToken;

@property (nonatomic, strong) NSNumber* demoMode;

@property (atomic) BOOL demoModeValue;
- (BOOL)demoModeValue;
- (void)setDemoModeValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* email;

@property (nonatomic, strong) NSString* server_url;

@end

@interface _RootEntity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAdmin_password;
- (void)setPrimitiveAdmin_password:(NSString*)value;

- (NSString*)primitiveAuthToken;
- (void)setPrimitiveAuthToken:(NSString*)value;

- (NSNumber*)primitiveDemoMode;
- (void)setPrimitiveDemoMode:(NSNumber*)value;

- (BOOL)primitiveDemoModeValue;
- (void)setPrimitiveDemoModeValue:(BOOL)value_;

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitiveServer_url;
- (void)setPrimitiveServer_url:(NSString*)value;

@end

@interface RootEntityAttributes: NSObject 
+ (NSString *)admin_password;
+ (NSString *)authToken;
+ (NSString *)demoMode;
+ (NSString *)email;
+ (NSString *)server_url;
@end

NS_ASSUME_NONNULL_END
