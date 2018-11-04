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
#include <bitset>


#include <grpcpp/grpcpp.h>

#include "file.grpc.pb.h"

//https://stackoverflow.com/questions/3033771/file-i-o-with-streams-best-memory-buffer-size

//NOTE:: GRPC SEND MIN OF 6 BYTES, SERVER RECEIVE EXTRA BIT, TRIM
#define defaultbuffersize 1 // suggested size


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

  void UploadFile(const std::string& filepath,const std::string& str,const long num,const int buffersize){
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
    context.AddMetadata("f_buffer",std::to_string(buffersize));


    // stream start;
    memblock = new char [buffersize];
    f.seekg (0, std::ios::beg);
    std::unique_ptr<ClientWriter<FileRequest> > writer(stub_->UploadFile(&context, &reply));
    // char x[5]={0x48,0x65,0x6c,0x6c,0x6f};
    // std::string y="! Ben!";
    int size=buffersize;
    while (f){
        std::cout << "enter loop" << '\b';
        f.read(memblock, buffersize);
        // for(int i=0;i<buffersize;i++){
        //   std::cout << std::bitset<8>(memblock[i]) << '\t';
        // }
        // std::cout << '\n';
        if(f.eof()){
          //adjust file size for the last steam, may not use all buffer
          size=fileByte%buffersize;
        }
        FileRequest request;
        //NEED SIZE, AS STRING WILL CONTAIN 0X00 (NULL), CAUSE CORRUPTED FILE
        std::string s(memblock, size);
        request.set_content(s);
        if(!writer->Write(request)){
          break;
        }

        // std::this_thread::sleep_for(std::chrono::milliseconds(1000));
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
  if(argc<4 || argc>5 ){
    std::cout << "client: missing arguement.\n------ need file path, string, number, [optional buffersize]" << '\n';
    return -1;
  }

  FileClient file(grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials()));

  std::string path=argv[1];
  std::string str=argv[2];
  long num=std::stol(argv[3]);

  if(argc==4){
    file.UploadFile(path,str,num,defaultbuffersize);
  }else{
    file.UploadFile(path,str,num,std::stoi(argv[4]));
  }
  return 0;
}
