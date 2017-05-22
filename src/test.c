//16^x = 2^64

#define int8_t char
#define int16_t short
#define int32_t long
#define int64_t long long
#define uint8_t unsigned char
#define uint16_t unsigned short
#define uint32_t unsigned long
#define uint64_t unsigned long long

// void strint(int n, char s[24]) {
//     int i, sign;
//     sign = n;
//     i = 0;
//     do {
//         s[i++] = abs(n % 10) + '0';
//     } while ( n /= 10 );
//     if (sign < 0)
//         s[i++] = '-';
    
//     s[i] = '\0';
//     strrev(s);
// }

void itoa10(uint64_t x, char *y);
int abs(int x);
int puts(const char *x);
int putchar(int x);
unsigned long strlcpy(char *x, const char *y, unsigned long z);
void strrev(char *x);
int memcmp(const void *x, const void *y, unsigned long z);
unsigned long strlen(const char *x);

int main()
{
	char a[17] = "Hello World!!!\n";
    char b[17];
    char c[7];
    char d[6];
    char e[24];

    // puts
    puts(a);

    // strlcpy expected length
    puts("B: ");
    strlcpy(b, a, 17);
    puts(b);
    itoa10(b, e);
    puts(e);
    putchar('\n');
    itoa10(strlen(b), e);
    puts(e);
    putchar('\n');

    // strlcpy truncated
    puts("C: ");
    strlcpy(c, b, 7);
    c[5] = '\n';
    puts(c);
    
    // strrev
    puts("D: ");
    strlcpy(d, c, 6);
    strrev(d);
    puts(d);
    putchar('\n');

	// itoa10
    puts("E: ");
    itoa10(-1234, e);
    puts(e);
    putchar('\n');

    puts("A: ");
    puts(a);

    breakpoint();

    puts("B: ");
    itoa10(b, e);
    puts(e);
    putchar('\n');
    itoa10(strlen(b), e);
    puts(e);
    putchar('\n');
    puts(b);

    puts("C: ");
    puts(c);

    puts("D: ");    
    puts(d);
    putchar('\n');


    if(!memcmp(a, b, 16))
    	puts("memcmp says a and b are the same!\n");
	else
    	puts("memcmp says a and b aren't the same!\n");

    if(!memcmp(c, d, 5))
    	puts("memcmp says c and d are the same!\n");
    else
    	puts("memcmp says c and d aren't the same!\n");


    return 0;
}

