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

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using file::PerFileRequest;
using file::Token;
using file::File;

class FileClient {
 public:
  FileClient(std::shared_ptr<Channel> channel)
      : stub_(File::NewStub(channel)) {}

  // Assembles the client's payload, sends it and presents the response back
  // from the server.
  std::string PerUploadFile() {
    PerFileRequest request;
    request.set_str("file1.bin");
    request.set_filebyte(555);
    request.set_num(666);

    // Container for the data we expect from the server.
    Token token;

    // Context for the client. It could be used to convey extra information to
    // the server and/or tweak certain RPC behaviors.
    ClientContext context;

    // The actual RPC.
    Status status = stub_->PerUploadFile(&context, request, &token);

    // Act upon its status.
    if (status.ok()) {
      return std::to_string(token.hash());
    } else {
      std::cout << status.error_code() << ": " << status.error_message()
                << std::endl;
      return "RPC failed";
    }
  }

 private:
  std::unique_ptr<File::Stub> stub_;
};

int main(int argc, char** argv) {
  // Instantiate the client. It requires a channel, out of which the actual RPCs
  // are created. This channel models a connection to an endpoint (in this case,
  // localhost at port 50051). We indicate that the channel isn't authenticated
  // (use of InsecureChannelCredentials()).
  FileClient file(grpc::CreateChannel(
      "localhost:50051", grpc::InsecureChannelCredentials()));
  std::string token = file.PerUploadFile();
  std::cout << "file token: " << token << std::endl;

  return 0;
}
