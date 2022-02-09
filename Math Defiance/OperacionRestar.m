#import "OperacionRestar.h"

@implementation OperacionRestar

- (NSInteger) calcular {
    return [self operando1] - [self operando2];
}

- (NSString *) tipoCalculo {
    return @"-";
}

@end
