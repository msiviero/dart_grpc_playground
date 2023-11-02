.PHONY: build

grpc_gen_src_dir=./lib/grpc_gen

build:
	make clean
	mkdir -p build
	dart compile exe -o build/server bin/main.dart

clean:
	rm -rf build

code_gen:
	rm -rf ${grpc_gen_src_dir}
	mkdir -p ${grpc_gen_src_dir}
	protoc --dart_out=grpc:${grpc_gen_src_dir} --proto_path=./proto ./proto/*.proto
