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
#include <thread>
#include <chrono>


#include <grpcpp/grpcpp.h>

#include "file.grpc.pb.h"

//https://stackoverflow.com/questions/3033771/file-i-o-with-streams-best-memory-buffer-size
#define buffersize 5 // suggested size


using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using grpc::ClientWriter;
using file::FileRequest;
using file::FileReply;
using file::File;

class FileClient {
 public:
  FileClient(std::shared_ptr<Channel> channel)
      : stub_(File::NewStub(channel)) {}

  //   std::string PerUploadFile(Token& token,const std::string& filepath,const std::string& str="", int num=0) {
  //   //get file size and wait for upload
  //   int fileByte;
  //   std::ifstream f (filepath, std::ios::in|std::ios::binary|std::ios::ate);
  //   if (f.is_open()){
  //     fileByte = f.tellg();
  //     f.close();
  //   }else{
  //     std::cout << "Unable to open file trying to upload";
  //     std::exit(-1);
  //   }
  //
  //   PerFileRequest request;
  //   request.set_str(str);
  //   request.set_filebyte(fileByte);
  //   request.set_num(num);
  //
  //   // Context for the client. It could be used to convey extra information to
  //   // the server and/or tweak certain RPC behaviors.
  //   ClientContext context;
  //
  //   // The actual RPC.
  //   Status status = stub_->PerUploadFile(&context, request, &token);
  //
  //   // Act upon its status.
  //   if (status.ok()) {
  //     return std::to_string(token.hash());
  //   } else {
  //     std::cout << status.error_code() << ": " << status.error_message()
  //               << std::endl;
  //     return "RPC failed";
  //   }
  // }

//https://stackoverflow.com/questions/34751873/how-to-read-huge-file-in-c
  void UploadFile(const std::string& filepath,const std::string& str,int num){
    FileReply reply;
    ClientContext context;
    char * memblock;

    int fileByte;
    std::ifstream f (filepath, std::ios::in|std::ios::binary|std::ios::ate);
    if (f.is_open()){
      fileByte = f.tellg();
    }else{
      std::cout << "Unable to open file trying to upload";
      std::exit(-1);
    }
    context.AddMetadata("f_str",str);
    context.AddMetadata("f_num",std::to_string(num));
    context.AddMetadata("f_byte",std::to_string(fileByte));


    // stream start;
    memblock = new char [buffersize];
    f.seekg (0, std::ios::beg);
    std::unique_ptr<ClientWriter<FileRequest> > writer(stub_->UploadFile(&context, &reply));
    // char x[5]={0x48,0x65,0x6c,0x6c,0x6f};
    // std::string y="! Ben!";
    while (f){
      std::cout << "loop1" << '\n';
        f.read(memblock, buffersize);
        FileRequest request;
        request.set_content(memblock);
        if(!writer->Write(request)){
          break;
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    }
    delete[] memblock;

    //stream done


    writer->WritesDone();
    Status status = writer->Finish();

    if (status.ok()) {
      std::cout << "replay message: "<<reply.message() << '\n';
    }else{
      std::cout << status.error_code() << ": " << status.error_message();
      std::cout << "file rpc failed." << std::endl;
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

  // std::string tokenHash = file.PerUploadFile(token,"client/comarch.7z","comarch",255);
  // std::cout << "file token: " << token.hash() << std::endl;

  // file.UploadFile("client/comarch.7z","comarch",100);
  file.UploadFile("client/sw_cout.s","mips_sw",100);
  // file.UploadFile("client/final.s","arm_xmas",100);






  return 0;
}
