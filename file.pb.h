// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: file.proto

#ifndef PROTOBUF_INCLUDED_file_2eproto
#define PROTOBUF_INCLUDED_file_2eproto

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 3006001
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 3006001 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/arena.h>
#include <google/protobuf/arenastring.h>
#include <google/protobuf/generated_message_table_driven.h>
#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/inlined_string_field.h>
#include <google/protobuf/metadata.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>  // IWYU pragma: export
#include <google/protobuf/extension_set.h>  // IWYU pragma: export
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)
#define PROTOBUF_INTERNAL_EXPORT_protobuf_file_2eproto 

namespace protobuf_file_2eproto {
// Internal implementation detail -- do not use these members.
struct TableStruct {
  static const ::google::protobuf::internal::ParseTableField entries[];
  static const ::google::protobuf::internal::AuxillaryParseTableField aux[];
  static const ::google::protobuf::internal::ParseTable schema[2];
  static const ::google::protobuf::internal::FieldMetadata field_metadata[];
  static const ::google::protobuf::internal::SerializationTable serialization_table[];
  static const ::google::protobuf::uint32 offsets[];
};
void AddDescriptors();
}  // namespace protobuf_file_2eproto
namespace file {
class FileReply;
class FileReplyDefaultTypeInternal;
extern FileReplyDefaultTypeInternal _FileReply_default_instance_;
class FileRequest;
class FileRequestDefaultTypeInternal;
extern FileRequestDefaultTypeInternal _FileRequest_default_instance_;
}  // namespace file
namespace google {
namespace protobuf {
template<> ::file::FileReply* Arena::CreateMaybeMessage<::file::FileReply>(Arena*);
template<> ::file::FileRequest* Arena::CreateMaybeMessage<::file::FileRequest>(Arena*);
}  // namespace protobuf
}  // namespace google
namespace file {

// ===================================================================

class FileRequest : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:file.FileRequest) */ {
 public:
  FileRequest();
  virtual ~FileRequest();

  FileRequest(const FileRequest& from);

  inline FileRequest& operator=(const FileRequest& from) {
    CopyFrom(from);
    return *this;
  }
  #if LANG_CXX11
  FileRequest(FileRequest&& from) noexcept
    : FileRequest() {
    *this = ::std::move(from);
  }

  inline FileRequest& operator=(FileRequest&& from) noexcept {
    if (GetArenaNoVirtual() == from.GetArenaNoVirtual()) {
      if (this != &from) InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }
  #endif
  static const ::google::protobuf::Descriptor* descriptor();
  static const FileRequest& default_instance();

  static void InitAsDefaultInstance();  // FOR INTERNAL USE ONLY
  static inline const FileRequest* internal_default_instance() {
    return reinterpret_cast<const FileRequest*>(
               &_FileRequest_default_instance_);
  }
  static constexpr int kIndexInFileMessages =
    0;

  void Swap(FileRequest* other);
  friend void swap(FileRequest& a, FileRequest& b) {
    a.Swap(&b);
  }

  // implements Message ----------------------------------------------

  inline FileRequest* New() const final {
    return CreateMaybeMessage<FileRequest>(NULL);
  }

  FileRequest* New(::google::protobuf::Arena* arena) const final {
    return CreateMaybeMessage<FileRequest>(arena);
  }
  void CopyFrom(const ::google::protobuf::Message& from) final;
  void MergeFrom(const ::google::protobuf::Message& from) final;
  void CopyFrom(const FileRequest& from);
  void MergeFrom(const FileRequest& from);
  void Clear() final;
  bool IsInitialized() const final;

  size_t ByteSizeLong() const final;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) final;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const final;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const final;
  int GetCachedSize() const final { return _cached_size_.Get(); }

  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const final;
  void InternalSwap(FileRequest* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const final;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // bytes content = 1;
  void clear_content();
  static const int kContentFieldNumber = 1;
  const ::std::string& content() const;
  void set_content(const ::std::string& value);
  #if LANG_CXX11
  void set_content(::std::string&& value);
  #endif
  void set_content(const char* value);
  void set_content(const void* value, size_t size);
  ::std::string* mutable_content();
  ::std::string* release_content();
  void set_allocated_content(::std::string* content);

  // @@protoc_insertion_point(class_scope:file.FileRequest)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::internal::ArenaStringPtr content_;
  mutable ::google::protobuf::internal::CachedSize _cached_size_;
  friend struct ::protobuf_file_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class FileReply : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:file.FileReply) */ {
 public:
  FileReply();
  virtual ~FileReply();

  FileReply(const FileReply& from);

  inline FileReply& operator=(const FileReply& from) {
    CopyFrom(from);
    return *this;
  }
  #if LANG_CXX11
  FileReply(FileReply&& from) noexcept
    : FileReply() {
    *this = ::std::move(from);
  }

  inline FileReply& operator=(FileReply&& from) noexcept {
    if (GetArenaNoVirtual() == from.GetArenaNoVirtual()) {
      if (this != &from) InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }
  #endif
  static const ::google::protobuf::Descriptor* descriptor();
  static const FileReply& default_instance();

  static void InitAsDefaultInstance();  // FOR INTERNAL USE ONLY
  static inline const FileReply* internal_default_instance() {
    return reinterpret_cast<const FileReply*>(
               &_FileReply_default_instance_);
  }
  static constexpr int kIndexInFileMessages =
    1;

  void Swap(FileReply* other);
  friend void swap(FileReply& a, FileReply& b) {
    a.Swap(&b);
  }

  // implements Message ----------------------------------------------

  inline FileReply* New() const final {
    return CreateMaybeMessage<FileReply>(NULL);
  }

  FileReply* New(::google::protobuf::Arena* arena) const final {
    return CreateMaybeMessage<FileReply>(arena);
  }
  void CopyFrom(const ::google::protobuf::Message& from) final;
  void MergeFrom(const ::google::protobuf::Message& from) final;
  void CopyFrom(const FileReply& from);
  void MergeFrom(const FileReply& from);
  void Clear() final;
  bool IsInitialized() const final;

  size_t ByteSizeLong() const final;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) final;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const final;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const final;
  int GetCachedSize() const final { return _cached_size_.Get(); }

  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const final;
  void InternalSwap(FileReply* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const final;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // string message = 1;
  void clear_message();
  static const int kMessageFieldNumber = 1;
  const ::std::string& message() const;
  void set_message(const ::std::string& value);
  #if LANG_CXX11
  void set_message(::std::string&& value);
  #endif
  void set_message(const char* value);
  void set_message(const char* value, size_t size);
  ::std::string* mutable_message();
  ::std::string* release_message();
  void set_allocated_message(::std::string* message);

  // @@protoc_insertion_point(class_scope:file.FileReply)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::internal::ArenaStringPtr message_;
  mutable ::google::protobuf::internal::CachedSize _cached_size_;
  friend struct ::protobuf_file_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#ifdef __GNUC__
  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif  // __GNUC__
// FileRequest

// bytes content = 1;
inline void FileRequest::clear_content() {
  content_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& FileRequest::content() const {
  // @@protoc_insertion_point(field_get:file.FileRequest.content)
  return content_.GetNoArena();
}
inline void FileRequest::set_content(const ::std::string& value) {
  
  content_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:file.FileRequest.content)
}
#if LANG_CXX11
inline void FileRequest::set_content(::std::string&& value) {
  
  content_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:file.FileRequest.content)
}
#endif
inline void FileRequest::set_content(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  content_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:file.FileRequest.content)
}
inline void FileRequest::set_content(const void* value, size_t size) {
  
  content_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:file.FileRequest.content)
}
inline ::std::string* FileRequest::mutable_content() {
  
  // @@protoc_insertion_point(field_mutable:file.FileRequest.content)
  return content_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* FileRequest::release_content() {
  // @@protoc_insertion_point(field_release:file.FileRequest.content)
  
  return content_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void FileRequest::set_allocated_content(::std::string* content) {
  if (content != NULL) {
    
  } else {
    
  }
  content_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), content);
  // @@protoc_insertion_point(field_set_allocated:file.FileRequest.content)
}

// -------------------------------------------------------------------

// FileReply

// string message = 1;
inline void FileReply::clear_message() {
  message_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& FileReply::message() const {
  // @@protoc_insertion_point(field_get:file.FileReply.message)
  return message_.GetNoArena();
}
inline void FileReply::set_message(const ::std::string& value) {
  
  message_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:file.FileReply.message)
}
#if LANG_CXX11
inline void FileReply::set_message(::std::string&& value) {
  
  message_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:file.FileReply.message)
}
#endif
inline void FileReply::set_message(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  message_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:file.FileReply.message)
}
inline void FileReply::set_message(const char* value, size_t size) {
  
  message_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:file.FileReply.message)
}
inline ::std::string* FileReply::mutable_message() {
  
  // @@protoc_insertion_point(field_mutable:file.FileReply.message)
  return message_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* FileReply::release_message() {
  // @@protoc_insertion_point(field_release:file.FileReply.message)
  
  return message_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void FileReply::set_allocated_message(::std::string* message) {
  if (message != NULL) {
    
  } else {
    
  }
  message_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), message);
  // @@protoc_insertion_point(field_set_allocated:file.FileReply.message)
}

#ifdef __GNUC__
  #pragma GCC diagnostic pop
#endif  // __GNUC__
// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)

}  // namespace file

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_INCLUDED_file_2eproto
