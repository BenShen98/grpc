#include <iostream>
#include <string>
#include <fstream>

#include <grpcpp/grpcpp.h>

#include "file.grpc.pb.h"

#define defaultbuffersize 4096 // suggested size by https://stackoverflow.com/questions/3033771/file-i-o-with-streams-best-memory-buffer-size

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

    //open file and prepare meta data
    int fileByte;
    std::ifstream f (filepath, std::ios::in|std::ios::binary|std::ios::ate);
    if (f.is_open()){
      fileByte = f.tellg();
    }else{
      std::cout << "client:\t\t Unable to open file trying to upload";
      std::exit(-1);
    }
    context.AddMetadata("f_str",str);
    context.AddMetadata("f_num",std::to_string(num));
    context.AddMetadata("f_byte",std::to_string(fileByte));
    context.AddMetadata("f_buffer",std::to_string(buffersize));


    // file stream start
    memblock = new char [buffersize];
    f.seekg (0, std::ios::beg);
    std::unique_ptr<ClientWriter<FileRequest> > writer(stub_->UploadFile(&context, &reply));
    int size=buffersize;
    while (f){
        f.read(memblock, buffersize);
        if(f.eof()){
          //adjust "content" size for the last steam, it may be smaller than the buffer size
          size=fileByte%buffersize;
        }
        FileRequest request;
        //NEED SIZE. Without size, if char* contain 0x00, it will be treated as EOF, cause incomplete byte transfer
        std::string s(memblock, size);
        request.set_content(s);
        if(!writer->Write(request)){
          break;
        }
    }
    delete[] memblock;

    //stream done
    writer->WritesDone();
    Status status = writer->Finish();

    //waiting server to reply
    if (status.ok()) {
      std::cout << "client:\t\t replay message: "<<reply.message() << '\n';
    }else{
      std::cout <<"client:\t\t "<< status.error_code() << ": " << status.error_message();
      std::cout << "client:\t\t file rpc failed." << std::endl;
    }
  }

 private:
  std::unique_ptr<File::Stub> stub_;
};

int main(int argc, char** argv) {

  // --help
  if(argc<4 || argc>5 ){
    std::cout << "client:\t\t missing arguement.\n------ need file path, string, number, [optional buffersize]" << '\n';
    return -1;
  }

  //get arguement
  std::string path=argv[1];
  std::string str=argv[2];
  long num=std::stol(argv[3]);

  //connect to server for upload
  FileClient file(grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials()));
  if(argc==4){
    //when arg does not conatin buffer size
    file.UploadFile(path,str,num,defaultbuffersize);
  }else{
    //when arg conatin buffer size
    file.UploadFile(path,str,num,std::stoi(argv[4]));
  }

  return 0;
}
