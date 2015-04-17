// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RootEntity.h instead.

@import CoreData;

extern const struct RootEntityAttributes {
	__unsafe_unretained NSString *admin_password;
	__unsafe_unretained NSString *authToken;
	__unsafe_unretained NSString *demoMode;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *server_url;
} RootEntityAttributes;

@interface RootEntityID : NSManagedObjectID {}
@end

@interface _RootEntity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RootEntityID* objectID;

@property (nonatomic, strong) NSString* admin_password;

//- (BOOL)validateAdmin_password:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* authToken;

//- (BOOL)validateAuthToken:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* demoMode;

@property (atomic) BOOL demoModeValue;
- (BOOL)demoModeValue;
- (void)setDemoModeValue:(BOOL)value_;

//- (BOOL)validateDemoMode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* server_url;

//- (BOOL)validateServer_url:(id*)value_ error:(NSError**)error_;

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
