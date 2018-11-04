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
#include <bitset>
#include <string>
#include <map>
#include <fstream>

#include <grpcpp/grpcpp.h>

#include "file.grpc.pb.h"

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::ServerReader;
using grpc::Status;
using grpc::StatusCode;
using file::FileRequest;
using file::FileReply;
using file::File;

// Logic and data behind the server's behavior.
class FileServiceImpl final : public File::Service {
  // Status PerUploadFile(ServerContext* context, const PerFileRequest* request, Token* token) override {
  //   int hash=PerFileHash(request->filebyte(),request->num(),request->str());
  //   std::cout << request->filebyte()<<"  |  "<<request->num()<<"  |  "<<request->str() << '\n';
  //   token->set_hash(hash);
  //   return Status::OK;
  // }

  Status UploadFile(::grpc::ServerContext* context, ::grpc::ServerReader< ::file::FileRequest>* reader, ::file::FileReply* response) override{
    //getting context
    std::string f_str,f_numstr,f_bytestr,f_bufferSizestr;
    auto cc=context->client_metadata();

    if(getVal(cc,"f_str",f_str) && getVal(cc,"f_num",f_numstr) && getVal(cc,"f_byte",f_bytestr)  && getVal(cc,"f_buffer",f_bufferSizestr) ){
        std::cout << f_str<<" | "<<f_numstr<<" | "<<f_bytestr <<" | "<< f_bufferSizestr << '\n';
    }else{
      //exception, terminate file transfer
      std::cout << "need str num and file size to upload file" << '\n';
      return Status(StatusCode::INVALID_ARGUMENT, "Need str, num and file size to upload file\n");
    }
    long f_num;
    int f_byte,f_byteRemain;
    const int f_bufferSize=std::stoi(f_bufferSizestr);
    f_num=std::stol(f_numstr);
    f_byte=std::stoi(f_bytestr);
    f_byteRemain=f_byte;

    //read stream
    std::ofstream outfile ("server/"+f_numstr+"."+f_str,std::ifstream::binary);
    // char* buffer = new char[f_buffer];

    FileRequest file;
    while (reader->Read(&file)) {
      // reader->Read(&file);
      const char *charContent=file.content().c_str();
      std::cout << "str length"<<file.content().length()<<", buffer length"<<f_bufferSize << '\n';
      // for (int i=0;i<f_bufferSize;i++){
      //   std::cout << std::bitset<8>(charContent[i]) << '\t';
      // }
      // std::cout << '\n';
      // int len=f_bufferSize;
      // if(f_byteRemain-f_bufferSize>0){
      //   //keeping count of size of bit remaining
      //   f_byteRemain=f_byteRemain-f_bufferSize;
      // }else{
      //   //reached end of file, trim the extra bit
      //   len=f_byteRemain;
      //   f_byteRemain=f_byteRemain-f_bufferSize;
      // }

      outfile.write(charContent,file.content().length());
    }
    // delete[] buffer;
    outfile.close();

    //stream done
    return Status::OK;

  }

private:
  bool getVal(const std::multimap<grpc::string_ref, grpc::string_ref>& cc,const std::string& key,std::string& result){
    auto search=cc.find(key);
    if (search != cc.end()) {
      result = search->second.data();
      result=result.substr(0,result.find('@'));
      return true;
    }else{
      std::cout << "value for key "<<key <<" not found from context" << '\n';
      return false;
    }
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
