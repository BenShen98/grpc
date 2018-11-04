#define buffersize 10
#include <iostream>
#include <fstream>



int main(){
  int fileByte;

  std::ifstream f (filepath, std::ios::in|std::ios::binary|std::ios::ate);


  if (f.is_open()){
    fileByte = f.tellg();
  }else{
    std::cout << "client: Unable to open file trying to upload";
    std::exit(-1);
  }


  // stream start;
  memblock = new char [buffersize];
  f.seekg (0, std::ios::beg);
  std::unique_ptr<ClientWriter<FileRequest> > writer(stub_->UploadFile(&context, &reply));
  while (f){
      f.read(memblock, buffersize);
      FileRequest request;
      request.set_content(memblock);
      if(!writer->Write(request)){
        break;
      }

      // std::this_thread::sleep_for(std::chrono::milliseconds(1000));
  }
  delete[] memblock;
}
