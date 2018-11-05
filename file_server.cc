#include <iostream>
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

class FileServiceImpl final : public File::Service {

  Status UploadFile(::grpc::ServerContext* context, ::grpc::ServerReader< ::file::FileRequest>* reader, ::file::FileReply* response) override{

    //getting context
    std::string f_str,f_numstr,f_bytestr,f_bufferSizestr;
    auto cc=context->client_metadata();
    if(getVal(cc,"f_str",f_str) && getVal(cc,"f_num",f_numstr) && getVal(cc,"f_byte",f_bytestr)  && getVal(cc,"f_buffer",f_bufferSizestr) ){
        std::cout<< "server:\t\t serving "<< f_str<<", with id "<<f_numstr<<". Transferred file size "<<f_bytestr <<", with buffersize "<< f_bufferSizestr << '\n';
    }else{
      //exception, terminate file transfer
      std::cout << "server:\t\t need str num and file size to upload file" << '\n';
      return Status(StatusCode::INVALID_ARGUMENT, "Need str, num and file size to upload file\n");
    }

    //can be used in later application
    // long f_num;
    // int f_byte,f_bufferSize;
    // f_bufferSize=std::stoi(f_bufferSizestr);
    // f_num=std::stol(f_numstr);
    // f_byte=std::stoi(f_bytestr);


    //read stream
    std::ofstream outfile ("server/"+f_numstr+"."+f_str,std::ifstream::binary);
    FileRequest file;
    while (reader->Read(&file)) {
      const char *charContent=file.content().c_str();
      outfile.write(charContent,file.content().length());
    }
    outfile.close();

    //stream done
    response->set_message((std::string)"file transfer complete, stored as "+"server/"+f_numstr+"."+f_str);
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
      std::cout << "server:\t\t value for key "<<key <<" not found from context" << '\n';
      return false;
    }
  }


};

void RunServer() {
  std::string server_address("0.0.0.0:50051");
  FileServiceImpl service;
  ServerBuilder builder;
  builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
  builder.RegisterService(&service);
  std::unique_ptr<Server> server(builder.BuildAndStart());
  std::cout << "server:\t\t Server listening on " << server_address << std::endl;
  server->Wait();
}

int main(int argc, char** argv) {
  RunServer();

  return 0;
}
