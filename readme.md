# Simple grpc file server

A basic grpc synchronous server which allows multiple clients to upload large file to the server at the same time.
The client can also send a 64 bits integer (long) and a string along with the file.
Metadata (integer, string, file information etc) are sent as context to server.
While file its self is read by std::fstream in chunks, stream to the server, assembly back together. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them

* [grpc](https://github.com/grpc/grpc/tree/master/src/cpp) 

* [Protocol Buffers v3](https://grpc.io/docs/quickstart/cpp.html#install-protocol-buffers-v3)

### Installing

A step by step series of examples that tell you how to get a development env running


```
cd to root directory of this project
run command make all
```

By running 'make all', it will generate protocol files from 'file.proto'.\
Compile server and client binary, which will be stored as 'file_client' and 'file_server' in the root directory of this project.



## Running the tests

By run 'make test', it will run the testbench in the root of this project.\
It will generate 13.6 GB of test files. Which are all under ./client and ./server folder. It was not deleted to allow confirm result manually after testbench finish.\
The current testbench will kill processes with name file_server file_client.

```
make test
```

The testbench will output log to stdout,output result to file called 'result.csv' on root of this file.\
The testbench will run 3 sections of the test:
* Test correctness for file transfer with different stream buffer size.
* Test correctness for sending large files (up to 5GB).
* Test correctness when server serves 10 clients at the same time. (With 2 heavy load and 8 light load).

### tests result

Below is what test result should look like (under [./result.csv](https://github.com/Ben20082010/grpc/blob/master/result.csv)).\
The client file and server file are stored in ./client and ./server respectively from root of this project.\
The 'cmp state' column output the exitcode for 'cmp clientfile serverfile'. Which is 0 if there is no difference.


| test name                               | cmp state | client file | server file | comment |
|-----------------------------------------|-----------|-----------------------------------|----------------------------------|---------|
| correctness with buffer size 1          | 0         | t1.bin                            | 1.bufftest                       |         |
| correctness with buffer size 2          | 0         | t1.bin                            | 2.bufftest                       |         |
| correctness with buffer size 3          | 0         | t1.bin                            | 3.bufftest                       |         |
| correctness with buffer size 4          | 0         | t1.bin                            | 4.bufftest                       |         |
| correctness with buffer size 5          | 0         | t1.bin                            | 5.bufftest                       |         |
| correctness with buffer size 6          | 0         | t1.bin                            | 6.bufftest                       |         |
| correctness with buffer size 7          | 0         | t1.bin                            | 7.bufftest                       |         |
| correctness with buffer size 8          | 0         | t1.bin                            | 8.bufftest                       |         |
| correctness with buffer size 9          | 0         | t1.bin                            | 9.bufftest                       |         |
| correctness with buffer size 10         | 0         | t1.bin                            | 10.bufftest                      |         |
| correctness with buffer size 100        | 0         | t1.bin                            | 100.bufftest                     |         |
| correctness with buffer size 1000       | 0         | t1.bin                            | 1000.bufftest                    |         |
| correctness for large file with size 1  | 0         | t2.1.bin                          | 1.largefile                      |         |
| correctness for large file with size 2  | 0         | t2.2.bin                          | 2.largefile                      |         |
| correctness for large file with size 10 | 0         | t2.10.bin                         | 10.largefile                     |         |
| correctness for multiple client (id1)   | 0         | t2.1.bin                          | 1.multiclient                    |         |
| correctness for multiple client (id2)   | 0         | t2.1.bin                          | 2.multiclient                    |         |
| correctness for multiple client (id3)   | 0         | t1.bin                            | 3.multiclient                    |         |
| correctness for multiple client (id4)   | 0         | t1.bin                            | 4.multiclient                    |         |
| correctness for multiple client (id5)   | 0         | t1.bin                            | 5.multiclient                    |         |
| correctness for multiple client (id6)   | 0         | t1.bin                            | 6.multiclient                    |         |
| correctness for multiple client (id7)   | 0         | t1.bin                            | 7.multiclient                    |         |
| correctness for multiple client (id8)   | 0         | t1.bin                            | 8.multiclient                    |         |
| correctness for multiple client (id9)   | 0         | t1.bin                            | 9.multiclient                    |         |
| correctness for multiple client (id10)  | 0         | t1.bin                            | 10.multiclient                   |         |

## Built With

* [grpc](https://grpc.io/) - The protocol used


## Acknowledgments

* The structure of this project is heavily influenced by [helloworld](https://github.com/grpc/grpc/tree/master/examples/cpp/helloworld) example from [grpc's github](https://github.com/grpc/).
* Default buffer size was chosen based on [StockOverflow question](https://stackoverflow.com/questions/3033771/file-i-o-with-streams-best-memory-buffer-size), need more testing to confirm the optimal buffer size.
* This readme file was modified from [PurpleBooth's](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2#file-readme-template-md)


