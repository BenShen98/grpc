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
#include <fstream>

#include <grpcpp/grpcpp.h>

#include "file.grpc.pb.h"

#define buffersize 1048576 //in Byte (1MB)


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

    std::string PerUploadFile(Token& token,const std::string& filepath,const std::string& str="", int num=0) {
    //get file size and wait for upload
    int fileByte;
    std::ifstream f (filepath, std::ios::in|std::ios::binary|std::ios::ate);
    if (f.is_open()){
      fileByte = f.tellg();
      f.close();
    }else{
      std::cout << "Unable to open file trying to upload";
      std::exit(-1);
    }

    PerFileRequest request;
    request.set_str(str);
    request.set_filebyte(fileByte);
    request.set_num(num);

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

//https://stackoverflow.com/questions/34751873/how-to-read-huge-file-in-c
  std::string UploadFile(Token token, std::string filepath){
    ifstream bigFile(filepath);
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

  Token token;
  std::string tokenHash = file.PerUploadFile(token,"client/comarch.7z","comarch",255);
  std::cout << "file token: " << token.hash() << std::endl;






  return 0;
}
