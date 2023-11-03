.PHONY: build

grpc_gen_src_dir=./lib/grpc_gen

build:
	make clean
	make code_gen
	mkdir -p build
	dart compile exe -o build/server bin/main.dart

clean:
	rm -rf build
	rm -rf ${grpc_gen_src_dir}

code_gen:
	rm -rf ${grpc_gen_src_dir}
	mkdir -p ${grpc_gen_src_dir}
	dart run build_runner build
	protoc --dart_out=grpc:${grpc_gen_src_dir} --proto_path=./proto ./proto/*.proto

migrate:
	migrate -path database/migration/ -database "mysql://root:example@tcp(127.0.0.1:3306)/dart_playground?query" -verbose up

grpc_ui:
	grpcui -plaintext -import-path=./proto -proto=user_route.proto 127.0.0.1:50051

grpc_load_test:
	ghz --insecure \
		--proto ./proto/user_route.proto \
		--call  UserRoute.GetUsers \
		-m      '{"trace_id":"{{.RequestNumber}}", "timestamp":"{{.TimestampUnixNano}}"}' \
		--total 10000 \
		-O html \
		0.0.0.0:50051 > load_test.html
