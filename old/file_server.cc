/*
 *
 * Copyright 2015 gRPC authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#include <iostream>
#include <memory>
#include <string>

#include <grpcpp/grpcpp.h>

#include "file.grpc.pb.h"

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;
using file::PerFileRequest;
using file::Token;
using file::File;

struct PerFile {
  long num;
  std::string str;
  int fileByte;
};

inline long PerFileHash(int fileByte, long num,std::string str){
  return (num<<32) ^ std::hash<std::string>{}(str) ^ (num<<1);
}


// struct PerFileHash
// {
//     typedef S argument_type;
//     typedef std::size_t result_type;
//     result_type operator()(argument_type const& s) const noexcept
//     {
//         result_type const h1 ( std::hash<std::string>{}(s.first_name) );
//         result_type const h2 ( std::hash<std::string>{}(s.last_name) );
//         return h1 ^ (h2 << 1); // or use boost::hash_combine (see Discussion)
//     }
// };

// Logic and data behind the server's behavior.
class FileServiceImpl final : public File::Service {
  Status PerUploadFile(ServerContext* context, const PerFileRequest* request, Token* token) override {
    int hash=PerFileHash(request->filebyte(),request->num(),request->str());
    std::cout << request->filebyte()<<"  |  "<<request->num()<<"  |  "<<request->str() << '\n';
    token->set_hash(hash);
    return Status::OK;
  }

};

void RunServer() {
  std::string server_address("0.0.0.0:50051");
  FileServiceImpl service;

  ServerBuilder builder;
  // Listen on the given address without any authentication mechanism.
  builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
  // Register "service" as the instance through which we'll communicate with
  // clients. In this case it corresponds to an *synchronous* service.
  builder.RegisterService(&service);
  // Finally assemble the server.
  std::unique_ptr<Server> server(builder.BuildAndStart());
  std::cout << "Server listening on " << server_address << std::endl;

  // Wait for the server to shutdown. Note that some other thread must be
  // responsible for shutting down the server for this call to ever return.
  server->Wait();
}

int main(int argc, char** argv) {
  RunServer();

  return 0;
}
