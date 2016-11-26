int main() {
	char buf[1024];

	read(0,buf,1024);
	((void(*)())buf)();
}
