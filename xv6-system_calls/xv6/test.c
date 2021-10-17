#include<user.h>
int main() {
	char buf[512];
	int n;
	n = read(0, buf, sizeof(buf));
	write(1, buf, n);
	return 0;
}
