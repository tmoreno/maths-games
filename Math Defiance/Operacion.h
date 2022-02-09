@interface Operacion : NSObject

@property (nonatomic) NSInteger operando1;
@property (nonatomic) NSInteger operando2;

- (id) initOperacionWith:(NSInteger) unOperando1
               operando2:(NSInteger) unOperando2;
@end

@protocol Calculo

- (NSInteger) calcular;
- (NSString *) tipoCalculo;

@end
